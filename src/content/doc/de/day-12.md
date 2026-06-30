---
title: "Tag 12 - Kundengespräch: Nutzererfahrung"
description: "Gespräch mit einer echten Nutzerin über Tutorials, Service-Shortcuts auf der Website, Indexierung außerhalb Europas, vereinheitlichten Login und KM0-Datenschutzpositionierung."
pubDate: 2026-06-22
locale: de
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einleitung</p>
  <p class="doc-lead">Nach der Aktivierung von <a href="/de/doc/day-11/">KM0 Mail in Produktion</a> führten wir ein <strong>Kundengespräch</strong> (Luzma), das sich darauf konzentrierte, wie sich KM0 von außen anfühlt: wo der Login ist, was noch erklärt werden muss und welche kleinen Verbesserungen einen Unterschied machen würden, ohne das gesamte Produkt neu zu gestalten.</p>
  <p class="doc-lead">Dieser Beitrag ist keine wörtliche Abschrift; er fasst die umsetzbaren Themen zusammen und ordnet sie in die unmittelbare Roadmap für km0-web und verwandte Dienste ein.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Zusammenfassung</p>
  <h2 class="doc-block-heading">Kernthemen des Gesprächs</h2>
  <ul class="doc-list">
    <li><strong>Nutzererfahrung:</strong> einfache, sichtbare Tutorials, keine langen Handbücher oder Fachjargon.</li>
    <li><strong>Shortcuts:</strong> Google-ähnliches Neun-Punkte-Widget auf der Website mit Links zu Cloud, Mail, Registrierung und Dokumentation.</li>
    <li><strong>Neue Tutorials:</strong> macOS-Installation, Dateien teilen und kurzes Einstiegsvideo.</li>
    <li><strong>Indexierung:</strong> bessere Auffindbarkeit außerhalb der EU (Browser wie Brave mit regionalen Filtern).</li>
    <li><strong>Login und Zahlung:</strong> ein Zugangsfluss, klare Zahlungserklärung auf dem Hauptbildschirm, weniger verwirrende Logout-Seiten.</li>
    <li><strong>Datenschutz:</strong> verstärken, dass KM0 kein Megakonzern ist und Ihre Daten nicht monetarisiert.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Tutorials</p>
  <h2 class="doc-block-heading">In Minuten lernen, nicht in Stunden</h2>
  <p class="doc-block-intro">Die Nutzerin bat nicht um mehr Funktionen; sie wollte <strong>wissen, wo sie anfangen soll</strong>. Wiederkehrende Fragen: «Wo melde ich mich an?», «Wie installiere ich das auf meinem Mac?» und «Wie teile ich einen Ordner?».</p>
  <ul class="doc-list">
    <li><strong>macOS-Tutorial:</strong> Schritt-für-Schritt-Anleitung zur Installation und Verbindung der Desktop-App (separates km0-web-Issue).</li>
    <li><strong>Teilen:</strong> Screenshots oder kurzes Video zum Einladungs- und Berechtigungsfluss in OpenCloud.</li>
    <li><strong>Erste Schritte:</strong> Video von wenigen Minuten zu Registrierung, Login, Datei-Upload und Webmail-Zugang.</li>
    <li><strong>Login-Platzierung:</strong> sichtbare Links von der Startseite und vom Service-Widget, nicht nur von Subdomains.</li>
    <li><strong>Sprache:</strong> Materialien mindestens auf Spanisch und Katalanisch; die Website bietet bereits vier Locales.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Service-Widget</p>
  <h2 class="doc-block-heading">Shortcuts auf der Startseite</h2>
  <p class="doc-block-intro">Konkreter Vorschlag aus dem Gespräch: ein Google-ähnlicher Raster-Button auf der Landing Page, der KM0-Dienste ohne URL-Auswendiglernen auflistet.</p>
  <ul class="doc-list">
    <li><strong>Cloud:</strong> Link zu <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> mit Registrierung und Login.</li>
    <li><strong>Mail:</strong> Zugang zu <a href="https://mail.km0digital.com/">mail.km0digital.com</a> für Postfach-Inhaber.</li>
    <li><strong>Dokumentation:</strong> Link zum <a href="/de/doc/">Blog / Doc</a> und zur herunterladbaren <a href="/de/presentation/">Präsentation</a>.</li>
    <li><strong>Ideen und Kontakt:</strong> schneller Zugang zu <a href="/de/ideas/">Ideen</a> und <a href="/de/#contact">Kontakt</a>.</li>
    <li><strong>Umsetzung:</strong> leichtgewichtige Komponente in km0-web; ergänzt die aktuelle Navigation, ersetzt sie nicht.</li>
  </ul>
  <div class="doc-callout">
    <span class="doc-callout-title">Ziel</span>
    <p>Neue Nutzer sollen Cloud, Mail und Hilfe mit einem Klick von der Startseite erreichen, ohne die Fußzeile zu durchsuchen oder Subdomains zu erraten.</p>
  </div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Login und Zahlung</p>
  <h2 class="doc-block-heading">Ein Einstieg, weniger Reibung</h2>
  <p class="doc-block-intro">Heute existieren mehrere Einstiegspunkte (Web, Desktop-App, Roundcube). Das Gespräch machte klar, dass <strong>zwei verschiedene Logins verwirren</strong> und der Zahlungsbildschirm einen ehrlichen Satz vor dem Formular braucht.</p>
  <ul class="doc-list">
    <li><strong>Vereinheitlichter Login:</strong> gleiches Ziel von Desktop-App und öffentlicher Webseite (Produktarbeit läuft).</li>
    <li><strong>Zahlungstext:</strong> kurzer Text auf dem Haupt-Registrierungsbildschirm: was der Plan enthält, wann abgerechnet wird und wie man kündigt.</li>
    <li><strong>Logout:</strong> Zwischenseiten vereinfachen oder entfernen, die Nutzer feststecken lassen.</li>
    <li><strong>Desktop:</strong> die App soll dasselbe SSO wie der Browser öffnen, kein paralleles Formular.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Indexierung und Datenschutz</p>
  <h2 class="doc-block-heading">Außerhalb Europas gefunden werden und sagen, wer wir sind</h2>
  <p class="doc-block-intro">Ein Teil des Gesprächs betraf regionale Suchfilter (z. B. Brave) und die Notwendigkeit, dass km0digital erscheint, wenn jemand nach privaten Alternativen zu großen Cloud-Suiten sucht.</p>
  <ul class="doc-list">
    <li><strong>Internationales SEO:</strong> hreflang, Sitemap und Metadaten bereits in km0-web; Titel und Beschreibungen pro Locale weiter verbessern (Issue #58).</li>
    <li><strong>Nützlicher Inhalt:</strong> Blog-Beiträge wie dieser helfen der organischen Indexierung ohne bezahlte Kampagnen.</li>
    <li><strong>Datenschutzbotschaft:</strong> KM0 ist kein Megakonzern; wir verkaufen keine Profile und trainieren keine Modelle mit Ihren Dateien.</li>
    <li><strong>Transparenz:</strong> <a href="/de/legal/">Rechtliches</a> und <a href="/de/security/">Sicherheit</a> von Tutorials und Widget verlinkt.</li>
    <li><strong>Radar:</strong> wir bevorzugen Wachstum durch Empfehlungen und Vereine (<a href="/de/doc/day-13/">Tag 13</a>) statt Werbelärm.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Roadmap</p>
  <h2 class="doc-block-heading">Was nach diesem Gespräch folgt</h2>
  <ol class="doc-steps">
    <li><strong>Service-Widget</strong> auf der km0-web-Landing Page.</li>
    <li><strong>macOS-Tutorial</strong> und Teilen-Anleitung in Doc oder eingebettetem Video.</li>
    <li><strong>SEO-Verbesserungen</strong> und Indexierung außerhalb der EU (Issue #58).</li>
    <li><strong>Vereinheitlichter Login</strong> und Zahlungstext bei OpenCloud-Registrierung.</li>
    <li><strong>Einstiegsvideo</strong> von Startseite und Blog verlinkt.</li>
  </ol>
  <p>Die meisten Punkte sind kleine Änderungen im Stack; zusammen reduzieren sie die Reibung, die eine echte Nutzerin im Gespräch beschrieb.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verifikation</p>
  <h2 class="doc-block-heading">Das Bestehende testen</h2>
  <ol class="doc-steps">
    <li><strong>Startseite:</strong> <a href="/de/">km0digital.com</a> öffnen und Links zu Cloud, Mail und Doc finden.</li>
    <li><strong>Cloud:</strong> Testregistrierung unter <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</li>
    <li><strong>Mail:</strong> Webmail unter <a href="https://mail.km0digital.com/">mail.km0digital.com</a>, falls Sie ein Postfach haben.</li>
    <li><strong>Doc:</strong> <a href="/de/doc/day-11/">Tag 11</a> (Mail) und <a href="/de/doc/day-13/">Tag 13</a> (Meet 6) lesen.</li>
    <li><strong>Feedback:</strong> Verbesserungen über <a href="/de/ideas/">Ideen</a> oder <a href="/de/#contact">Kontakt</a> senden.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Serie</p>
  <h2 class="doc-block-heading">Verwandte Beiträge</h2>
  <p class="doc-closing">Am <a href="/de/doc/day-11/">Tag 11</a> wurde KM0 Mail dokumentiert; dieses Gespräch (Tag 12) fasst UX und Zugänglichkeit zusammen; am <a href="/de/doc/day-13/">Tag 13</a> steht Meet 6 zu Sichtbarkeit und Vereinen. Testen Sie das <a href="https://mail.km0digital.com/">Webmail</a>, sehen Sie <a href="/de/pricing/">Preise</a> und sagen Sie uns, welches Tutorial Ihnen fehlen würde.</p>
</section>
