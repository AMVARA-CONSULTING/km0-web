---
title: "Tag 2 — OpenCloud 7, Dex OIDC und vollständiges Backup"
description: "Upgrade auf OpenCloud 7.0.0, Dex-OIDC-Broker mit Google und Apple, Nginx-Anpassungen, erstes vollständiges Backup und operative Dokumentation."
pubDate: 2026-05-22
locale: de
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einleitung</p>
  <p class="doc-lead">Tag 2 (22. Mai 2026) konzentriert sich auf den <strong>Authentifizierungs-Perimeter</strong> und die Reifung des am Vortag deployten OpenCloud-Stacks: Versions-Upgrade, OIDC-Broker mit Dex (Google und Apple), Nginx-Anpassungen, erstes vollständiges Backup und operative Dokumentation.</p>
  <p class="doc-lead">Das Erst-Deployment (Debian, Docker, TLS, getrennte Hostnames) wurde am 21. abgeschlossen; heute wird auf dieser Basis in Produktion unter <a href="https://cloud.km0digital.com">cloud.km0digital.com</a> weitergearbeitet.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Status</p>
  <h2 class="doc-block-heading">Zum Abschluss verifizierte Komponenten</h2>
  <ul class="doc-list">
    <li><strong>OpenCloud:</strong> <code>opencloudeu/opencloud-rolling:7.0.0</code> auf <code>127.0.0.1:9200</code>.</li>
    <li><strong>Dex (OIDC):</strong> <code>ghcr.io/dexidp/dex:v2.41.1</code> auf <code>127.0.0.1:5556</code>.</li>
    <li><strong>Nginx vhost:</strong> <code>/etc/nginx/sites-available/opencloud</code> — TLS → <code>/dex/</code> + <code>/</code>.</li>
    <li><strong>OC_DOMAIN:</strong> <code>cloud.km0digital.com</code> mit <code>INSECURE=false</code>.</li>
    <li><strong>Dex-Issuer:</strong> <code>https://cloud.km0digital.com/dex</code> — Connectors Google + Apple.</li>
  </ul>
  <p>Übliche Checks: <code>docker compose ps</code>, <code>nginx -t</code> und HTTP-Header gegen die öffentliche Cloud-URL.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Architektur</p>
  <h2 class="doc-block-heading">Authentifizierung + Anwendung</h2>
  <div class="doc-note"><pre>Browser ── HTTPS :443 cloud.km0digital.com ── Nginx
              ├─ /dex/         → Dex        127.0.0.1:5556
              ├─ /login.html   → /var/www/opencloud-auth/
              └─ /             → OpenCloud  127.0.0.1:9200
                                    └─ Volumes opencloud_* + dex_dex-data</pre></div>
  <p>Die Unternehmenswebsite auf demselben Host läuft in einem anderen Virtual Host: <a href="https://km0digital.com/">km0digital.com</a> → statischer Container auf Loopback.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Upgrade</p>
  <h2 class="doc-block-heading">OpenCloud 6.2.0 → 7.0.0</h2>
  <ul class="doc-list">
    <li>Ziel war die Annäherung an den 7.0.1-Zweig; das Image <strong>7.0.0</strong> wurde als Tag angewendet und validiert (7.0.1 wurde nicht deployt, da nicht verfügbar oder nicht validiert).</li>
    <li>Variable <code>OC_DOCKER_TAG=7.0.0</code> in <code>/opt/opencloud/opencloud-compose/.env</code>.</li>
    <li>Korrektur in <code>opencloud.yaml</code> Runtime: Eintrag <code>sharing.service_account</code> in OpenCloud 7.x erforderlich.</li>
    <li>Kontrollierter Neustart: <code>docker compose pull && docker compose up -d</code>.</li>
    <li>Log-Review auf <code>fatal</code>/<code>error</code>; Dienst in Betrieb gelassen.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OIDC</p>
  <h2 class="doc-block-heading">Multi-Provider mit Dex (Google + Apple)</h2>
  <p class="doc-block-intro">Das ad-hoc-Experiment mit Keycloak (Nginx-Vorlagen unter <code>keycloak*.conf</code> nicht aktiviert) wurde zugunsten eines schlanken Dex-Brokers unter <code>/opt/opencloud/dex/</code> verworfen:</p>
  <ul class="doc-list">
    <li><strong>docker-compose.yml:</strong> Dex-Dienst, Volume <code>dex_dex-data</code>, Veröffentlichung nur auf Loopback :5556.</li>
    <li><strong>config.yaml:</strong> Issuer, SQLite, OAuth2-Clients, Connectors.</li>
    <li><strong>web/themes/km0/:</strong> Login-UI mit KM0-Branding (Logo, CSS, i18n CA/ES/EN).</li>
    <li><strong>setup-apple.sh:</strong> erzeugt Apple-Client-JWT (~180 Tage).</li>
  </ul>
  <p>OpenCloud nutzt externen Issuer (<code>OC_OIDC_ISSUER</code> → <code>/dex</code>, Client <code>opencloud-web</code>). <code>alwaysShowLoginScreen: true</code> erzwingt die Auswahl Google vs. Apple.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Öffentliche Einstiege</p>
  <h2 class="doc-block-heading">Zugangs-URLs</h2>
  <ul class="doc-list">
    <li><strong><a href="https://cloud.km0digital.com/">cloud.km0digital.com/</a>:</strong> OpenCloud-Web-Oberfläche.</li>
    <li><strong><a href="https://cloud.km0digital.com/dex/">/dex/</a>:</strong> OIDC-Issuer / Dex-Login.</li>
    <li><strong><a href="https://cloud.km0digital.com/login.html">/login.html</a>:</strong> statischer Google-/Apple-Selector.</li>
  </ul>
  <div class="doc-note">Redirect-URI in der Google Cloud Console: <code>https://cloud.km0digital.com/dex/callback</code>. Apple-Credentials unter <code>/opt/</code> — keine Secrets hier.</div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Nginx</p>
  <h2 class="doc-block-heading">Integration im OpenCloud-vhost</h2>
  <ul class="doc-list">
    <li><strong>location /dex/:</strong> → <code>http://127.0.0.1:5556/dex/</code> mit weitergeleiteten Headern für OIDC.</li>
    <li><strong>location = /login.html:</strong> statische Datei unter <code>/var/www/opencloud-auth/login.html</code>.</li>
    <li><strong>location /:</strong> OpenCloud auf :9200 mit SSE, TUS und WebSockets von Tag 1.</li>
  </ul>
  <p>Mit <code>INSECURE=false</code> und stabilem FQDN verlässt der Stack den gelockerten Labor-Modus.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Compose</p>
  <h2 class="doc-block-heading">DNS-Auflösung im Container</h2>
  <p class="doc-block-intro">In <code>external-proxy/opencloud.yml</code> wurde <code>extra_hosts: ${OC_DOMAIN}:host-gateway</code> ergänzt, damit der Container den öffentlichen Hostnamen wie der Host auflöst. Ohne das können Login-Fehler nach Google-OAuth auftreten (<code>access-denied</code> oder inkonsistente Sitzungen).</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Backup</p>
  <h2 class="doc-block-heading">Erste vollständige Kopie der Installation</h2>
  <p class="doc-block-intro">Skript: <code>/opt/opencloud/scripts/backup-opencloud-installation.sh</code>. Erste Ausführung: 2026-05-22 19:51 → <code>/opt/backup_opencloud_installation/20260522-195106/</code> mit Link <code>latest</code>.</p>
  <ul class="doc-list">
    <li><strong>opt-opencloud/:</strong> vollständiger Baum <code>/opt/opencloud/</code>.</li>
    <li><strong>host-nginx/:</strong> aktiver vhost + Repo-Vorlagen.</li>
    <li><strong>letsencrypt/:</strong> TLS des Cloud-Hostnames.</li>
    <li><strong>docker-volumes/:</strong> Tarballs <code>opencloud-data</code>, <code>opencloud-config</code>, <code>dex-data</code>.</li>
    <li><strong>manifest/:</strong> Runtime-Snapshot und Backup-Log.</li>
  </ul>
  <div class="doc-note">Enthält nicht den vhost der KM0-Unternehmenswebsite noch andere Stacks außerhalb von OpenCloud.</div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Vorfälle</p>
  <h2 class="doc-block-heading">Dokumentierte Symptome und Abhilfe</h2>
  <ul class="doc-list">
    <li><strong>GET .../photo/$value 404:</strong> kein Avatar hochgeladen — harmloses Konsolen-Rauschen.</li>
    <li><strong>502 auf alte URLs /signin/:</strong> veraltete Sitzung vor dem Dex-Schnitt — Site-Daten löschen oder privates Fenster.</li>
    <li><strong>access-denied nach Google-Login:</strong> Whitelist in <code>role_assignment</code> oder DNS — <code>driver: default</code> oder <code>extra_hosts</code> nutzen.</li>
    <li><strong>Dex in Neustart-Schleife:</strong> <code>docker logs</code> prüfen; Provider-JSON unter <code>/opt/</code> validieren.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Recherche</p>
  <h2 class="doc-block-heading">Heute nicht deployt</h2>
  <ul class="doc-list">
    <li><strong>Collabora / WOPI:</strong> Review von Office-Bearbeitung im Browser — vorerst nur Core; mögliches Addon später.</li>
    <li><strong>Apache HTTP Server:</strong> bestätigt ungenutzt (nur Nginx). Apache Tika in Upstream-Docs nicht deployt.</li>
    <li><strong>OpenCloud-Web-Branding:</strong> KM0-Overlay am 21. Mai zurückgenommen; KM0-Branding im Dex-Login bleibt.</li>
  </ul>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Offen</p>
  <h2 class="doc-block-heading">Nächste Schritte</h2>
  <p class="doc-closing">OpenCloud 7.0.1 prüfen, sobald das Image validiert ist, Apple Sign In abschließen falls nötig, Cron für das vollständige Backup einrichten und Rotation des administrativen Zugangs überdenken. Erkunden Sie die <a href="/de/#services">Services</a> oder <a href="/de/#contact">nehmen Sie Kontakt auf</a>, wenn Sie mitarbeiten möchten.</p>
</section>
