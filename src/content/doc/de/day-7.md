---
title: "Tag 7 - Von der Anfrage zum Ticket, automatisiert"
description: "End-to-End-Automatisierung: Ideenformular und Admin Help machen aus Eingaben klare Tickets, mit menschlicher Prüfung vor der Umsetzung."
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
  <p class="doc-block-title">Warum es passt</p>
  <h2 class="doc-block-heading">Ein praktisches Muster für kleine Teams</h2>
  <p class="doc-block-intro">Es ging uns nicht um Automatisierung um ihrer selbst willen. Wir wollten, dass sinnvolle Anfragen nicht in Chats, E-Mails oder im Kopf von jemandem verschwinden. Das System macht aus jeder Eingabe in Sekunden ein lesbares Ticket mit Kontext und Umfang.</p>
  <ul class="doc-list">
    <li><strong>Schnelligkeit:</strong> wer schreibt, wartet nicht, bis jemand Zeit findet, die Störung sauber zu formulieren.</li>
    <li><strong>Qualität:</strong> jeder Entwurf folgt derselben Struktur (was passiert, für wen, was erwartet wird).</li>
    <li><strong>Kontrolle:</strong> nichts geht in die Entwicklung, bevor eine Person im Team zustimmt.</li>
    <li><strong>Wiederverwendbar:</strong> dasselbe Muster gilt für öffentliches Feedback und interne Anfragen.</li>
  </ul>
  <p>Für KM0 passt das besonders: Wir hören von nicht-technischen Menschen und wollen deren Input mit derselben Sorgfalt behandeln wie den Bericht eines Shop-Administrators.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Wo es gilt</p>
  <h2 class="doc-block-heading">Zwei Eingänge, ein Weg</h2>
  <ul class="doc-list">
    <li><strong>KM0-Nutzer:</strong> das Formular <a href="/de/ideas/">Ideen</a> auf km0digital.com. Produktvorschläge, Website-Verbesserungen oder Lücken, die jemand beim Cloud-Nutzung bemerkt.</li>
    <li><strong>Wer ein internes Projekt betreibt:</strong> der Admin-Help-Bildschirm eines Online-Shops in Staging. Wenn jemand im Team einen Fehler sieht oder eine Änderung braucht und sie nachvollziehbar festhalten will.</li>
  </ul>
  <p>In beiden Fällen ist der Weg derselbe: Formular → Warteschlange → formuliertes Ticket → menschliche Prüfung → Umsetzung. Nur wer schreibt und wo, ändert sich, nicht die Logik.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Beispiele</p>
  <h2 class="doc-block-heading">So sieht es in der Praxis aus</h2>
  <p class="doc-block-intro">Stell dir vor, jemand sendet über <a href="/de/ideas/">Ideen</a>: „Ich hätte gern einen Button zum Teilen von Blog-Beiträgen.“ In etwa fünfzehn Sekunden entsteht ein überschriebenes, geordnetes Ticket: was die Person will, in welcher Sprache sie schrieb, welchen Teil der Site es betrifft. Es ist als <em>wartet auf menschliche Prüfung</em> markiert.</p>
  <p>Jemand im Team liest es. Steht der Text, entfernt er die Markierung und das Ticket geht in die automatische Umsetzungs-Warteschlange. Braucht es Feinschliff („nur mobil“, „WhatsApp-Icon“), wird das Ticket vor der Freigabe bearbeitet. Ohne die Originalnachricht von Hand neu zu tippen.</p>
  <p>Ein anderer Fall: Ein Shop-Admin in Staging meldet über Admin Help, dass ein Produktfilter nicht richtig speichert. Gleiche Mechanik: klares Ticket, Prüfschritt, dann Entwicklung. Ziel ist, dass niemand raten muss, was der Absender meinte.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Menschen</p>
  <h2 class="doc-block-heading">Was Automatisierung tut (und was nicht)</h2>
  <p class="doc-block-intro">Die Maschine formuliert und ordnet ein. Eine Person entscheidet. Entwicklungs-Agenten greifen keine Tickets auf, solange sie noch als ungeprüft markiert sind. So bauen wir nicht blind auf vagen Nachrichten oder Spam auf.</p>
  <p>Für jemanden, der eine Idee sendet, ist der Nutzen einfach: einmal in normaler Sprache schreiben, und das Team bekommt etwas Umsetzbares. Für den Betrieb heißt es: nicht mehr dauernd Übersetzer zwischen „WhatsApp-Nachricht“ und „gut geschriebenem Ticket“ sein.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Ergebnis</p>
  <h2 class="doc-block-heading">Was Tag 7 erreicht hat</h2>
  <p class="doc-block-intro">Der manuelle Schritt zwischen „jemand bittet um etwas“ und „es gibt ein Ticket, das umgesetzt werden kann“ entfällt in Produktion (öffentliche KM0-Ideen) und in der E-Commerce-Staging-Umgebung (Admin Help).</p>
  <p>Heute funktioniert der ganze Kreislauf: Anfrage, formuliertes Ticket, menschliche Freigabe und agentenunterstützte Umsetzung. Das war das fehlende Stück, um Zuhören in der Community und durchdachte Lieferung zu verbinden.</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Serie</p>
  <h2 class="doc-block-heading">Tage 1–6</h2>
  <p class="doc-closing">Frühere Einträge decken den Stack ab (OpenCloud, Dex, LDAP, native Clients, Tutorials, Vision). Tag 7 ergänzt die Feedback-Schleife: probiere das <a href="/de/ideas/">Ideenformular</a> oder lies <a href="/de/doc/day-6/">Tag 6</a> für Geräte-Onboarding. Fragen: <a href="/de/#contact">Kontakt</a>.</p>
</section>
