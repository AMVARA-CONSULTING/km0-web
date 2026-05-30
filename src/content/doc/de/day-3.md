---
title: "Tag 3 — Git-Repos, km0digital.com-Domains und Autoagents-Schleife"
description: "OpenCloud-Git-Repository, Migration zu km0digital.com, mehrsprachige FAQ, mobile Navigation, switchLocaleHref und Autoagents-Schleife in beiden Repos."
pubDate: 2026-05-26
locale: de
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einleitung</p>
  <p class="doc-lead">Tag 3 (Betriebsfenster 26.–27. Mai 2026, ~12 h auf dem Debian-VPS) konsolidiert zwei Fronten auf demselben Host: OpenCloud erhält ein eigenes Git-Repository mit versioniertem Deployment und Cutover-Plan zu <code>cloud.km0digital.com</code>, und die Unternehmenswebsite migriert von <code>km0.amvara.de</code> zu <a href="https://km0digital.com/">km0digital.com</a> mit Produktverbesserungen.</p>
  <p class="doc-lead">In beiden Repos wird dieselbe Autoagents-Schleife eingeführt (GitHub Issues → Tasks → <code>cursor-agent</code>), und OpenCloud ergänzt automatische Redmine-Abschlussnotizen beim Archivieren von Tasks.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Zusammenfassung</p>
  <h2 class="doc-block-heading">Meilensteine des Tages</h2>
  <ul class="doc-list">
    <li><strong>OpenCloud:</strong> erster Git-Commit der KM0-Assets (<code>km0-opencloud</code>); Vorlagen auf <code>cloud.km0digital.com</code> ausgerichtet; Autoagents-Schleife; <code>redmine_sync.py</code> beim Archivieren von <code>CLOSED-*</code>.</li>
    <li><strong>Unternehmenswebsite:</strong> Migration zu km0digital.com; Blog-Slugs <code>day-*</code>; mehrsprachige FAQ; Footer-Semver; E-Mail-„Demnächst“-Modal; mobiles Hamburger-Menü; <code>switchLocaleHref</code>; Version 1.1.4.</li>
    <li><strong>Gemeinsam:</strong> Cursor-Regeln, <code>autoagents/SKILL.md</code>, <code>scripts/git-sync-main.sh</code>, <code>docs/agent-loop.md</code>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Architektur</p>
  <h2 class="doc-block-heading">Koexistenz auf einem Host</h2>
  <div class="doc-note"><pre>Internet :443
    ├── km0digital.com          → nginx km0       → 127.0.0.1:9180  (km0-web Docker)
    └── cloud.km0digital.com    → nginx opencloud → 127.0.0.1:9200  (OpenCloud external-proxy)
                                      └── /dex/*  → 127.0.0.1:5556  (Dex OIDC)</pre></div>
  <ul class="doc-list">
    <li><strong>Marketing:</strong> <a href="https://km0digital.com/">km0digital.com</a> — <code>/opt/km0-web</code>.</li>
    <li><strong>OpenCloud:</strong> <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> — <code>/opt/opencloud</code>.</li>
    <li><strong>Legacy:</strong> <code>km0.amvara.de</code> → 301-Weiterleitung zum Apex.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Git-Repository (km0-opencloud)</h2>
  <p class="doc-block-intro">Initialer Commit (<code>f454889</code>, 26. Mai 21:13 CEST) unter <code>git@github.com:AMVARA-CONSULTING/km0-opencloud.git</code>, Branch <code>main</code>. Versioniert (63 Dateien), u. a.:</p>
  <ul class="doc-list">
    <li><code>overrides/opencloud-compose/</code> — CSP, External-Proxy-Overlay, OIDC-Patch.</li>
    <li><code>dex/</code> — Dex-Compose, KM0-Theme, Login-Vorlagen.</li>
    <li><code>nginx/</code> — vhost-Vorlage für <code>cloud.km0digital.com</code>.</li>
    <li><code>host-www/opencloud-auth/</code> — hybrider Login (<code>login.html</code>, Auth-JSON).</li>
    <li><code>scripts/</code> — Backups, <code>apply-opencloud-compose-overrides.sh</code>.</li>
    <li><code>docs/</code> — Runbook, Redmine-Zusammenfassung.</li>
  </ul>
  <div class="doc-note">Außerhalb Git (nur Server): Upstream-Klon <code>opencloud-compose/</code>, live <code>.env</code>, OAuth-Secrets, Docker-Volumes und <code>/etc/letsencrypt/</code>.</div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Domain-Migration und Autoagents</h2>
  <p class="doc-block-intro">Commit <code>0b27952</code> (27. Mai 00:06 CEST): Ausrichtung von <code>OC_DOMAIN</code>, Dex-Issuer, nginx <code>server_name</code> und Vorlagen auf <code>cloud.km0digital.com</code>. Neues Skript <code>scripts/issue-cloud-km0digital-cert.sh</code> (DNS-Check + Certbot webroot).</p>
  <p>Autoagents-Schleife hinzugefügt (Version <code>1.0.2</code>): Orchestrator <code>autoagents-loop.sh</code>, Coder/Tester/Closer/Committer-Agenten, <code>gh_issue_sync.py</code> und <code>move-agent-task-to-done.sh</code>. Commit <code>7203b6f</code> (00:37 CEST): <code>redmine_sync.py</code> veröffentlicht Textile-Zusammenfassung in Redmine beim Archivieren von <code>CLOSED-*</code>-Tasks.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Unternehmenswebsite</p>
  <h2 class="doc-block-heading">Inhalt, Hostname und Produkt</h2>
  <ul class="doc-list">
    <li><strong>Blog-Slugs:</strong> <code>dia-*</code> → <code>day-*</code> in allen Locales (<code>src/content/doc/{ca,de,en,es}/</code>).</li>
    <li><strong>Hostname-Migration</strong> (<code>bdc9e2c</code>, 23:42 CEST): Haupt-URLs <code>https://km0digital.com</code> (DE unter <code>/de/</code>), Blog unter <code>/doc/</code>; 301-Weiterleitung von <code>km0.amvara.de</code>.</li>
    <li><strong>FAQ</strong> (<code>23ec0bf</code>): mehrsprachiger Abschnitt mit <code>#faq</code>-Anker; Footer-Semver aus <code>package.json</code>; „Demnächst“-Modal für E-Mail-Dienst.</li>
    <li><strong>Navigation</strong> (<code>e5cfa57</code>, 1.1.3): Hamburger-Menü in <code>Header.astro</code>; <code>switchLocaleHref</code> / <code>stripLocalePrefix</code> in <code>src/i18n/paths.ts</code> zum Sprachwechsel ohne Blog-Eintrag oder Hash zu verlieren.</li>
    <li><strong>Dokumentation</strong> (<code>67b62cc</code>, 1.1.4): vereinfachtes README; Smoke-Task <code>CLOSED-4</code> validierte Pipeline (Loopback + Produktion HTTP 200).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Autoagents</p>
  <h2 class="doc-block-heading">Abgeschlossene Tasks (km0-web)</h2>
  <ul class="doc-list">
    <li><strong>FAQ</strong> (GitHub #1): FAQ-Abschnitt, 4 Locales.</li>
    <li><strong>Sprache</strong> (GitHub #2): <code>switchLocaleHref</code>.</li>
    <li><strong>Mobiles Menü</strong> (GitHub #3): Hamburger-Navigation.</li>
    <li><strong>Smoke</strong> (Test): Autoagents-Schleife — PASS auf :9180 und Produktion.</li>
  </ul>
  <p>Site-Versionsfortschritt: Astro-5-Baseline auf :9180 → 1.1.3 (FAQ, Semver-Footer, Modal, mobile Nav, Locale) → 1.1.4 (README/Docs).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verifikation</p>
  <h2 class="doc-block-heading">Referenz-Checks</h2>
  <div class="doc-note"><pre>cd /opt/km0-web
docker compose build && docker compose up -d
curl -sI https://km0digital.com/
curl -sI http://127.0.0.1:9180/de/doc/day-0/

cd /opt/opencloud
docker compose -f opencloud-compose/docker-compose.yml ps
curl -sI https://cloud.km0digital.com/login.html</pre></div>
  <div class="doc-note">Secrets (<code>.env</code>, Redmine/GitHub-Schlüssel, OAuth) sind nicht Teil dieses Eintrags; sie existieren nur auf dem Server und in der privaten operativen Dokumentation des Teams.</div>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Nächster Schritt</p>
  <h2 class="doc-block-heading">Tag 4</h2>
  <p class="doc-closing"><strong>Tag 4</strong> ersetzt Dex' statischen Passwort-Speicher durch einen LDAP-Connector zum OpenCloud-IDM, sodass jeder Verzeichnisbenutzer sich mit denselben Zugangsdaten wie in den Einstellungen anmelden kann. In der Zwischenzeit: die <a href="/de/#services">Services</a> erkunden oder den <a href="/de/doc/day-4/">Bericht zu Tag 4</a> lesen.</p>
</section>
