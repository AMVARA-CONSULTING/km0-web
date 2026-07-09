---
title: "Dia 15 - Registre OpenCloud: token Graph caducat i renovació automàtica"
description: "Un token Graph caducat va bloquejar el registre per email a KM0 Cloud; documentem la causa, la rotació segura del token register-api i els errors trobats en automatitzar la renovació."
pubDate: 2026-07-04
locale: ca
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">El <strong>dia 15</strong> tornem a infraestructura operativa al projecte germà <a href="https://github.com/AMVARA-CONSULTING/km0-opencloud">km0-opencloud</a>. El 4 de juliol de 2026 un usuari va intentar registrar-se amb email i contrasenya a <a href="https://cloud.km0digital.com/register.html">KM0 Cloud</a> i va veure un error genèric. Google OAuth seguia funcionant. La causa: el <strong>token Graph de register-api havia caducat</strong>.</p>
  <p class="doc-lead">Al <a href="https://github.com/AMVARA-CONSULTING/km0-opencloud/issues/17">issue #17</a> vam implementar rotació manual, renovació automàtica segura i vam corregir dos defectes que el tester va trobar en validar l'script. Aquest article explica què va passar, per què importa i què ha quedat automatitzat.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Incident</p>
  <h2 class="doc-block-heading">Què va veure l'usuari</h2>
  <p class="doc-block-intro">El formulari va mostrar el missatge genèric «No s'ha pogut crear el compte. Torna-ho a provar més tard.» sense indicar que el servei estava temporalment caigut. Més tard el mateix usuari va entrar amb <strong>Google OAuth</strong> sense problema.</p>
  <ul class="doc-list">
    <li><strong>Causa arrel:</strong> <code>GRAPH_SERVICE_APP_TOKEN</code> de register-api caducat o invàlid; Graph rebutjava les credencials.</li>
    <li><strong>Evidència:</strong> <code>GET /health</code> retornava <code>graph_auth_ok: false</code>; <code>POST /api/register</code> responia HTTP 503.</li>
    <li><strong>OAuth intacte:</strong> l'accés amb Google usa Dex + OIDC, no register-api; un camí funcionava i l'altre no.</li>
    <li><strong>Context previ:</strong> l'<a href="https://github.com/AMVARA-CONSULTING/km0-opencloud/issues/16">issue #16</a> ja havia millorat els missatges d'error del formulari; aquest dia ataquem la causa operativa del 503.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Motiu</p>
  <h2 class="doc-block-heading">Per què register-api necessita un token</h2>
  <p class="doc-block-intro">El registre email/contrasenya a <a href="https://cloud.km0digital.com/">KM0 Cloud</a> passa per un sidecar, <strong>register-api</strong>, que crea usuaris via OpenCloud Graph (<code>POST /graph/v1.0/users</code>). En producció Graph no accepta Basic auth amb contrasenya; register-api s'ha d'autenticar amb un <strong>Graph App Token</strong> dedicat.</p>
  <div class="doc-callout">
    <span class="doc-callout-title">Secret operatiu</span>
    <p>Aquest token és un secret amb data de caducitat. Si caduca i ningú el renova, el registre manual cau en silenci mentre OAuth segueix viu. Cal tractar-lo com a credencial d'infraestructura, no com a configuració «posar una vegada i oblidar».</p>
  </div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Implementació</p>
  <h2 class="doc-block-heading">Rotació i auto-renovació (issue #17)</h2>
  <ul class="doc-list">
    <li><strong>Política:</strong> token dedicat només per a register-api, caducitat de <strong>3 mesos</strong>, renovació automàtica quan quedin menys de <strong>14 dies</strong>.</li>
    <li><strong><code>setup-register-api-graph-token.sh</code>:</strong> crea el token amb <code>--expires-in 90d</code>, escriu <code>GRAPH_SERVICE_APP_TOKEN</code> i <code>GRAPH_SERVICE_APP_TOKEN_EXPIRES_AT</code> a <code>register-api/.env</code>.</li>
    <li><strong><code>renew-register-api-graph-token.sh</code>:</strong> comprova salut i data; renova si <code>graph_auth_ok</code> és false o falta marge; reinicia <strong>només register-api</strong>; verifica <code>/health</code>.</li>
    <li><strong>Cron:</strong> plantilla setmanal (dilluns 03:00 UTC) a <code>register-api-token-renewal.cron</code>.</li>
    <li><strong>Seguretat:</strong> el procés mai toca usuaris, volums, Dex/OIDC, bases de dades ni la resta del <code>.env</code> d'OpenCloud.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Errors trobats</p>
  <h2 class="doc-block-heading">El que va fallar en provar l'automatització</h2>
  <p class="doc-block-intro">La primera versió de l'script de renovació va passar proves manuals bàsiques, però el tester va trobar dos defectes en executar escenaris reals de cron i renovació forçada.</p>
  <ul class="doc-list">
    <li><strong>Usuari Graph incorrecte:</strong> l'script de renovació no propagava <code>GRAPH_SERVICE_USER</code> des de <code>register-api/.env</code>. El setup generava el token per a l'usuari per defecte (<code>admin</code>) en lloc de l'operador configurat. <strong>Fix:</strong> llegir <code>GRAPH_SERVICE_USER</code> del <code>.env</code> i passar-lo amb <code>--user</code> al setup.</li>
    <li><strong>Carrera després del reinici:</strong> <code>verify-register-api.sh</code> s'executava immediatament després de <code>docker compose up</code> i fallava perquè register-api encara no havia arrencat del tot. <strong>Fix:</strong> espera activa fins a 30 s (<code>REGISTER_API_HEALTH_WAIT_SEC</code>) comprovant <code>graph_auth_ok: true</code> abans de verificar.</li>
  </ul>
  <p>Després d'aquests canvis, els escenaris de «skip», renovació forçada i llindar de 7 dies van sortir amb exit code 0 i <code>graph_auth_ok: true</code>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Límits</p>
  <h2 class="doc-block-heading">Què mai ha de fer la renovació</h2>
  <p class="doc-block-intro">Documentem límits explícits al runbook de km0-opencloud perquè un script automatitzat no pugui danyar producció.</p>
  <ul class="doc-list">
    <li>No executar <code>docker compose down -v</code>, <code>docker volume rm</code> ni comandes de reset d'usuaris OpenCloud.</li>
    <li>No modificar Dex, OIDC, emmagatzematge, bases de dades ni grups existents.</li>
    <li>Només actualitzar el token de register-api, reiniciar aquest contenidor i comprovar salut.</li>
    <li>Si la renovació falla, Google OAuth i les dades d'usuaris existents queden intactes.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">KM0</p>
  <h2 class="doc-block-heading">Per què ho expliquem al blog</h2>
  <p class="doc-block-intro">KM0 promet serveis propers i operables: cloud, correu i web sota el teu control. Un token caducat és un recordatori que <strong>l'operació importa tant com el desplegament</strong>.</p>
  <ul class="doc-list">
    <li><strong>Transparència:</strong> si el registre email falla, ara hi ha missatges tipats (issue #16) i procediment de rotació documentat.</li>
    <li><strong>Automatització segura:</strong> renovació setmanal amb abast mínim, no «scripts heroics» que reinicien tot el stack.</li>
    <li><strong>Sèrie:</strong> el <a href="/ca/doc/day-14/">dia 14</a> parlava d'IA i burocràcia; aquí la burocràcia és un token amb data de caducitat i un cron que el renova abans que l'usuari ho noti.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verificació</p>
  <h2 class="doc-block-heading">Comprovar el registre</h2>
  <ol class="doc-steps">
    <li><strong>Salut:</strong> els operadors poden executar <code>./scripts/verify-register-api.sh</code> a km0-opencloud i confirmar <code>graph_auth_ok: true</code>.</li>
    <li><strong>Registre:</strong> provar <a href="https://cloud.km0digital.com/register.html">registre email/contrasenya</a> o entrar amb Google si ja tens compte.</li>
    <li><strong>Sèrie:</strong> llegir el <a href="/ca/doc/day-14/">dia 14</a> (Harari i IA) i el <a href="/ca/doc/day-11/">dia 11</a> (KM0 Mail).</li>
    <li><strong>Idees:</strong> explica'ns per <a href="/ca/ideas/">formulari d'idees</a> o <a href="/ca/#contact">contacte</a> si vols més entrades sobre operació de KM0 Cloud.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Sèrie</p>
  <h2 class="doc-block-heading">Dies anteriors</h2>
  <p class="doc-closing">El <a href="/ca/doc/day-14/">dia 14</a> va resumir el vídeo de Harari sobre IA i civilització; el <a href="/ca/doc/day-13/">dia 13</a> el meet 6 sobre visibilitat; el <a href="/ca/doc/day-11/">dia 11</a> va documentar KM0 Mail. El <a href="/ca/doc/day-16/">dia 16</a> anuncia la trobada a El Masnou sobre IA, burocràcia i Palantir. Segueix la sèrie i prova <a href="https://cloud.km0digital.com/">KM0 Cloud</a> quan vulguis.</p>
</section>
