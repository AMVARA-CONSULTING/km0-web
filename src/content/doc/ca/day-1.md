---
title: "Dia 1 — OpenCloud, proxy i web del projecte"
description: "OpenCloud en Docker Compose, Nginx amb TLS en loopback, Fail2ban, subdomini cloud i la landing Astro KM0 publicada com a segon backend."
pubDate: 2026-05-21
locale: ca
---

<div class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">El dia 1 converteix la base Debian en una plataforma completa: <strong>OpenCloud</strong> sobre Docker Compose amb overlays oficials, Nginx que finalitza TLS i encamina només al loopback, polítiques de firewall coherents i la landing Astro del projecte publicada com a segon backend darrere del mateix frontal.</p>
  <p class="doc-lead">També s'introdueixen millores posteriors al primer tall — Fail2ban i el subdomini dedicat del cloud — perquè formen part del relat operatiu real del desplegament.</p>
</div>

<div class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Core sense Collabora/WOPI</h2>
  <p class="doc-block-intro">El mode triat arrenca OpenCloud com a servei únic des de la composició oficial (<code>opencloud-eu/opencloud-compose</code>), amb una imatge rodant etiquetada (<code>opencloud-rolling</code> amb tag fixat en desplegament) per poder actualitzar de forma deliberada (<code>docker compose pull</code> + finestra de manteniment).</p>
  <ul class="doc-list">
    <li><strong>Overlay external-proxy:</strong> adapta variables com <code>PROXY_HTTP_ADDR</code> per escoltar dins del contenidor i publicar el port HTTP del proxy només com a <code>127.0.0.1:&lt;port&gt;</code> a l'host.</li>
    <li><strong>COMPOSE_PROJECT_NAME=opencloud:</strong> ancora els noms de volum Docker sense dependre del cwd.</li>
    <li><strong>Fitxer .env:</strong> font única de variables de desplegament; permisos estrictes en disc i fora del control de versions.</li>
    <li><strong>COMPOSE_FILE:</strong> llista els overlays necessaris (base més overlay de proxy extern).</li>
  </ul>
  <p>Dins del contenidor coexisteixen microserveis que conversen per gRPC/HTTP en localhost intern; aquest rang no s'exposa directament a l'host excepte pels endpoints previstos pel chart upstream.</p>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Arquitectura</p>
  <h2 class="doc-block-heading">OpenCloud darrere del proxy</h2>
  <div class="doc-note"><pre>Browser
   │  HTTPS :443
   ▼
Nginx (Debian, site dedicat OpenCloud)
   │  HTTP http://127.0.0.1:9200  (només loopback)
   ▼
Contenidor OpenCloud (UID/GID fix)
   │  microserveis interns ~9140–9300
   ▼
Volums Docker:
   • opencloud-data   → fitxers, índexs, NATS, IDM...
   • opencloud-config → opencloud.yaml, CSP, polítiques...</pre></div>
  <p><code>PROXY_TLS=false</code> indica que la finalització TLS passa fora del contenidor (a Nginx). OpenCloud genera URLs coherents quan rep capçaleres <code>X-Forwarded-*</code> correctes.</p>
</div>

<div class="doc-block">
  <p class="doc-block-title">Ports</p>
  <h2 class="doc-block-heading">Mapa de superfície exposada</h2>
  <ul class="doc-list">
    <li><strong>22 (sshd):</strong> administració SSH — Internet segons política.</li>
    <li><strong>80/443 (Nginx):</strong> HTTP/S públic — redirecció ACME i virtual hosts KM0 + OpenCloud.</li>
    <li><strong>9200 (Docker → OpenCloud):</strong> només <code>127.0.0.1</code> — backend HTTP que ve Nginx.</li>
    <li><strong>9140–9300:</strong> microserveis interns del contenidor — no publicats a l'host.</li>
  </ul>
  <div class="doc-note">UFW reforça la política permetent des d'Internet només el necessari. Si no l'ha de conèixer el navegador extern, no escolta a totes les interfícies.</div>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Nginx</p>
  <h2 class="doc-block-heading">Directives clau cap a OpenCloud</h2>
  <ul class="doc-list">
    <li><strong>proxy_buffering off:</strong> SSE per a actualitzacions en temps real del client web.</li>
    <li><strong>proxy_request_buffering off:</strong> pujades resumibles TUS sense emmagatzemar tot el cos en buffer.</li>
    <li><strong>proxy_pass http://127.0.0.1:9200:</strong> TLS ja resolt a la vora.</li>
    <li><strong>X-Forwarded-Proto $scheme:</strong> redireccions i cookies coherents per a HTTPS.</li>
    <li><strong>Upgrade/Connection passthrough:</strong> WebSockets per a la UI interactiva.</li>
    <li><strong>Timeouts 3600s i client_max_body_size 10G:</strong> sessions llargues i fitxers grans.</li>
  </ul>
</div>

<div class="doc-block">
  <p class="doc-block-title">Desplegament</p>
  <h2 class="doc-block-heading">Arbre a /opt/opencloud</h2>
  <div class="doc-note"><pre>/opt/opencloud/
├── opencloud-compose/     # clon upstream + overlays
│   ├── docker-compose.yml
│   ├── external-proxy/opencloud.yml
│   └── .env                 # actiu — fora de git, chmod 600
├── nginx/                   # plantilles TLS + proxy
├── scripts/backup-volumes.sh
└── docs/runbook.md</pre></div>
  <p>Els snippets al repo serveixen com a referència; els fitxers actius sota <code>/etc/nginx/sites-available/</code> s'han de revisar sempre amb <code>nginx -t</code> abans de <code>systemctl reload nginx</code>.</p>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Dades</p>
  <h2 class="doc-block-heading">Volums Docker i persistència</h2>
  <p class="doc-block-intro">OpenCloud centralitza la persistència en dos volums nomenats. El contingut rellevant inclou:</p>
  <ul class="doc-list">
    <li><strong>idm/ i idp/:</strong> directori LDAP intern i estat del proveïdor OIDC.</li>
    <li><strong>nats/:</strong> bus d'esdeveniments JetStream entre microserveis.</li>
    <li><strong>search/:</strong> índex full-text (Bleve).</li>
    <li><strong>storage/:</strong> metadades CS3 i nodes del driver decomposed.</li>
    <li><strong>web/:</strong> actius estàtics del frontal integrat.</li>
  </ul>
  <p>Xifrat en repòs: blobs ordinaris dins del volum; opcions d'enduriment inclouen LUKS, SSE en backend objecte o xifrat E2E als clients. Xifrat en trànsit: TLS client↔Nginx.</p>
</div>

<div class="doc-block">
  <p class="doc-block-title">Web KM0</p>
  <h2 class="doc-block-heading">Flux HTTPS del lloc corporatiu</h2>
  <div class="doc-note"><pre>Internet :443 ─► Nginx host (TLS, km0.amvara.de)
                     └──► http://127.0.0.1:9180  (km0-web — només loopback)
                            Astro estàtic + nginx Alpine</pre></div>
  <ul class="doc-list">
    <li><strong>Stack:</strong> Astro 5 + Tailwind 3, sortida estàtica.</li>
    <li><strong>i18n:</strong> JSON a <code>src/i18n/</code> + rutes <code>/ca/</code>, <code>/en/</code>, <code>/de/</code>; castellà per defecte a l'arrel.</li>
    <li><strong>Build:</strong> Node 22 Alpine multi-stage; repo a <code>/opt/km0-web</code>.</li>
    <li><strong>SEO:</strong> <code>@astrojs/sitemap</code> amb alternatives hreflang.</li>
  </ul>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Perímetre</p>
  <h2 class="doc-block-heading">Fail2ban i subdomini del cloud</h2>
  <p class="doc-block-intro">Després del primer tall estable es va afegir Fail2ban com a xarxa complementària al firewall. El cloud va quedar publicat a <code>cloud.km0.amvara.de</code>, separat de la marca de màrqueting a <code>km0.amvara.de</code>:</p>
  <ul class="doc-list">
    <li>Certificats i polítiques CSP poden divergir.</li>
    <li>Els usuaris entenen quina URL fer servir per a treball vs comunicació.</li>
    <li>Els equips poden delegar DNS/TLS sense barrejar configuracions de l'Astro estàtic.</li>
  </ul>
</div>

<div class="doc-block">
  <p class="doc-block-title">Operació</p>
  <h2 class="doc-block-heading">Ordres rutinàries</h2>
  <div class="doc-note"><pre>cd /opt/opencloud/opencloud-compose
docker compose ps
docker compose logs -f opencloud
docker compose pull && docker compose up -d
git -C /opt/opencloud/opencloud-compose pull

ss -tulpn | grep -E ':22|:80|:443|:9200'
ufw status verbose
bash /opt/opencloud/scripts/backup-volumes.sh</pre></div>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Laboratori vs producció</p>
  <h2 class="doc-block-heading">Fases del desplegament</h2>
  <ul class="doc-list">
    <li><strong>TLS provisional:</strong> certificat autofirmat útil per validar el proxy — alertes al navegador fins a Let's Encrypt amb DNS estable.</li>
    <li><strong>Domini:</strong> passar d'IP en brut a FQDN millora enllaços interns i cookies.</li>
    <li><strong>INSECURE relaxat:</strong> només coherent mentre els certificats interns no formen una PKI de confiança.</li>
    <li><strong>Còpies de seguretat:</strong> script manual fins a cron supervisat; vigilar <code>certbot.timer</code> en producció.</li>
  </ul>
</div>

<div class="doc-closing-block">
  <p class="doc-block-title">Següent pas</p>
  <h2 class="doc-block-heading">Dia 2</h2>
  <p class="doc-closing">El <strong>dia 2</strong> madura l'autenticació OIDC amb Dex, actualitza OpenCloud 7.x i estableix la primera còpia integral. Mentrestant, explora els <a href="/ca/#servicios">serveis</a> o el <a href="/ca/doc/dia-2/">relat del dia 2</a>.</p>
</div>
