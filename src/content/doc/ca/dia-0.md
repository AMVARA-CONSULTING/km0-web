---
title: "Dia 0 — Fonaments del servidor"
description: "Debian, particions, Docker, Nginx i base reproducible: el dia dedicat a fer l'stack KM0 auditable i operable."
pubDate: 2026-05-21
locale: ca
---

<p class="doc-lead">El dia 0 està dedicat als <strong>fonaments</strong>: sense una base reproducible del sistema operatiu i de l'entorn de treball, qualsevol stack posterior seria fràgil i difícil d'auditar. L'objectiu és sortir del dia amb Debian estable, disc ordenat, eines mínimes però suficients i una consola que convidi a documentar cada canvi.</p>

## Pla tècnic de l'arrencada (visió completa)

<p>KM0 persegueix una infraestructura que pugui ser operada per persones de l'equip sense dependre de panells propietaris opacs:</p>

<ul class="doc-list">
  <li><strong>Sistema:</strong> VPS amb Debian actualitzat, esquema de particions que separa sistema de dades quan té sentit al projecte (facilita snapshots i polítiques de còpia de seguretat).</li>
  <li><strong>Col·laboració:</strong> <a href="https://cloud.km0.amvara.de">OpenCloud</a> desplegat com a conjunt de microserveis coordinats dins d'una imatge oficial mantinguda per la comunitat <a href="https://opencloud.eu">OpenCloud.eu</a>, amb volums nomenats de forma estable (<code>COMPOSE_PROJECT_NAME</code>) perquè les còpies no depenguin del directori des del qual s'executa Compose.</li>
  <li><strong>Perímetre:</strong> Nginx com a únic frontal HTTPS; overlays Docker que publiquen HTTP només a <code>127.0.0.1</code>.</li>
  <li><strong>Comunicació:</strong> Lloc Astro dockeritzat servint estàtics en un altre port loopback; virtual hosts independents per a màrqueting (<code>km0.amvara.de</code>) i cloud (<code>cloud.km0.amvara.de</code>).</li>
  <li><strong>Observabilitat:</strong> logs de contenidor rotats (<code>json-file</code> amb mida màxima), ordres habituals documentades en runbooks (<code>docker compose ps</code>, <code>logs</code>, <code>pull</code>), còpies de volums com a artefactes comprimits.</li>
  <li><strong>Evolució:</strong> endureir TLS entre microserveis interns quan els certificats siguin totalment fiables en cadena, automatitzar còpies de seguretat i endureir polítiques Fail2ban per jails específics.</li>
</ul>

## Provisionament del VPS i particions

<p>Es va triar un servidor amb <strong>Debian</strong> per la predictibilitat del cicle de paquets i l'amplia documentació per a administració manual (sense panells obligatoris). El primer pas va ser revisar el layout del disc i crear particions coherents amb l'ús previst:</p>

<ul class="doc-list">
  <li>Separació que permeti créixer dades del projecte sense barrejar-les amb el sistema de fitxers arrel quan calgui fer còpia per volum.</li>
  <li>Criteris clars per a muntatges: <code>/var/lib/docker</code> pot concentrar l'I/O d'OpenCloud segons la mida del VPS.</li>
  <li>Convencions documentades perquè qualsevol persona de l'equip reconegui quin muntatge correspon a dades persistents o al sistema.</li>
</ul>

<div class="doc-note">Els detalls exactes del mapa de particions són específics del proveïdor i de la mida contractada; el que importa és que quedin documentats fora del blog a la wiki o runbook del projecte per a recuperació davant fallades.</div>

## Programari base

<p>Es va instal·lar el conjunt mínim raonable per a administració segura remota i per construir sobre Docker sense “pes mort” innecessari:</p>

<ul class="doc-list">
  <li>Eines de sistema habituals: <code>curl</code>, editors, utilitats de xarxa i diagnòstic.</li>
  <li><strong>Docker Engine</strong> amb política de logs rotatius (<code>/etc/docker/daemon.json</code>) perquè els registres no ocupin tot el disc.</li>
  <li><strong>Nginx</strong> des de paquets del sistema com a frontal estable.</li>
  <li><strong>Certbot</strong> i estratègia TLS segons la fase del projecte (emissió HTTP-01 o certificat autofirmat per a laboratori).</li>
</ul>

<p>La filosofia és que cada component té un rol únic i observable a l'arbre de dependències del sistema: <code>systemctl status</code>, <code>nginx -t</code>, <code>docker compose ps</code>.</p>

<hr />

## Ergonòmica del shell i configuració reproducible

<p>Perquè les sessions SSH posteriors siguin consistents es van aplicar millores guiades per la documentació interna <a href="https://wiki.ldeluipy.es/initialConfiguration.html">initialConfiguration</a> del wiki:</p>

<ul class="doc-list">
  <li>Prompt de Bash més llegible (directori actual, estat de l'ordre, pistes visuals).</li>
  <li>Ajustos que redueixen errors repetits (historial útil, opcions segures per defecte on calgui).</li>
  <li>Convencions per a àlies i <code>PATH</code> que anticipen el treball amb Docker Compose i Git des de <code>/opt/...</code>.</li>
</ul>

<p>Tenir aquesta base escrita fora del servidor permet repetir el mateix motlle en altres VPS del projecte sense improvisar cada vegada.</p>

## cursor-agent

<div class="doc-callout">
  <span class="doc-callout-title">Assistència a la línia d'ordres</span>
  <p>Es va instal·lar <strong>cursor-agent</strong> per acostar el flux de treball del dia a dia al de l'entorn de desenvolupament assistit: revisions automatitzades, generació de scripts auxiliars i documentació incremental sense abandonar la consola del servidor.</p>
  <p>No substitueix la revisió humana ni els controls de canvi de l'equip, però redueix fricció quan cal repetir tasques verificables (actualitzar overlays de Compose, validar sintaxi de Nginx abans de recarregar, etc.).</p>
</div>

## Estat al tancament del dia 0

<p>En acabar el dia el servidor compleix tres propietats:</p>

<ol class="doc-steps">
  <li><strong>És auditable:</strong> layout de disc i paquets coneguts.</li>
  <li><strong>És repetible:</strong> els passos principals enllacen amb wiki i runbooks.</li>
  <li><strong>Està llest</strong> per a càrregues Docker sense exposar serveis prematurament al públic.</li>
</ol>

<div class="doc-closing">
  El <strong>dia 1</strong> aprofita aquesta base per materialitzar OpenCloud, el virtual host del proxy i la web KM0 ja enllaçades per TLS. Mentrestant, pots explorar els <a href="/ca/#servicios">serveis</a> publicats o <a href="/ca/#contacto">escriure'ns</a> si vols col·laborar.
</div>
