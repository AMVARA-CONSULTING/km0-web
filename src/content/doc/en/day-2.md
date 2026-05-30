---
title: "Day 2 — OpenCloud 7, Dex OIDC, and full backup"
description: "Upgrade to OpenCloud 7.0.0, Dex OIDC broker with Google and Apple, Nginx adjustments, first full backup, and operational documentation."
pubDate: 2026-05-22
locale: en
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">Day 2 (22 May 2026) focuses on the <strong>authentication perimeter</strong> and on maturing the OpenCloud stack deployed the previous day: version upgrade, Dex OIDC broker (Google and Apple), Nginx adjustments, first full backup, and operational documentation.</p>
  <p class="doc-lead">The initial deployment (Debian, Docker, TLS, separate hostnames) was closed on the 21st; today’s work builds on that production base at <a href="https://cloud.km0digital.com">cloud.km0digital.com</a>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Status</p>
  <h2 class="doc-block-heading">Components verified at close</h2>
  <ul class="doc-list">
    <li><strong>OpenCloud:</strong> <code>opencloudeu/opencloud-rolling:7.0.0</code> at <code>127.0.0.1:9200</code>.</li>
    <li><strong>Dex (OIDC):</strong> <code>ghcr.io/dexidp/dex:v2.41.1</code> at <code>127.0.0.1:5556</code>.</li>
    <li><strong>Nginx vhost:</strong> <code>/etc/nginx/sites-available/opencloud</code> — TLS → <code>/dex/</code> + <code>/</code>.</li>
    <li><strong>OC_DOMAIN:</strong> <code>cloud.km0digital.com</code> with <code>INSECURE=false</code>.</li>
    <li><strong>Dex issuer:</strong> <code>https://cloud.km0digital.com/dex</code> — Google + Apple connectors.</li>
  </ul>
  <p>Routine checks: <code>docker compose ps</code>, <code>nginx -t</code>, and HTTP headers against the public cloud URL.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Architecture</p>
  <h2 class="doc-block-heading">Authentication + application</h2>
  <div class="doc-note"><pre>Browser ── HTTPS :443 cloud.km0digital.com ── Nginx
              ├─ /dex/         → Dex        127.0.0.1:5556
              ├─ /login.html   → /var/www/opencloud-auth/
              └─ /             → OpenCloud  127.0.0.1:9200
                                    └─ opencloud_* volumes + dex_dex-data</pre></div>
  <p>The corporate site on the same host remains on another virtual host: <a href="https://km0digital.com/">km0digital.com</a> → static container on loopback.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Upgrade</p>
  <h2 class="doc-block-heading">OpenCloud 6.2.0 → 7.0.0</h2>
  <ul class="doc-list">
    <li>The target was to move toward branch 7.0.1; image <strong>7.0.0</strong> was the tag applied and validated (7.0.1 was not deployed as it was unavailable or not validated).</li>
    <li>Variable <code>OC_DOCKER_TAG=7.0.0</code> in <code>/opt/opencloud/opencloud-compose/.env</code>.</li>
    <li>Fix in <code>opencloud.yaml</code> runtime: <code>sharing.service_account</code> entry required in OpenCloud 7.x.</li>
    <li>Controlled restart: <code>docker compose pull && docker compose up -d</code>.</li>
    <li>Log review at <code>fatal</code>/<code>error</code> levels; service left running.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OIDC</p>
  <h2 class="doc-block-heading">Multi-provider with Dex (Google + Apple)</h2>
  <p class="doc-block-intro">The ad hoc Keycloak experiment (nginx templates under <code>keycloak*.conf</code> not enabled) was dropped in favor of a lightweight Dex broker at <code>/opt/opencloud/dex/</code>:</p>
  <ul class="doc-list">
    <li><strong>docker-compose.yml:</strong> Dex service, <code>dex_dex-data</code> volume, published on loopback :5556 only.</li>
    <li><strong>config.yaml:</strong> issuer, SQLite, OAuth2 clients, connectors.</li>
    <li><strong>web/themes/km0/:</strong> KM0-branded login UI (logo, CSS, CA/ES/EN i18n).</li>
    <li><strong>setup-apple.sh:</strong> generates Apple client JWT (~180 days).</li>
  </ul>
  <p>OpenCloud uses an external issuer (<code>OC_OIDC_ISSUER</code> → <code>/dex</code>, client <code>opencloud-web</code>). <code>alwaysShowLoginScreen: true</code> forces the Google vs Apple selector.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Public endpoints</p>
  <h2 class="doc-block-heading">Access URLs</h2>
  <ul class="doc-list">
    <li><strong><a href="https://cloud.km0digital.com/">cloud.km0digital.com/</a>:</strong> OpenCloud web interface.</li>
    <li><strong><a href="https://cloud.km0digital.com/dex/">/dex/</a>:</strong> OIDC issuer / Dex login.</li>
    <li><strong><a href="https://cloud.km0digital.com/login.html">/login.html</a>:</strong> static Google / Apple selector.</li>
  </ul>
  <div class="doc-note">Redirect URI in Google Cloud Console: <code>https://cloud.km0digital.com/dex/callback</code>. Apple credentials under <code>/opt/</code> — secrets not detailed here.</div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Nginx</p>
  <h2 class="doc-block-heading">Integration in the OpenCloud vhost</h2>
  <ul class="doc-list">
    <li><strong>location /dex/:</strong> → <code>http://127.0.0.1:5556/dex/</code> with forwarded headers for OIDC.</li>
    <li><strong>location = /login.html:</strong> static file at <code>/var/www/opencloud-auth/login.html</code>.</li>
    <li><strong>location /:</strong> OpenCloud on :9200 keeping SSE, TUS, and WebSockets from day 1.</li>
  </ul>
  <p>With <code>INSECURE=false</code> and a stable FQDN, the stack leaves relaxed lab mode.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Compose</p>
  <h2 class="doc-block-heading">DNS resolution in container</h2>
  <p class="doc-block-intro">In <code>external-proxy/opencloud.yml</code>, <code>extra_hosts: ${OC_DOMAIN}:host-gateway</code> was added so the container resolves the public hostname as the host. Without it, login failures can appear after Google OAuth (<code>access-denied</code> or inconsistent sessions).</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Backup</p>
  <h2 class="doc-block-heading">First full installation copy</h2>
  <p class="doc-block-intro">Script: <code>/opt/opencloud/scripts/backup-opencloud-installation.sh</code>. First run: 2026-05-22 19:51 → <code>/opt/backup_opencloud_installation/20260522-195106/</code> with <code>latest</code> symlink.</p>
  <ul class="doc-list">
    <li><strong>opt-opencloud/:</strong> full <code>/opt/opencloud/</code> tree.</li>
    <li><strong>host-nginx/:</strong> active vhost + repo templates.</li>
    <li><strong>letsencrypt/:</strong> TLS for the cloud hostname.</li>
    <li><strong>docker-volumes/:</strong> tarballs <code>opencloud-data</code>, <code>opencloud-config</code>, <code>dex-data</code>.</li>
    <li><strong>manifest/:</strong> runtime snapshot and backup log.</li>
  </ul>
  <div class="doc-note">Does not include the km0 corporate web vhost or other stacks unrelated to OpenCloud.</div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Incidents</p>
  <h2 class="doc-block-heading">Documented symptoms and remedies</h2>
  <ul class="doc-list">
    <li><strong>GET .../photo/$value 404:</strong> no avatar uploaded — benign console noise.</li>
    <li><strong>502 on legacy /signin/ URLs:</strong> stale session before Dex cutover — clear site data or use a private window.</li>
    <li><strong>access-denied after Google login:</strong> whitelist in <code>role_assignment</code> or DNS — use <code>driver: default</code> or <code>extra_hosts</code>.</li>
    <li><strong>Dex restart loop:</strong> check <code>docker logs</code>; validate provider JSON under <code>/opt/</code>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Research</p>
  <h2 class="doc-block-heading">Not deployed today</h2>
  <ul class="doc-list">
    <li><strong>Collabora / WOPI:</strong> review of in-browser Office editing — keep core only; possible future addon.</li>
    <li><strong>Apache HTTP Server:</strong> confirmed not in use (Nginx only). Apache Tika in upstream docs not deployed.</li>
    <li><strong>OpenCloud Web branding:</strong> KM0 overlay reverted on 21 May; KM0 branding on Dex login retained.</li>
  </ul>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Next step</p>
  <h2 class="doc-block-heading">Day 3</h2>
  <p class="doc-closing"><strong>Day 3</strong> consolidates versioned Git repositories, migrates the site to <code>km0digital.com</code>, and introduces the autoagents loop in both projects. In the meantime, explore the <a href="/en/#services">services</a> or the <a href="/en/doc/day-3/">day 3 story</a>.</p>
</section>
