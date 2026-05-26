---
title: "Tag 1 — OpenCloud, Proxy und Projekt-Website"
description: "OpenCloud in Docker Compose, Nginx mit TLS auf Loopback, Fail2ban, Cloud-Subdomain und die Astro-KM0-Landing als zweites Backend."
pubDate: 2026-05-21
locale: de
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einleitung</p>
  <p class="doc-lead">Tag 1 verwandelt die Debian-Basis in eine vollständige Plattform: <strong>OpenCloud</strong> auf Docker Compose mit offiziellen Overlays, Nginx mit TLS-Terminierung und Weiterleitung nur zum Loopback, konsistente Firewall-Richtlinien und die Astro-Landing des Projekts als zweites Backend hinter demselben Front.</p>
  <p class="doc-lead">Außerdem werden Verbesserungen nach dem ersten Schnitt eingeführt — Fail2ban und die dedizierte Cloud-Subdomain —, weil sie Teil der realen Betriebsgeschichte des Deployments sind.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Core ohne Collabora/WOPI</h2>
  <p class="doc-block-intro">Der gewählte Modus startet OpenCloud als Einzeldienst aus der offiziellen Composition (<code>opencloud-eu/opencloud-compose</code>), mit einem Rolling-Image (<code>opencloud-rolling</code>, Tag im Deployment fixiert), um gezielt aktualisieren zu können (<code>docker compose pull</code> + Wartungsfenster).</p>
  <ul class="doc-list">
    <li><strong>Overlay external-proxy:</strong> passt Variablen wie <code>PROXY_HTTP_ADDR</code> an, damit innerhalb des Containers gehört wird und der HTTP-Proxy-Port nur als <code>127.0.0.1:&lt;port&gt;</code> auf dem Host veröffentlicht wird.</li>
    <li><strong>COMPOSE_PROJECT_NAME=opencloud:</strong> verankert Docker-Volume-Namen unabhängig vom cwd.</li>
    <li><strong>.env-Datei:</strong> einzige Quelle für Deployment-Variablen; strenge Dateirechte und außerhalb der Versionskontrolle.</li>
    <li><strong>COMPOSE_FILE:</strong> listet die nötigen Overlays (Basis plus External-Proxy-Overlay).</li>
  </ul>
  <p>Im Container koexistieren Microservices, die intern per gRPC/HTTP auf localhost kommunizieren; dieser Bereich wird nicht direkt auf den Host exponiert, außer über die vom Upstream-Chart vorgesehenen Endpoints.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Architektur</p>
  <h2 class="doc-block-heading">OpenCloud hinter dem Proxy</h2>
  <div class="doc-note"><pre>Browser
   │  HTTPS :443
   ▼
Nginx (Debian, dedizierte OpenCloud-Site)
   │  HTTP http://127.0.0.1:9200  (nur Loopback)
   ▼
OpenCloud-Container (feste UID/GID)
   │  interne Microservices ~9140–9300
   ▼
Docker-Volumes:
   • opencloud-data   → Dateien, Indizes, NATS, IDM...
   • opencloud-config → opencloud.yaml, CSP, Richtlinien...</pre></div>
  <p><code>PROXY_TLS=false</code> bedeutet, dass die TLS-Terminierung außerhalb des Containers (in Nginx) erfolgt. OpenCloud erzeugt konsistente URLs, wenn korrekte <code>X-Forwarded-*</code>-Header ankommen.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Ports</p>
  <h2 class="doc-block-heading">Karte der exponierten Oberfläche</h2>
  <ul class="doc-list">
    <li><strong>22 (sshd):</strong> SSH-Administration — Internet je nach Richtlinie.</li>
    <li><strong>80/443 (Nginx):</strong> öffentliches HTTP/S — ACME-Weiterleitung und Virtual Hosts KM0 + OpenCloud.</li>
    <li><strong>9200 (Docker → OpenCloud):</strong> nur <code>127.0.0.1</code> — HTTP-Backend für Nginx.</li>
    <li><strong>9140–9300:</strong> interne Microservices im Container — nicht auf dem Host veröffentlicht.</li>
  </ul>
  <div class="doc-note">UFW verstärkt die Richtlinie und erlaubt aus dem Internet nur das Nötige. Was der externe Browser nicht kennen soll, lauscht nicht auf allen Interfaces.</div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Nginx</p>
  <h2 class="doc-block-heading">Wichtige Direktiven zu OpenCloud</h2>
  <ul class="doc-list">
    <li><strong>proxy_buffering off:</strong> SSE für Echtzeit-Updates im Web-Client.</li>
    <li><strong>proxy_request_buffering off:</strong> wiederaufnehmbare TUS-Uploads ohne vollständiges Body-Buffering.</li>
    <li><strong>proxy_pass http://127.0.0.1:9200:</strong> TLS bereits am Rand gelöst.</li>
    <li><strong>X-Forwarded-Proto $scheme:</strong> konsistente Redirects und Cookies für HTTPS.</li>
    <li><strong>Upgrade/Connection passthrough:</strong> WebSockets für die interaktive UI.</li>
    <li><strong>Timeouts 3600s und client_max_body_size 10G:</strong> lange Sitzungen und große Dateien.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Deployment</p>
  <h2 class="doc-block-heading">Baum unter /opt/opencloud</h2>
  <div class="doc-note"><pre>/opt/opencloud/
├── opencloud-compose/     # Upstream-Klon + Overlays
│   ├── docker-compose.yml
│   ├── external-proxy/opencloud.yml
│   └── .env                 # aktiv — außerhalb von Git, chmod 600
├── nginx/                   # TLS- + Proxy-Vorlagen
├── scripts/backup-volumes.sh
└── docs/runbook.md</pre></div>
  <p>Snippets im Repo dienen als Referenz; aktive Dateien unter <code>/etc/nginx/sites-available/</code> immer mit <code>nginx -t</code> prüfen, bevor <code>systemctl reload nginx</code> ausgeführt wird.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Daten</p>
  <h2 class="doc-block-heading">Docker-Volumes und Persistenz</h2>
  <p class="doc-block-intro">OpenCloud bündelt Persistenz in zwei benannten Volumes. Relevanter Inhalt umfasst:</p>
  <ul class="doc-list">
    <li><strong>idm/ und idp/:</strong> internes LDAP-Verzeichnis und OIDC-Provider-Status.</li>
    <li><strong>nats/:</strong> JetStream-Event-Bus zwischen Microservices.</li>
    <li><strong>search/:</strong> Volltextindex (Bleve).</li>
    <li><strong>storage/:</strong> CS3-Metadaten und Knoten des decomposed Drivers.</li>
    <li><strong>web/:</strong> statische Assets des integrierten Frontends.</li>
  </ul>
  <p>Verschlüsselung at rest: gewöhnliche Blobs im Volume; Härtungsoptionen sind LUKS, SSE im Objekt-Backend oder E2E-Verschlüsselung in Clients. Verschlüsselung in transit: TLS Client↔Nginx.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">KM0-Web</p>
  <h2 class="doc-block-heading">HTTPS-Flow der Unternehmenswebsite</h2>
  <div class="doc-note"><pre>Internet :443 ─► Nginx Host (TLS, km0.amvara.de)
                     └──► http://127.0.0.1:9180  (km0-web — nur Loopback)
                            statisches Astro + nginx Alpine</pre></div>
  <ul class="doc-list">
    <li><strong>Stack:</strong> Astro 5 + Tailwind 3, statische Ausgabe.</li>
    <li><strong>i18n:</strong> JSON in <code>src/i18n/</code> + Routen <code>/ca/</code>, <code>/en/</code>, <code>/de/</code>; Spanisch standardmäßig in der Wurzel.</li>
    <li><strong>Build:</strong> Node 22 Alpine Multi-Stage; Repo unter <code>/opt/km0-web</code>.</li>
    <li><strong>SEO:</strong> <code>@astrojs/sitemap</code> mit hreflang-Alternativen.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Perimeter</p>
  <h2 class="doc-block-heading">Fail2ban und Cloud-Subdomain</h2>
  <p class="doc-block-intro">Nach dem ersten stabilen Schnitt wurde Fail2ban als Ergänzung zur Firewall ergänzt. Die Cloud wurde unter <code>cloud.km0.amvara.de</code> veröffentlicht, getrennt von der Marketing-Marke unter <code>km0.amvara.de</code>:</p>
  <ul class="doc-list">
    <li>Zertifikate und CSP-Richtlinien können abweichen.</li>
    <li>Nutzer verstehen, welche URL für Arbeit vs. Kommunikation gilt.</li>
    <li>Teams können DNS/TLS delegieren, ohne die statische Astro-Konfiguration zu vermischen.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Betrieb</p>
  <h2 class="doc-block-heading">Routinemäßige Befehle</h2>
  <div class="doc-note"><pre>cd /opt/opencloud/opencloud-compose
docker compose ps
docker compose logs -f opencloud
docker compose pull && docker compose up -d
git -C /opt/opencloud/opencloud-compose pull

ss -tulpn | grep -E ':22|:80|:443|:9200'
ufw status verbose
bash /opt/opencloud/scripts/backup-volumes.sh</pre></div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Labor vs. Produktion</p>
  <h2 class="doc-block-heading">Phasen des Deployments</h2>
  <ul class="doc-list">
    <li><strong>Vorläufiges TLS:</strong> selbstsigniertes Zertifikat zum Validieren des Proxys — Browser-Warnungen bis Let's Encrypt mit stabilem DNS.</li>
    <li><strong>Domain:</strong> Wechsel von roher IP zu FQDN verbessert interne Links und Cookies.</li>
    <li><strong>INSECURE gelockert:</strong> nur sinnvoll, solange interne Zertifikate keine vertrauenswürdige PKI bilden.</li>
    <li><strong>Backups:</strong> manuelles Skript bis überwachter Cron; <code>certbot.timer</code> in Produktion im Blick behalten.</li>
  </ul>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Nächster Schritt</p>
  <h2 class="doc-block-heading">Tag 2</h2>
  <p class="doc-closing"><strong>Tag 2</strong> reift OIDC-Authentifizierung mit Dex, aktualisiert OpenCloud 7.x und legt das erste vollständige Backup an. In der Zwischenzeit: die <a href="/de/#servicios">Services</a> erkunden oder den <a href="/de/doc/dia-2/">Bericht zu Tag 2</a> lesen.</p>
</section>
