---
title: "Day 1 — OpenCloud, proxy, and project web"
description: "OpenCloud on Docker Compose, Nginx with TLS on loopback, Fail2ban, cloud subdomain, and the KM0 Astro landing published as a second backend."
pubDate: 2026-05-21
locale: en
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">Day 1 turns the Debian base into a full platform: <strong>OpenCloud</strong> on Docker Compose with official overlays, Nginx terminating TLS and routing only to loopback, coherent firewall policies, and the project’s Astro landing published as a second backend behind the same front door.</p>
  <p class="doc-lead">Post–first-cut improvements are also covered — Fail2ban and the dedicated cloud subdomain — because they are part of the real operational story of the deployment.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Core without Collabora/WOPI</h2>
  <p class="doc-block-intro">The chosen mode runs OpenCloud as a single service from the official composition (<code>opencloud-eu/opencloud-compose</code>), using a rolling image tagged (<code>opencloud-rolling</code> with a pinned tag at deploy time) so updates are deliberate (<code>docker compose pull</code> + maintenance window).</p>
  <ul class="doc-list">
    <li><strong>external-proxy overlay:</strong> adjusts variables such as <code>PROXY_HTTP_ADDR</code> to listen inside the container and publish the proxy HTTP port only as <code>127.0.0.1:&lt;port&gt;</code> on the host.</li>
    <li><strong>COMPOSE_PROJECT_NAME=opencloud:</strong> anchors Docker volume names without depending on cwd.</li>
    <li><strong>.env file:</strong> single source of deploy variables; strict permissions on disk and outside version control.</li>
    <li><strong>COMPOSE_FILE:</strong> lists required overlays (base plus external-proxy overlay).</li>
  </ul>
  <p>Inside the container, microservices coexist and communicate over gRPC/HTTP on internal localhost; that range is not exposed directly to the host except through endpoints defined by the upstream chart.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Architecture</p>
  <h2 class="doc-block-heading">OpenCloud behind the proxy</h2>
  <div class="doc-note"><pre>Browser
   │  HTTPS :443
   ▼
Nginx (Debian, dedicated OpenCloud site)
   │  HTTP http://127.0.0.1:9200  (loopback only)
   ▼
OpenCloud container (fixed UID/GID)
   │  internal microservices ~9140–9300
   ▼
Docker volumes:
   • opencloud-data   → files, indexes, NATS, IDM...
   • opencloud-config → opencloud.yaml, CSP, policies...</pre></div>
  <p><code>PROXY_TLS=false</code> means TLS termination happens outside the container (on Nginx). OpenCloud generates coherent URLs when it receives correct <code>X-Forwarded-*</code> headers.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Ports</p>
  <h2 class="doc-block-heading">Exposed surface map</h2>
  <ul class="doc-list">
    <li><strong>22 (sshd):</strong> SSH administration — Internet per policy.</li>
    <li><strong>80/443 (Nginx):</strong> public HTTP/S — ACME redirect and KM0 + OpenCloud virtual hosts.</li>
    <li><strong>9200 (Docker → OpenCloud):</strong> <code>127.0.0.1</code> only — HTTP backend seen by Nginx.</li>
    <li><strong>9140–9300:</strong> internal container microservices — not published on the host.</li>
  </ul>
  <div class="doc-note">UFW reinforces the policy, allowing from the Internet only what is necessary. If the external browser should not know about it, it does not listen on all interfaces.</div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Nginx</p>
  <h2 class="doc-block-heading">Key directives toward OpenCloud</h2>
  <ul class="doc-list">
    <li><strong>proxy_buffering off:</strong> SSE for real-time web client updates.</li>
    <li><strong>proxy_request_buffering off:</strong> resumable TUS uploads without buffering the entire body.</li>
    <li><strong>proxy_pass http://127.0.0.1:9200:</strong> TLS already handled at the edge.</li>
    <li><strong>X-Forwarded-Proto $scheme:</strong> coherent redirects and cookies for HTTPS.</li>
    <li><strong>Upgrade/Connection passthrough:</strong> WebSockets for the interactive UI.</li>
    <li><strong>Timeouts 3600s and client_max_body_size 10G:</strong> long sessions and large files.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Deployment</p>
  <h2 class="doc-block-heading">Tree at /opt/opencloud</h2>
  <div class="doc-note"><pre>/opt/opencloud/
├── opencloud-compose/     # upstream clone + overlays
│   ├── docker-compose.yml
│   ├── external-proxy/opencloud.yml
│   └── .env                 # active — outside git, chmod 600
├── nginx/                   # TLS + proxy templates
├── scripts/backup-volumes.sh
└── docs/runbook.md</pre></div>
  <p>Snippets in the repo serve as reference; active files under <code>/etc/nginx/sites-available/</code> must always be checked with <code>nginx -t</code> before <code>systemctl reload nginx</code>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Data</p>
  <h2 class="doc-block-heading">Docker volumes and persistence</h2>
  <p class="doc-block-intro">OpenCloud centralizes persistence in two named volumes. Relevant content includes:</p>
  <ul class="doc-list">
    <li><strong>idm/ and idp/:</strong> internal LDAP directory and OIDC provider state.</li>
    <li><strong>nats/:</strong> JetStream event bus between microservices.</li>
    <li><strong>search/:</strong> full-text index (Bleve).</li>
    <li><strong>storage/:</strong> CS3 metadata and decomposed driver nodes.</li>
    <li><strong>web/:</strong> static assets for the integrated front end.</li>
  </ul>
  <p>Encryption at rest: ordinary blobs within the volume; hardening options include LUKS, SSE on object backend, or E2E encryption in clients. Encryption in transit: TLS client↔Nginx.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">KM0 web</p>
  <h2 class="doc-block-heading">Corporate site HTTPS flow</h2>
  <div class="doc-note"><pre>Internet :443 ─► Nginx host (TLS, km0digital.com)
                     └──► http://127.0.0.1:9180  (km0-web — loopback only)
                            Astro static + nginx Alpine</pre></div>
  <ul class="doc-list">
    <li><strong>Stack:</strong> Astro 5 + Tailwind 3, static output.</li>
    <li><strong>i18n:</strong> JSON in <code>src/i18n/</code> + routes <code>/ca/</code>, <code>/en/</code>, <code>/de/</code>; Spanish default at root.</li>
    <li><strong>Build:</strong> Node 22 Alpine multi-stage; repo at <code>/opt/km0-web</code>.</li>
    <li><strong>SEO:</strong> <code>@astrojs/sitemap</code> with hreflang alternates.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Perimeter</p>
  <h2 class="doc-block-heading">Fail2ban and cloud subdomain</h2>
  <p class="doc-block-intro">After the first stable cut, Fail2ban was added as a complementary layer to the firewall. The cloud was published at <code>cloud.km0digital.com</code>, separate from the marketing brand at <code>km0digital.com</code>:</p>
  <ul class="doc-list">
    <li>Certificates and CSP policies can diverge.</li>
    <li>Users understand which URL to use for work vs communication.</li>
    <li>Teams can delegate DNS/TLS without mixing static Astro configuration.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Operations</p>
  <h2 class="doc-block-heading">Routine commands</h2>
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
  <p class="doc-block-title">Lab vs production</p>
  <h2 class="doc-block-heading">Deployment phases</h2>
  <ul class="doc-list">
    <li><strong>Provisional TLS:</strong> self-signed certificate useful for validating the proxy — browser warnings until Let's Encrypt with stable DNS.</li>
    <li><strong>Domain:</strong> moving from raw IP to FQDN improves internal links and cookies.</li>
    <li><strong>Relaxed INSECURE:</strong> only coherent while internal certificates do not form a trusted PKI.</li>
    <li><strong>Backups:</strong> manual script until supervised cron; watch <code>certbot.timer</code> in production.</li>
  </ul>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Next step</p>
  <h2 class="doc-block-heading">Day 2</h2>
  <p class="doc-closing"><strong>Day 2</strong> matures OIDC authentication with Dex, upgrades OpenCloud 7.x, and establishes the first full backup. In the meantime, explore the <a href="/en/#services">services</a> or the <a href="/en/doc/day-2/">day 2 story</a>.</p>
</section>
