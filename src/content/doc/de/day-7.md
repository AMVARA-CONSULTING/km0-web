---
title: "Tag 7 - Vom Nutzerwunsch zum GitHub-Issue, automatisiert"
description: "End-to-End-Automatisierung: /ideas/ und Admin-Help-Formulare stellen JSON in die Queue, cursor-agent entwirft strukturierte Issues, menschliches Validierungs-Gate, dann Autoagents-Implementierung."
pubDate: 2026-06-04
locale: de
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einleitung</p>
  <p class="doc-lead">Tag 7 ist ein Sondereintrag: Er dokumentiert Automatisierung, die eine Lücke schließt, die die früheren Tage offen ließen. Jemand reichte eine Idee oder Störung ein; ein Entwickler las Rohtext, formulierte daraus ein GitHub-Issue und erst dann begann die Implementierung. Diese Übergabe war der Engpass.</p>
  <p class="doc-lead">Am 4. Juni 2026 haben wir die vollständige Schleife in zwei Kanälen verdrahtet: öffentliches Feedback auf <a href="https://km0digital.com/de/ideas/">km0digital.com</a> (Produktion) und internes Admin Help auf einem Laravel-E-Commerce-Staging-Stack. Gleiches Modell: Queue, Autoissue-Entwurf, menschliches Label, Autoagents-Pickup.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Zusammenfassung</p>
  <h2 class="doc-block-heading">Vorher und nachher</h2>
  <ul class="doc-list">
    <li><strong>Anfrage:</strong> lose Nachricht oder E-Mail → strukturiertes JSON in der Queue.</li>
    <li><strong>Verständnis:</strong> Dev interpretiert Rohtext → <code>cursor-agent</code> schreibt strukturierten <code>.md</code>-Entwurf.</li>
    <li><strong>Ticket:</strong> manuelles <code>gh issue create</code> → automatisiertes Issue mit sauberem Markdown-Body.</li>
    <li><strong>Menschliche Kontrolle:</strong> implizit → Label <code>waiting for human validation</code>.</li>
    <li><strong>Implementierung:</strong> Dev weist zu → Mensch entfernt Label → Autoagents (001 / FEAT) übernehmen das Issue.</li>
  </ul>
  <p>Der Entwickler muss die Roheinreichung nicht mehr öffnen und das Ticket von Grund auf schreiben. Das System stellt in die Queue, entwirft und veröffentlicht in Sekunden auf GitHub. Ein Mensch validiert oder korrigiert durch Entfernen des Labels; danach kann die Agent-Pipeline implementieren.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Architektur</p>
  <h2 class="doc-block-heading">Zwei Eingänge, ein Muster</h2>
  <div class="doc-note"><pre>EINGANG
  km0-web:     POST /hooks/ideas        (öffentlich /ideas/)
  ecommerce:   POST /api/v1/admin/help  (auth /admin/help)
        ↓
  JSON-Queue (Spool / Storage)
        ↓
  Sofortiger Trigger (systemd path / Queue-Job)
        ↓
  cursor-agent (--yolo) + Autoissue-Prompt → Entwurf .md
        ↓
  gh issue create --body-file + Label waiting for human validation
        ↓
  Mensch prüft → entfernt Label → Autoagents 001 → FEAT → Code</pre></div>
</section>

<section class="doc-block">
  <p class="doc-block-title">km0-web</p>
  <h2 class="doc-block-heading">Öffentliche Ideen (<code>/ideas/</code>)</h2>
  <p class="doc-block-intro"><strong>Host:</strong> Produktions-VPS · <strong>Repo:</strong> <a href="https://github.com/AMVARA-CONSULTING/km0-web">AMVARA-CONSULTING/km0-web</a></p>
  <p>Issue <a href="https://github.com/AMVARA-CONSULTING/km0-web/issues/14">#14</a> lieferte nur Script 1 (Formular + Webhook + Enqueue). Script 2, systemd-Units, Host-Spool <code>/var/spool/km0-ideas/</code> und Docker-Bind-Mount wurden nie deployed. JSON stapelte sich in <code>incoming/</code> ohne Consumer.</p>
  <h3 class="doc-block-heading">Was wir deployed haben</h3>
  <ul class="doc-list">
    <li><strong>Script 2:</strong> <code>scripts/process-idea.sh</code>, <code>scripts/setup-ideas-processor.sh</code>, <code>scripts/autoissue.sh</code>.</li>
    <li><strong>systemd:</strong> <code>deploy/systemd/km0-idea-processor.{path,service,timer}</code> (Path bei neuem JSON; 24-h-Timer-Fallback).</li>
    <li><strong>Docker:</strong> Bind-Mount <code>/var/spool/km0-ideas/incoming</code> in <code>docker-compose.yml</code>.</li>
    <li><strong>Autoissue:</strong> Prompt <code>autoissue/autoissue-agent.md</code>; <code>cursor-agent</code> schreibt Entwurf unter <code>autoissue/drafts/</code>; Frontmatter parsen; <code>gh issue create --body-file</code>.</li>
    <li><strong>Gate:</strong> Label <code>waiting for human validation</code>; <code>issue_checker_agent.py</code> und <code>001-gh-reviewer.md</code> überspringen gelabelte Issues.</li>
  </ul>
  <div class="doc-note"><pre>Browser POST /hooks/ideas
  → receive-idea.sh → JSON in incoming/
  → systemd path trigger
  → autoissue.sh → cursor-agent → Entwurf .md
  → gh issue create → archiviert JSON + Entwurf in processed/</pre></div>
  <p>Verifikation: 10/10 PASS (Formular → Queue, ~15 s E2E, sauberes Markdown in <a href="https://github.com/AMVARA-CONSULTING/km0-web/issues/17">Issue #17</a>, Label gesetzt, Autoagents ignorieren bis Entfernung).</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">laravel-ecommerce</p>
  <h2 class="doc-block-heading">Admin Help (Staging)</h2>
  <p class="doc-block-intro"><strong>Staging:</strong> <a href="https://stage-serra.ldeluipy.es">stage-serra.ldeluipy.es</a> · <strong>Branch:</strong> <code>autoagents</code> · <strong>Repo:</strong> <a href="https://github.com/Luipy56/laravel-ecommerce">Luipy56/laravel-ecommerce</a></p>
  <p>Drei Blocker am selben Tag gelöst: CI grün, aber <code>STAGE_DEPLOY_ENABLED=false</code> (alter Container, API 404); kaputtes Deploy-SSH (<code>PROD_PORT=60022</code>); Admin Help hinter km0 (5-Min-Scheduler, JSON-Prompt, kein menschliches Gate).</p>
  <ul class="doc-list">
    <li><strong>CI/CD:</strong> Staging-Deploy via GitHub Actions (<code>stage.yml</code>); SSH-Secrets korrigiert; Container bei <code>0.1.340+</code>.</li>
    <li><strong>Autoissue wie km0:</strong> <code>autoissue/admin-help-agent.md</code>, <code>AdminHelpIssueProcessor</code>, <code>ProcessAdminHelpIssueJob</code> beim POST; täglicher Fallback <code>admin-help:process</code> um 03:00 UTC.</li>
    <li><strong>Runtime:</strong> <code>docker-compose.stage.yml</code> mountet <code>cursor-agent</code> und Auth vom Host; <code>GH_TOKEN</code> in <code>.env</code>.</li>
  </ul>
  <p>Verifiziert: E2E-Autoissue-Test in <a href="https://github.com/Luipy56/laravel-ecommerce/issues/27">Issue #27</a> auf Staging, vom Operator bestätigt. Admin Help live unter <code>/admin/help</code> (<a href="https://github.com/Luipy56/laravel-ecommerce/issues/26">#26</a>).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Vergleich</p>
  <h2 class="doc-block-heading">Zwei Zielgruppen, eine Pipeline</h2>
  <ul class="doc-list">
    <li><strong>km0-web:</strong> öffentlicher Nutzer → <code>/ideas/</code> → Host-Spool → systemd path (+ 24-h-Timer) → Beispiel <a href="https://github.com/AMVARA-CONSULTING/km0-web/issues/17">#17</a>.</li>
    <li><strong>laravel-ecommerce:</strong> interner Admin → <code>/admin/help</code> → Laravel-Storage-Queue → Queue-Job (+ täglicher Cron) → Beispiel <a href="https://github.com/Luipy56/laravel-ecommerce/issues/27">#27</a>.</li>
    <li><strong>Gemeinsam:</strong> cursor-agent-Entwurf, <code>waiting for human validation</code>, Autoagents nach Label-Entfernung.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Ergebnis</p>
  <h2 class="doc-block-heading">Was Tag 7 erreicht hat</h2>
  <p class="doc-block-intro">Der manuelle Schritt zwischen „jemand bittet um etwas“ und „es gibt ein GitHub-Issue, das ein Entwickler oder Agent implementieren kann“ entfällt in Produktion (km0 öffentliche Ideen) und Staging (E-Commerce Admin Help).</p>
  <p>Push auf <code>autoagents</code> bei E-Commerce aktualisiert Staging in etwa zwei bis drei Minuten. Beide Stacks teilen dasselbe Gate: Ticket automatisch entwerfen, menschliche Validierung halten, Autoagents implementieren lassen, wenn freigegeben.</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Serie</p>
  <h2 class="doc-block-heading">Tage 1–6</h2>
  <p class="doc-closing">Frühere Einträge decken den Stack ab (OpenCloud, Dex, LDAP, native Clients, Tutorials, Vision). Tag 7 ergänzt die Feedback-Schleife: probiere das <a href="/de/ideas/">Ideenformular</a> oder lies <a href="/de/doc/day-6/">Tag 6</a> für Geräte-Onboarding. Fragen: <a href="/de/#contact">Kontakt</a>.</p>
</section>
