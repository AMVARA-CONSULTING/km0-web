---
title: "Day 0 — Server foundations"
description: "Debian, partitioning, Docker, Nginx, and a reproducible base so the KM0 stack stays auditable and operable."
pubDate: 2026-05-21
locale: en
---

<p class="doc-lead">Day 0 is dedicated to <strong>foundations</strong>: without a reproducible operating system and working environment, any later stack would be fragile and hard to audit. The goal is to end the day with stable Debian, an orderly disk layout, minimal but sufficient tooling, and a shell that encourages documenting every change.</p>

## Bootstrap technical plan (full picture)

<p>KM0 aims for infrastructure that the team can operate without opaque proprietary panels:</p>

<ul class="doc-list">
  <li><strong>System:</strong> VPS on up-to-date Debian, with a partition scheme that separates system from data where it makes sense (easier snapshots and backup policies).</li>
  <li><strong>Collaboration:</strong> <a href="https://cloud.km0.amvara.de">OpenCloud</a> deployed as coordinated microservices inside an official image maintained by the <a href="https://opencloud.eu">OpenCloud.eu</a> community, with stable volume naming (<code>COMPOSE_PROJECT_NAME</code>) so backups do not depend on the directory from which Compose is run.</li>
  <li><strong>Perimeter:</strong> Nginx as the sole HTTPS front; Docker overlays that publish HTTP only on <code>127.0.0.1</code>.</li>
  <li><strong>Communication:</strong> Dockerized Astro site serving static files on another loopback port; separate virtual hosts for marketing (<code>km0.amvara.de</code>) and cloud (<code>cloud.km0.amvara.de</code>).</li>
  <li><strong>Observability:</strong> rotated container logs (<code>json-file</code> with a max size), routine commands documented in runbooks (<code>docker compose ps</code>, <code>logs</code>, <code>pull</code>), volume backups as compressed artifacts.</li>
  <li><strong>Evolution:</strong> harden TLS between internal microservices once certificates are fully trusted in chain, automate backups, and tighten Fail2ban policies per specific jails.</li>
</ul>

## VPS provisioning and partitions

<p>A <strong>Debian</strong> server was chosen for predictable package cycles and extensive documentation for hands-on administration (no mandatory control panels). The first step was to review disk layout and create partitions aligned with intended use:</p>

<ul class="doc-list">
  <li>Separation that lets project data grow without mixing it with the root filesystem when volume-level backup is needed.</li>
  <li>Clear mount criteria: <code>/var/lib/docker</code> may concentrate OpenCloud I/O depending on VPS size.</li>
  <li>Documented conventions so anyone on the team can tell persistent data mounts from system mounts.</li>
</ul>

<div class="doc-note">Exact partition maps depend on provider and contracted size; what matters is documenting them outside this blog in the project wiki or runbook for disaster recovery.</div>

## Base software

<p>A reasonable minimum was installed for secure remote administration and building on Docker without unnecessary bloat:</p>

<ul class="doc-list">
  <li>Common system tools: <code>curl</code>, editors, network and diagnostic utilities.</li>
  <li><strong>Docker Engine</strong> with rotated log policy (<code>/etc/docker/daemon.json</code>) so logs do not fill the disk.</li>
  <li><strong>Nginx</strong> from system packages as a stable front.</li>
  <li><strong>Certbot</strong> and TLS strategy by project phase (HTTP-01 issuance or self-signed certificate for lab work).</li>
</ul>

<p>The idea is that each component has a single, observable role in the dependency tree: <code>systemctl status</code>, <code>nginx -t</code>, <code>docker compose ps</code>.</p>

<hr />

## Shell ergonomics and reproducible setup

<p>To keep later SSH sessions consistent, improvements followed the wiki’s internal <a href="https://wiki.ldeluipy.es/initialConfiguration.html">initialConfiguration</a> guide:</p>

<ul class="doc-list">
  <li>A more readable Bash prompt (current directory, command status, visual hints).</li>
  <li>Settings that reduce repeated mistakes (useful history, safe defaults where applicable).</li>
  <li>Aliases and <code>PATH</code> conventions that anticipate Docker Compose and Git work under <code>/opt/...</code>.</li>
</ul>

<p>Having this base written down off-server lets the same template be repeated on other project VPS instances without improvising each time.</p>

## cursor-agent

<div class="doc-callout">
  <span class="doc-callout-title">Command-line assistance</span>
  <p><strong>cursor-agent</strong> was installed to bring day-to-day server work closer to an assisted development flow: automated reviews, helper scripts, and incremental documentation without leaving the console.</p>
  <p>It does not replace human review or team change controls, but it lowers friction for verifiable repeat tasks (updating Compose overlays, validating Nginx syntax before reload, etc.).</p>
</div>

## State at the end of day 0

<p>By the end of the day the server satisfies three properties:</p>

<ol class="doc-steps">
  <li><strong>Auditable:</strong> known disk layout and packages.</li>
  <li><strong>Repeatable:</strong> main steps link to wiki and runbooks.</li>
  <li><strong>Ready</strong> for Docker workloads without prematurely exposing services to the public.</li>
</ol>

<div class="doc-closing">
  <strong>Day 1</strong> builds on this base to bring up OpenCloud, the proxy virtual host, and the KM0 site over TLS. In the meantime, explore the published <a href="/en/#servicios">services</a> or <a href="/en/#contacto">get in touch</a> if you want to collaborate.
</div>
