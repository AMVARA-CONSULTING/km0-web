---
title: "Dia 2 — OpenCloud 7, Dex OIDC i còpia integral"
description: "Actualització a OpenCloud 7.0.0, broker OIDC Dex amb Google i Apple, ajustos Nginx, primera còpia integral i documentació operativa."
pubDate: 2026-05-22
locale: ca
---

<div class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">El dia 2 (22 de maig de 2026) se centra en el <strong>perímetre d'autenticació</strong> i en madurar l'stack OpenCloud ja desplegat el dia anterior: actualització de versió, broker OIDC amb Dex (Google i Apple), ajustos de Nginx, primera còpia integral i documentació operativa.</p>
  <p class="doc-lead">El desplegament inicial (Debian, Docker, TLS, hostnames separats) va quedar tancat el 21; avui es treballa sobre aquesta base en producció a <a href="https://cloud.km0.amvara.de">cloud.km0.amvara.de</a>.</p>
</div>

<div class="doc-block">
  <p class="doc-block-title">Estat</p>
  <h2 class="doc-block-heading">Components verificats en tancar</h2>
  <ul class="doc-list">
    <li><strong>OpenCloud:</strong> <code>opencloudeu/opencloud-rolling:7.0.0</code> a <code>127.0.0.1:9200</code>.</li>
    <li><strong>Dex (OIDC):</strong> <code>ghcr.io/dexidp/dex:v2.41.1</code> a <code>127.0.0.1:5556</code>.</li>
    <li><strong>Nginx vhost:</strong> <code>/etc/nginx/sites-available/opencloud</code> — TLS → <code>/dex/</code> + <code>/</code>.</li>
    <li><strong>OC_DOMAIN:</strong> <code>cloud.km0.amvara.de</code> amb <code>INSECURE=false</code>.</li>
    <li><strong>Emissor Dex:</strong> <code>https://cloud.km0.amvara.de/dex</code> — connectors Google + Apple.</li>
  </ul>
  <p>Comprovacions habituals: <code>docker compose ps</code>, <code>nginx -t</code> i capçaleres HTTP contra la URL pública del cloud.</p>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Arquitectura</p>
  <h2 class="doc-block-heading">Autenticació + aplicació</h2>
  <div class="doc-note"><pre>Browser ── HTTPS :443 cloud.km0.amvara.de ── Nginx
              ├─ /dex/         → Dex        127.0.0.1:5556
              ├─ /login.html   → /var/www/opencloud-auth/
              └─ /             → OpenCloud  127.0.0.1:9200
                                    └─ volums opencloud_* + dex_dex-data</pre></div>
  <p>La web corporativa al mateix host continua en un altre virtual host: <a href="https://km0.amvara.de/">km0.amvara.de</a> → contenidor estàtic en loopback.</p>
</div>

<div class="doc-block">
  <p class="doc-block-title">Actualització</p>
  <h2 class="doc-block-heading">OpenCloud 6.2.0 → 7.0.0</h2>
  <ul class="doc-list">
    <li>Es va demanar acostar-se a la branca 7.0.1; la imatge <strong>7.0.0</strong> va ser l'etiqueta aplicada i validada (7.0.1 no es va desplegar per no estar disponible o validada).</li>
    <li>Variable <code>OC_DOCKER_TAG=7.0.0</code> a <code>/opt/opencloud/opencloud-compose/.env</code>.</li>
    <li>Correcció a <code>opencloud.yaml</code> runtime: entrada <code>sharing.service_account</code> requerida a OpenCloud 7.x.</li>
    <li>Reinici controlat: <code>docker compose pull && docker compose up -d</code>.</li>
    <li>Revisió de logs en nivells <code>fatal</code>/<code>error</code>; servei deixat en marxa.</li>
  </ul>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">OIDC</p>
  <h2 class="doc-block-heading">Multi-proveïdor amb Dex (Google + Apple)</h2>
  <p class="doc-block-intro">Es va descartar l'experiment ad hoc amb Keycloak (plantilles nginx sota <code>keycloak*.conf</code> no habilitades) en favor d'un broker Dex lleuger a <code>/opt/opencloud/dex/</code>:</p>
  <ul class="doc-list">
    <li><strong>docker-compose.yml:</strong> servei Dex, volum <code>dex_dex-data</code>, publicació només en loopback :5556.</li>
    <li><strong>config.yaml:</strong> emissor, SQLite, clients OAuth2, connectors.</li>
    <li><strong>web/themes/km0/:</strong> UI de login amb marca KM0 (logo, CSS, i18n CA/ES/EN).</li>
    <li><strong>setup-apple.sh:</strong> genera JWT de client Apple (~180 dies).</li>
  </ul>
  <p>OpenCloud queda amb emissor extern (<code>OC_OIDC_ISSUER</code> → <code>/dex</code>, client <code>opencloud-web</code>). <code>alwaysShowLoginScreen: true</code> força el selector Google vs Apple.</p>
</div>

<div class="doc-block">
  <p class="doc-block-title">Entrades públiques</p>
  <h2 class="doc-block-heading">URLs d'accés</h2>
  <ul class="doc-list">
    <li><strong><a href="https://cloud.km0.amvara.de/">cloud.km0.amvara.de/</a>:</strong> interfície web OpenCloud.</li>
    <li><strong><a href="https://cloud.km0.amvara.de/dex/">/dex/</a>:</strong> emissor OIDC / login Dex.</li>
    <li><strong><a href="https://cloud.km0.amvara.de/login.html">/login.html</a>:</strong> selector estàtic Google / Apple.</li>
  </ul>
  <div class="doc-note">Redirect URI a Google Cloud Console: <code>https://cloud.km0.amvara.de/dex/callback</code>. Credencials Apple sota <code>/opt/</code> — sense detallar secrets aquí.</div>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Nginx</p>
  <h2 class="doc-block-heading">Integració al vhost OpenCloud</h2>
  <ul class="doc-list">
    <li><strong>location /dex/:</strong> → <code>http://127.0.0.1:5556/dex/</code> amb capçaleres reenviades per a OIDC.</li>
    <li><strong>location = /login.html:</strong> fitxer estàtic a <code>/var/www/opencloud-auth/login.html</code>.</li>
    <li><strong>location /:</strong> OpenCloud al :9200 mantenint SSE, TUS i WebSockets del dia 1.</li>
  </ul>
  <p>Amb <code>INSECURE=false</code> i FQDN estable, l'stack abandona el mode laboratori relaxat.</p>
</div>

<div class="doc-block">
  <p class="doc-block-title">Compose</p>
  <h2 class="doc-block-heading">Resolució DNS al contenidor</h2>
  <p class="doc-block-intro">A <code>external-proxy/opencloud.yml</code> es va afegir <code>extra_hosts: ${OC_DOMAIN}:host-gateway</code> perquè el contenidor resolgui el hostname públic com l'host. Sense això poden aparèixer fallades de login després d'OAuth de Google (<code>access-denied</code> o sessions incoherents).</p>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Còpia de seguretat</p>
  <h2 class="doc-block-heading">Primera còpia integral de la instal·lació</h2>
  <p class="doc-block-intro">Script: <code>/opt/opencloud/scripts/backup-opencloud-installation.sh</code>. Primera execució: 2026-05-22 19:51 → <code>/opt/backup_opencloud_installation/20260522-195106/</code> amb enllaç <code>latest</code>.</p>
  <ul class="doc-list">
    <li><strong>opt-opencloud/:</strong> arbre complet <code>/opt/opencloud/</code>.</li>
    <li><strong>host-nginx/:</strong> vhost actiu + plantilles del repo.</li>
    <li><strong>letsencrypt/:</strong> TLS del hostname del cloud.</li>
    <li><strong>docker-volumes/:</strong> tarballs <code>opencloud-data</code>, <code>opencloud-config</code>, <code>dex-data</code>.</li>
    <li><strong>manifest/:</strong> snapshot de runtime i log de la còpia.</li>
  </ul>
  <div class="doc-note">No inclou el vhost de la web corporativa km0 ni altres stacks aliens a OpenCloud.</div>
</div>

<div class="doc-block">
  <p class="doc-block-title">Incidències</p>
  <h2 class="doc-block-heading">Símptomes i remeis documentats</h2>
  <ul class="doc-list">
    <li><strong>GET .../photo/$value 404:</strong> sense avatar pujat — soroll benign a la consola.</li>
    <li><strong>502 en URLs antigues /signin/:</strong> sessió obsoleta abans del tall Dex — netejar dades del lloc o finestra privada.</li>
    <li><strong>access-denied després del login Google:</strong> llista blanca a <code>role_assignment</code> o DNS — fer servir <code>driver: default</code> o <code>extra_hosts</code>.</li>
    <li><strong>Dex en bucle de reinici:</strong> revisar <code>docker logs</code>; validar JSON de proveïdors a <code>/opt/</code>.</li>
  </ul>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Investigació</p>
  <h2 class="doc-block-heading">Sense desplegament avui</h2>
  <ul class="doc-list">
    <li><strong>Collabora / WOPI:</strong> revisió d'edició Office al navegador — mantenir només core; possible addon futur.</li>
    <li><strong>Apache HTTP Server:</strong> confirmat que no s'utilitza (només Nginx). Apache Tika en docs upstream no desplegat.</li>
    <li><strong>Branding OpenCloud Web:</strong> overlay KM0 revertit el 21 de maig; branding KM0 al login Dex es manté.</li>
  </ul>
</div>

<div class="doc-closing-block">
  <p class="doc-block-title">Pendents</p>
  <h2 class="doc-block-heading">Següents passos</h2>
  <p class="doc-closing">Valorar OpenCloud 7.0.1 quan la imatge estigui validada, completar Apple Sign In si falta, instal·lar cron per a la còpia integral i revisar la rotació de l'accés administratiu. Explora els <a href="/ca/#services">serveis</a> o <a href="/ca/#contact">escriu-nos</a> per col·laborar.</p>
</div>
