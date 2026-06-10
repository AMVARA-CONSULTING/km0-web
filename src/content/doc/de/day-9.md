---
title: "Tag 9 - Öffentliche Preise, Vertrauen und offene Registrierung"
description: "Preisseite mit Marktvergleich, Rechts- und Sicherheitsseiten in vier Sprachen, öffentliche Registrierung auf cloud.km0digital.com, E-Mail-Benachrichtigung ans Team bei Ideeneingang und Conversion-Polish auf Landingpage und Blog."
pubDate: 2026-06-10
locale: de
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einleitung</p>
  <p class="doc-lead">Am <a href="/de/doc/day-8/">Tag 8</a> wurden Strategie und Zahlen festgelegt; Tag 9 macht daraus ein veröffentlichbares Produkt. Zwischen dem 9. und 10. Juni 2026 deployten wir die <a href="/de/pricing/">Preisseite</a>, <a href="/de/legal/">Rechtliches</a> und <a href="/de/security/">Sicherheit</a>, Self-Registration auf <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> und Conversion-Verbesserungen auf Startseite und Blog.</p>
  <p class="doc-lead">KM0 ist nicht mehr nur „etwas, das funktioniert, wenn wir es erklären“, sondern ein Dienst, den jeder entdecken, vergleichen, registrieren und ohne Vermittler nutzen kann.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Zusammenfassung</p>
  <h2 class="doc-block-heading">Meilensteine des Tages</h2>
  <ul class="doc-list">
    <li><strong>Preise:</strong> <a href="/de/pricing/">/pricing/</a> mit 500 GB / 1,99 €-Hero, indikativer Vergleichstabelle, Modellerklärung und CTA zur Cloud (#24, #25).</li>
    <li><strong>Vertrauen:</strong> <a href="/de/legal/">Rechtliches</a> (Impressum, DSGVO-Datenschutz, Cookies) und <a href="/de/security/">Sicherheit</a> (AMVARA ISO 27001, Responsible Disclosure) in vier Sprachen (#21).</li>
    <li><strong>Registrierung:</strong> öffentliche E-Mail/Passwort-Self-Registration via <code>register-api</code> auf OpenCloud; Dex-Login mit <code>dex-auth.js</code> und Auto-Sign-in nach Registrierung.</li>
    <li><strong>Conversion:</strong> Landingpage mit sichtbarerem KM0 Cloud (#26); verfeinerte Blog- und Tutorial-Typografie (#27); polierte Service-Karten-CTAs.</li>
    <li><strong>Ideen:</strong> sofortige E-Mail ans Entwicklungsteam, wenn jemand eine Idee über <a href="/de/ideas/">/ideas/</a> sendet (<code>f41329c</code>).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Preise</p>
  <h2 class="doc-block-heading">Öffentliche Seite und Vergleich</h2>
  <p class="doc-block-intro">Das am Tag 8 vereinbarte Angebot erreicht die Website mit lokalisiertem Copy (ES, CA, EN, DE) und markenkonformem Design.</p>
  <ul class="doc-list">
    <li><strong>Hero:</strong> Preisblock mit Verlauf - <strong>1,99 €/Monat · 500 GB</strong> - und „Jetzt starten“-Button zu <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</li>
    <li><strong>Vergleich:</strong> indikative Referenzen (Google Drive, OneDrive, iCloud, Dropbox, MEGA) mit Monatspreis, Speicher und ungefähren Kosten pro TB.</li>
    <li><strong>Claim:</strong> bis zu fünfmal mehr Speicher als Referenz-Basistarife zum ähnlichen Preis; operativer Vertrauenstext unter der Tabelle.</li>
    <li><strong>Transparenz:</strong> Abschnitt „Warum ist unser Preis anders?“ - optimierte Infrastruktur, operative Effizienz, genug Marge für nachhaltigen Betrieb.</li>
  </ul>
  <p>Wichtige Commits: <code>7a7e9da</code> (Vergleich, 9. Jun), <code>9d7906c</code> (Messaging- und Trust-Rework, #25), <code>82a3ef0</code> / <code>65a32d2</code> (Hero und CTA, 10. Jun).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Vertrauen</p>
  <h2 class="doc-block-heading">Mehrsprachiges Rechtliches und Sicherheit</h2>
  <p class="doc-block-intro">Bevor wir Registrierung und Zahlung verlangen, muss die Website „wer betreibt das?“ und „was passiert mit meinen Daten?“ beantworten. Die neuen Seiten bündeln Rechtsinformationen für km0digital.com und cloud.km0digital.com.</p>
  <ul class="doc-list">
    <li><strong>Rechtliches</strong> (<code>cd5579e</code>, #21): Impressum AMVARA CONSULTING S.L., DSGVO-Datenschutz, Cookies und KM0-Cloud-spezifischer Abschnitt.</li>
    <li><strong>Sicherheit:</strong> operative Praktiken (TLS, Header, EU/Hetzner), AMVARA ISO/IEC 27001:2022-Geltungsbereich und Responsible-Disclosure-Richtlinie.</li>
    <li><strong>FAQ:</strong> bestehende Antworten verlinken jetzt auf <a href="/de/security/#iso27001">/security/</a> und <a href="/de/legal/">/legal/</a> in allen vier Locales.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Öffentliche Registrierung (km0-opencloud)</h2>
  <div class="doc-note"><pre>Nutzer → /register (register.html)
        ↓
  POST /api/register → register-api (:8091, nginx Rate Limit)
        ↓
  Graph API (App-Token) erstellt LDAP-Nutzer
        ↓
  dex-auth.js + Auto-Sign-in → Dex-Session → OpenCloud</pre></div>
  <ul class="doc-list">
    <li><strong>Self-Registration</strong> (<code>67fe250</code>, 10. Jun): <code>register.html</code>, Loopback-API, nginx-<code>/api/register</code>-Proxy, ES/CA/EN/DE-i18n.</li>
    <li><strong>Graph-Auth</strong> (<code>7d52675</code>): Fix mit <code>GRAPH_SERVICE_APP_TOKEN</code> (App-Basic-Auth, kein Nutzerpasswort); Health <code>graph_auth_ok</code>.</li>
    <li><strong>dex-auth.js</strong> (<code>efefcd3</code>): gemeinsames OIDC/PKCE-Modul für Login, Registrierung und Dex-Passwortseiten; Auto-Sign-in nach Registrierung via Session Storage.</li>
    <li><strong>Betrieb:</strong> Skripte <code>setup-register-api-graph-token.sh</code> und <code>verify-register-api.sh</code>; kanonische URL <code>/register</code> (301 von <code>/register.html</code>).</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Unternehmenswebsite</p>
  <h2 class="doc-block-heading">Conversion und Lesbarkeit (km0-web, 10. Jun)</h2>
  <ul class="doc-list">
    <li><strong>Landingpage</strong> (<code>5f021e4</code>, #26): sichtbareres KM0 Cloud, Barrierefreiheit und verfeinerte Conversion-CTAs.</li>
    <li><strong>Services</strong> (<code>471e407</code>): KM0-Cloud-Karte mit klaren CTAs zu Registrierung und Tutorials.</li>
    <li><strong>Blog</strong> (<code>2425cc1</code>, <code>4487bef</code>, #27): Artikeltypografie, Definitionslisten, mobiles TOC und allgemeine Lesbarkeit.</li>
    <li><strong>Styles</strong> (<code>e5223f4</code>): globaler CSS-Import im Layout; korrigierte <code>.doc-body</code>-Selektoren.</li>
  </ul>
  <p>Website-Version zum Abschluss: <strong>1.1.70</strong>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Ideen</p>
  <h2 class="doc-block-heading">E-Mail-Benachrichtigung ans Team (Last-Minute)</h2>
  <p class="doc-block-intro">Der Loop vom <a href="/de/doc/day-7/">Tag 7</a> hat Ideen bereits in die Warteschlange gestellt und GitHub-Tickets erzeugt, aber das Team erfuhr es erst beim Prüfen der Queue oder des Repositories. Mit der Marketingkampagne vom Tag 8 mussten wir schneller reagieren.</p>
  <div class="doc-note"><pre>POST /hooks/ideas → receive-idea.sh
        ↓
  JSON in /var/spool/km0-ideas/incoming/
        ↓
  notify-idea-email.sh (Hintergrund, Fire-and-Forget)
        ↓
  AutoMail API → E-Mail ans Team (Betreff + erste 100 Zeichen)
        ↓
  (unverändert) autoissue → gh issue create</pre></div>
  <ul class="doc-list">
    <li><strong>Skript:</strong> <code>scripts/notify-idea-email.sh</code> - ruft AutoMail auf (<code>AUTOMAIL_TOKEN</code> in Repo-<code>.env</code>); kein <code>cursor-agent</code>.</li>
    <li><strong>Auslöser:</strong> <code>receive-idea.sh</code> startet es im Hintergrund direkt nach dem Schreiben des JSON in die Queue.</li>
    <li><strong>Inhalt:</strong> Betreff „Nueva idea km0digital“ und Nachrichtenvorschau (100 Zeichen); Zieladresse konfigurierbar über <code>AUTOMAIL_NOTIFY_TO</code>.</li>
    <li><strong>Receiver:</strong> Docker-Webhook-Sidecar wechselt zu Host-systemd (<code>km0-ideas-receiver.service</code>); Secrets aus Repo-<code>.env</code>.</li>
  </ul>
  <p>Das automatisierte Ticket und das Label <code>waiting for human validation</code> bleiben gleich; die E-Mail ist nur ein früher Hinweis, damit jemand im Team die Idee liest, sobald sie eingeht.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verifikation</p>
  <h2 class="doc-block-heading">Tag 9 prüfen</h2>
  <ol class="doc-steps">
    <li><strong>Preise:</strong> <a href="/de/pricing/">/pricing/</a> besuchen und Hero, Tabelle und CTA in jeder Sprache prüfen.</li>
    <li><strong>Rechtliches:</strong> <a href="/de/legal/">/legal/</a> und <a href="/de/security/">/security/</a> prüfen; Links aus FAQ und Fußzeile.</li>
    <li><strong>Registrierung:</strong> Testkonto unter <a href="https://cloud.km0digital.com/register">cloud.km0digital.com/register</a> anlegen; Auto-Sign-in prüfen.</li>
    <li><strong>Ideen:</strong> Test über <a href="/de/ideas/">/ideas/</a> senden; JSON im Spool und Team-E-Mail via AutoMail prüfen.</li>
    <li><strong>Smoke:</strong> Autoagents-Loop - Issues #21, #24, #25, #26, #27 geschlossen; register-api Health OK.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Serie</p>
  <h2 class="doc-block-heading">Tage 1–8</h2>
  <p class="doc-closing">Am <a href="/de/doc/day-8/">Tag 8</a> stehen Strategie und vereinbarter Preis; frühere Tage decken den technischen Stack ab. Testen Sie <a href="https://cloud.km0digital.com/">KM0 Cloud</a>, sehen Sie <a href="/de/pricing/">Preise</a> oder senden Sie eine Idee über <a href="/de/ideas/">/ideas/</a>. Fragen: <a href="/de/#contact">Kontakt</a>.</p>
</section>
