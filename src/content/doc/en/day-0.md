---
title: "Day 0 — Server foundations"
description: "Debian, partitioning, Docker, Nginx, and a reproducible base so the KM0 stack stays auditable and operable."
pubDate: 2026-05-21
locale: en
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">Day 0 is dedicated to <strong>foundations</strong>: without a reproducible operating system and working environment, any later stack would be fragile and hard to audit.</p>
  <p class="doc-lead">The goal is to end the day with stable Debian, an orderly disk layout, minimal but sufficient tooling, and a shell that encourages documenting every change.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Infrastructure</p>
  <h2 class="doc-block-heading">Bootstrap technical plan</h2>
  <p class="doc-block-intro">KM0 aims for infrastructure the team can operate without opaque proprietary panels. The full bootstrap picture includes:</p>
  <ul class="doc-list">
    <li><strong>System:</strong> VPS on up-to-date Debian with partitions separating system from data where needed (clearer snapshots and backups).</li>
    <li><strong>Collaboration:</strong> <a href="https://cloud.km0.amvara.de">OpenCloud</a> as microservices on an official <a href="https://opencloud.eu">OpenCloud.eu</a> image, with stable volumes (<code>COMPOSE_PROJECT_NAME</code>) independent of the Compose working directory.</li>
    <li><strong>Perimeter:</strong> Nginx as the sole HTTPS front; Docker publishing HTTP only on <code>127.0.0.1</code>.</li>
    <li><strong>Communication:</strong> Dockerized Astro on another loopback port; separate vhosts for <code>km0.amvara.de</code> and <code>cloud.km0.amvara.de</code>.</li>
    <li><strong>Observability:</strong> rotated logs (<code>json-file</code>), runbooks with <code>docker compose ps</code>, <code>logs</code>, <code>pull</code>, and compressed volume backups.</li>
    <li><strong>Evolution:</strong> production TLS internally, automated backups, and Fail2ban per specific jails.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Disk and system</p>
  <h2 class="doc-block-heading">VPS provisioning and partitions</h2>
  <p class="doc-block-intro"><strong>Debian</strong> was chosen for predictable packages and hands-on documentation, without mandatory control panels. The first step was to review disk layout:</p>
  <ul class="doc-list">
    <li>Separate project data from the root filesystem when volume-level backup is needed.</li>
    <li>Define mounts deliberately: <code>/var/lib/docker</code> may concentrate OpenCloud I/O depending on VPS size.</li>
    <li>Document conventions to tell persistent mounts from the operating system.</li>
  </ul>
  <div class="doc-note">Exact partition maps depend on provider and contracted size. They must live in the project wiki or runbook, not only in this blog, for disaster recovery.</div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Base packages</p>
  <h2 class="doc-block-heading">Base software</h2>
  <p class="doc-block-intro">A reasonable minimum was installed for secure remote administration and Docker, without bloat:</p>
  <ul class="doc-list">
    <li>Common utilities: <code>curl</code>, editors, network and diagnostics.</li>
    <li><strong>Docker Engine</strong> with rotated logs in <code>/etc/docker/daemon.json</code>.</li>
    <li><strong>Nginx</strong> from system packages as a stable front.</li>
    <li><strong>Certbot</strong> and TLS by phase (HTTP-01 or self-signed certificate in the lab).</li>
  </ul>
  <p>Each piece has an observable role: <code>systemctl status</code>, <code>nginx -t</code>, <code>docker compose ps</code>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Console</p>
  <h2 class="doc-block-heading">Shell ergonomics</h2>
  <p class="doc-block-intro">For consistent SSH sessions, the wiki <a href="https://wiki.ldeluipy.es/initialConfiguration.html">initialConfiguration</a> guide was applied:</p>
  <ul class="doc-list">
    <li>Readable Bash prompt (path, command status, visual hints).</li>
    <li>History and safe defaults that reduce repeated mistakes.</li>
    <li>Aliases and <code>PATH</code> geared toward Compose and Git under <code>/opt/...</code>.</li>
  </ul>
  <p>This base, documented off-server, lets the same template be repeated on other VPS instances without improvising.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Tooling</p>
  <h2 class="doc-block-heading">cursor-agent</h2>
  <div class="doc-callout">
    <span class="doc-callout-title">Command-line assistance</span>
    <p><strong>cursor-agent</strong> was installed to bring daily work closer to an assisted development flow: reviews, helper scripts, and incremental documentation from the console.</p>
    <p>It does not replace human review or team controls, but it lowers friction on repeatable tasks (Compose overlays, validating Nginx before reload, etc.).</p>
  </div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">End of day</p>
  <h2 class="doc-block-heading">State at the end of day 0</h2>
  <p class="doc-block-intro">By the end of the day, the server satisfies three properties:</p>
  <ol class="doc-steps">
    <li><strong>Auditable:</strong> known disk layout and packages.</li>
    <li><strong>Repeatable:</strong> main steps linked to wiki and runbooks.</li>
    <li><strong>Ready</strong> for Docker without exposing services publicly too early.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Next step</p>
  <h2 class="doc-block-heading">Day 1</h2>
  <p class="doc-closing"><strong>Day 1</strong> brings up OpenCloud, the proxy virtual host, and the KM0 site over TLS. In the meantime, explore the published <a href="/en/#services">services</a> or <a href="/en/#contact">get in touch</a> if you want to collaborate.</p>
</section>
