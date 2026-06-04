---
title: "Tag 6 - Native Clients, Tutorials und eine Website passend zur Vision"
description: "KM0 Cloud auf jedem Gerät: Dex-OIDC-Clients für Desktop- und Mobile-Sync, Loopback-Login-Fix, Marken-Linkvorschauen, mehrsprachige Tutorials und erneuerte km0digital.com-Startseite."
pubDate: 2026-06-03
locale: de
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einleitung</p>
  <p class="doc-lead">Tag 6 folgt auf das <a href="/de/doc/day-5/">Visionstreffen</a>: Der Stack lief bereits im Browser (Tage 1–4), aber echte Nutzer brauchen auch native Apps, klares Onboarding und eine öffentliche Website, die dieselbe Geschichte erzählt. Dieser Eintrag fasst diese Arbeit zusammen, ohne einzelne Kalendertage zu nennen.</p>
  <p class="doc-lead">Zwei Fronten laufen parallel: <strong>km0digital.com</strong> erhält bewegungsorientierte Texte, Sicherheits-FAQs und Schritt-für-Schritt-Cloud-Anleitungen; <strong>cloud.km0digital.com</strong> bekommt OIDC-Fixes für Desktop- und Mobile-Sync, KM0-Branding und reichere Linkvorschauen beim Teilen.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Zusammenfassung</p>
  <h2 class="doc-block-heading">Was sich geändert hat</h2>
  <ul class="doc-list">
    <li><strong>Website:</strong> Vision- und Community-Abschnitte auf der Startseite; FAQ-Akkordeon; Sicherheitsantworten (ISO 27001 bei AMVARA, EU-Hosting); <a href="/de/tutorials/">KM0-Cloud-Tutorials</a> für Web, Android und iOS in vier Sprachen; Outreach-Decks (CA/ES/EN) als PPT und PDF.</li>
    <li><strong>Native Auth:</strong> statische Dex-OIDC-Clients für <code>OpenCloudDesktop</code>, <code>OpenCloudAndroid</code> und <code>OpenCloudIOS</code>; nginx leitet nur den Web-Browser-Client zu <code>/login.html</code> um.</li>
    <li><strong>Desktop-Loopback:</strong> Dex-Upgrade auf <code>v2.42.0</code> für OAuth-Redirect-URIs wie <code>http://127.0.0.1:&lt;port&gt;</code> (RFC 8252).</li>
    <li><strong>Marke &amp; Sharing:</strong> KM0-Favicon auf Login, Dex und authentifizierter SPA; Open-Graph-/Twitter-Karten und <code>/brand/og-preview.png</code> für Social Crawler.</li>
    <li><strong>Horizont:</strong> Facebook-Login über Dex OAuth untersucht; dokumentiert und env-gated, in Produktion noch nicht aktiv.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Unternehmenswebsite</p>
  <h2 class="doc-block-heading">Von der Vision zum Onboarding</h2>
  <p class="doc-block-intro">Nach Tag 5 musste die Startseite die Community-Narrative widerspiegeln, nicht nur den technischen Stack. Neue <strong>Vision</strong>- und <strong>Community</strong>-Abschnitte, erneuerte Texte in allen Sprachen und ein schlankerer Footer (GitHub + AMVARA) verankern die Geschichte in Menschen und Ort.</p>
  <p>Die FAQ wurde als gemessenes Akkordeon neu aufgebaut (ein Panel gleichzeitig offen) und um ehrliche Sicherheitsantworten erweitert: AMVARA CONSULTING S.L. hat ISO 27001; KM0-Cloud-Scope-Zertifizierung ist geplant; Daten bleiben in der EU; kein Training fremder Modelle mit Kundendateien.</p>
  <p>Onboarding-Anleitungen liegen unter <a href="/de/tutorials/">/de/tutorials/</a>: Einstieg im Web, auf Android und iOS, jeweils lokalisiert. Der Services-Block verlinkt direkt auf die Web-Anleitung, damit neue Nutzer nach dem Cloud-Lesen nicht ratlos sind.</p>
  <p>Drei Präsentationen (<em>Origen Local</em> auf Katalanisch, <em>Impacto Digital</em> auf Spanisch, <em>Sovereign Tech</em> auf Englisch) wurden aus Site- und Stack-Inhalten für Community-Outreach nach dem Masnou-Treffen erzeugt.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Native Sync-Clients und OIDC</h2>
  <p class="doc-block-intro">Web-Login über Dex LDAP (Tag 4) funktionierte; Android-, iOS- und Desktop-Apps scheiterten mit <code>invalid client_id</code>. Dex hatte keine statischen Clients für die nativen App-IDs, und nginx leitete <em>jede</em> <code>/dex/auth</code>-Anfrage zum hybriden <code>login.html</code> um, das native Clients nicht rendern können.</p>
  <ul class="doc-list">
    <li><strong>Dex:</strong> <code>opencloud-web</code>, <code>OpenCloudDesktop</code>, <code>OpenCloudAndroid</code> und <code>OpenCloudIOS</code> mit den Redirect-URIs jeder Plattform registrieren.</li>
    <li><strong>nginx:</strong> Umleitung zu <code>/login.html</code> nur bei <code>client_id=opencloud-web</code>; Mobile- und Desktop-Clients behalten den Dex-Autorisierungs-Endpunkt.</li>
  </ul>
  <p>Serverseitige Smoke-Checks bestehen (WebFinger, Auth-Endpunkt-Statuscodes). Vollständiger Datei-Sync auf einem echten Gerät bleibt Operator-Verifikation.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Warum Desktop Dex v2.42.0 brauchte</h2>
  <p class="doc-block-intro">Selbst mit registriertem Client scheiterte die Desktop-App: Sie nutzt OAuth-Loopback (<code>http://127.0.0.1:&lt;zufälliger-port&gt;</code> bei jedem Login). Dex <code>v2.41.1</code> verlangte exakte Redirect-URI-Übereinstimmung; ein fester <code>http://127.0.0.1</code>-Eintrag deckt keinen neuen Port bei jedem Login ab.</p>
  <p>Upgrade auf <code>ghcr.io/dexidp/dex:v2.42.0</code> und <code>OpenCloudDesktop</code> mit leeren <code>redirectURIs</code>, damit Dex jeden Loopback-Port auf <code>127.0.0.1</code> oder <code>localhost</code> akzeptiert. Web- und Mobile-Clients nutzten bereits feste HTTPS- oder Custom-Scheme-URIs und brauchten diese Änderung nicht.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">KM0-Favicon und Linkvorschauen</h2>
  <p class="doc-block-intro">Geteilte Cloud-Links zeigten zuvor generische OpenCloud-Metadaten. nginx injiziert Open-Graph- und Twitter-Tags für Crawler; Dex und <code>login.html</code> tragen denselben KM0-Titel und dasselbe Vorschaubild (<code>/brand/og-preview.png</code>).</p>
  <p>Das KM0-Gradient-Pin-Favicon ersetzt das Standard-OpenCloud-Icon auf der Login-Seite, Dex-LDAP-Screens und im authentifizierten SPA-Theme-Pfad, damit Tabs und Lesezeichen zu <a href="https://km0digital.com/">km0digital.com</a> passen.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Horizont</p>
  <h2 class="doc-block-heading">Facebook-Login (nur Untersuchung)</h2>
  <p class="doc-block-intro">Meta-Login wurde für Dex als upstream OAuth-Connector eingeplant (Dex bleibt alleiniger OIDC-Issuer für OpenCloud). Die Untersuchung ist abgeschlossen: Beispielconfig, env-gated Entrypoint-Hook und Runbook-Hinweise zu App Review und E-Mail-Claims.</p>
  <p>Produktivschaltung wartet auf Meta-App-Review und eine Produktentscheidung zu Konten ohne verifizierte E-Mail. Google, Apple und LDAP-Lokal-Login sind unberührt.</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Nächster Schritt</p>
  <h2 class="doc-block-heading">Tag 7</h2>
  <p class="doc-closing">Tag 6 schließt den Kreis zwischen Vision und Alltagsnutzung: Sync-Apps, Tutorials und eine Website, die beides erklärt. Ein <strong>besonderer Tag-7-Eintrag</strong> folgt separat. Bis dahin: <a href="/de/tutorials/">Cloud-Anleitungen</a> ausprobieren oder bei <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> anmelden.</p>
</section>
