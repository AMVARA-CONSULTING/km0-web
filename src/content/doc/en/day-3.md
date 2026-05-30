---
title: "Day 3 — Git repos, km0digital.com domains, and autoagents loop"
description: "OpenCloud Git repository, migration to km0digital.com, multilingual FAQ, mobile navigation, switchLocaleHref, and the autoagents loop in both repos."
pubDate: 2026-05-26
locale: en
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">Day 3 (operational window 26–27 May 2026, ~12 h on the Debian VPS) consolidates two fronts on the same host: OpenCloud gets its own Git repository with versioned deployment and a cutover plan to <code>cloud.km0digital.com</code>, and the corporate site migrates from <code>km0.amvara.de</code> to <a href="https://km0digital.com/">km0digital.com</a> with product improvements.</p>
  <p class="doc-lead">Both repos introduce the same autoagents loop (GitHub Issues → tasks → <code>cursor-agent</code>), and OpenCloud adds automatic Redmine closing notes when archiving tasks.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Summary</p>
  <h2 class="doc-block-heading">Day milestones</h2>
  <ul class="doc-list">
    <li><strong>OpenCloud:</strong> first Git commit of KM0 assets (<code>km0-opencloud</code>); templates aligned to <code>cloud.km0digital.com</code>; autoagents loop; <code>redmine_sync.py</code> on <code>CLOSED-*</code> archive.</li>
    <li><strong>Corporate site:</strong> migration to km0digital.com; blog slugs <code>day-*</code>; multilingual FAQ; footer semver; email “coming soon” modal; mobile hamburger menu; <code>switchLocaleHref</code>; version 1.1.4.</li>
    <li><strong>Shared:</strong> Cursor rules, <code>autoagents/SKILL.md</code>, <code>scripts/git-sync-main.sh</code>, <code>docs/agent-loop.md</code>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Architecture</p>
  <h2 class="doc-block-heading">Coexistence on one host</h2>
  <div class="doc-note"><pre>Internet :443
    ├── km0digital.com          → nginx km0       → 127.0.0.1:9180  (km0-web Docker)
    └── cloud.km0digital.com    → nginx opencloud → 127.0.0.1:9200  (OpenCloud external-proxy)
                                      └── /dex/*  → 127.0.0.1:5556  (Dex OIDC)</pre></div>
  <ul class="doc-list">
    <li><strong>Marketing:</strong> <a href="https://km0digital.com/">km0digital.com</a> — <code>/opt/km0-web</code>.</li>
    <li><strong>OpenCloud:</strong> <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> — <code>/opt/opencloud</code>.</li>
    <li><strong>Legacy:</strong> <code>km0.amvara.de</code> → 301 redirect to apex.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Git repository (km0-opencloud)</h2>
  <p class="doc-block-intro">Initial commit (<code>f454889</code>, 26 May 21:13 CEST) at <code>git@github.com:AMVARA-CONSULTING/km0-opencloud.git</code>, branch <code>main</code>. Versioned (63 files), including:</p>
  <ul class="doc-list">
    <li><code>overrides/opencloud-compose/</code> — CSP, external-proxy overlay, OIDC patch.</li>
    <li><code>dex/</code> — Dex compose, KM0 theme, login templates.</li>
    <li><code>nginx/</code> — vhost template for <code>cloud.km0digital.com</code>.</li>
    <li><code>host-www/opencloud-auth/</code> — hybrid login (<code>login.html</code>, auth JSON).</li>
    <li><code>scripts/</code> — backups, <code>apply-opencloud-compose-overrides.sh</code>.</li>
    <li><code>docs/</code> — runbook, Redmine summary.</li>
  </ul>
  <div class="doc-note">Outside Git (server only): upstream clone <code>opencloud-compose/</code>, live <code>.env</code>, OAuth secrets, Docker volumes, and <code>/etc/letsencrypt/</code>.</div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Domain migration and autoagents</h2>
  <p class="doc-block-intro">Commit <code>0b27952</code> (27 May 00:06 CEST): alignment of <code>OC_DOMAIN</code>, Dex issuer, nginx <code>server_name</code>, and templates to <code>cloud.km0digital.com</code>. New script <code>scripts/issue-cloud-km0digital-cert.sh</code> (DNS check + Certbot webroot).</p>
  <p>The autoagents loop was added (version <code>1.0.2</code>): orchestrator <code>autoagents-loop.sh</code>, coder/tester/closer/committer agents, <code>gh_issue_sync.py</code>, and <code>move-agent-task-to-done.sh</code>. Commit <code>7203b6f</code> (00:37 CEST): <code>redmine_sync.py</code> publishes a Textile summary to Redmine when archiving <code>CLOSED-*</code> tasks.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Corporate site</p>
  <h2 class="doc-block-heading">Content, hostname, and product</h2>
  <ul class="doc-list">
    <li><strong>Blog slugs:</strong> <code>dia-*</code> → <code>day-*</code> across all locales (<code>src/content/doc/{ca,de,en,es}/</code>).</li>
    <li><strong>Hostname migration</strong> (<code>bdc9e2c</code>, 23:42 CEST): main URLs <code>https://km0digital.com</code> (ES at <code>/</code>), <code>/ca/</code>, <code>/en/</code>, <code>/de/</code>, blog at <code>/doc/</code>; 301 redirect from <code>km0.amvara.de</code>.</li>
    <li><strong>FAQ</strong> (<code>23ec0bf</code>): multilingual section with <code>#faq</code> anchor; footer semver from <code>package.json</code>; “coming soon” modal for the email service.</li>
    <li><strong>Navigation</strong> (<code>e5cfa57</code>, 1.1.3): hamburger menu in <code>Header.astro</code>; <code>switchLocaleHref</code> / <code>stripLocalePrefix</code> in <code>src/i18n/paths.ts</code> to switch language without losing blog entry or hash.</li>
    <li><strong>Documentation</strong> (<code>67b62cc</code>, 1.1.4): simplified README; smoke task <code>CLOSED-4</code> validated the pipeline (loopback + production HTTP 200).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Autoagents</p>
  <h2 class="doc-block-heading">Closed tasks (km0-web)</h2>
  <ul class="doc-list">
    <li><strong>FAQ</strong> (GitHub #1): FAQ section, 4 locales.</li>
    <li><strong>Language</strong> (GitHub #2): <code>switchLocaleHref</code>.</li>
    <li><strong>Mobile menu</strong> (GitHub #3): hamburger navigation.</li>
    <li><strong>Smoke</strong> (test): autoagents loop — PASS on :9180 and production.</li>
  </ul>
  <p>Site version progression: Astro 5 baseline on :9180 → 1.1.3 (FAQ, semver footer, modal, mobile nav, locale) → 1.1.4 (README/docs).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verification</p>
  <h2 class="doc-block-heading">Reference checks</h2>
  <div class="doc-note"><pre>cd /opt/km0-web
docker compose build && docker compose up -d
curl -sI https://km0digital.com/
curl -sI http://127.0.0.1:9180/en/doc/day-0/

cd /opt/opencloud
docker compose -f opencloud-compose/docker-compose.yml ps
curl -sI https://cloud.km0digital.com/login.html</pre></div>
  <div class="doc-note">Secrets (<code>.env</code>, Redmine/GitHub keys, OAuth) are not part of this entry; they live only on the server and in the team's private operational documentation.</div>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Next step</p>
  <h2 class="doc-block-heading">Day 4</h2>
  <p class="doc-closing"><strong>Day 4</strong> replaces Dex's static password store with an LDAP connector to OpenCloud's IDM, so any directory user can sign in with the same credentials as in Settings. In the meantime, explore the <a href="/en/#services">services</a> or the <a href="/en/doc/day-4/">day 4 story</a>.</p>
</section>
