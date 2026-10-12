---
title: "Erneute Anmeldung in OpenCloud Desktop nach dem gemeinsamen Login"
description: "OpenCloud-Desktop-Client mit dem gemeinsamen KM0-Login neu verbinden: Server-URL, Browser-Anmeldung und Sync-Ordner."
locale: de
order: 11
platform: desktop
product: cloud
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einführung</p>
  <p class="doc-lead">Nach dem gemeinsamen KM0-Login braucht der OpenCloud-Desktop-Client oft eine frische Kontoverbindung. Diese Anleitung folgt dem Assistenten Konto hinzufügen: Serveradresse, Browser-Login, dann Sync-Ordner. Bevorzugt den lokalen Ordner, den ihr schon nutzt. Serveradresse bleibt <code>https://cloud.km0digital.com/</code>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 1</p>
  <h2 class="doc-block-heading">Cloud-Serveradresse eingeben</h2>
  <ol class="doc-list">
    <li>OpenCloud Desktop Client öffnen.</li>
    <li>Beim Hinzufügen oder erneuten Verbinden erscheint <strong>Welcome</strong> und <strong>What is your server's address?</strong>.</li>
    <li>Genau <code>https://cloud.km0digital.com/</code> eingeben (<code>https://</code>, keine Leerzeichen extra).</li>
    <li><strong>Next</strong> wählen.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/desktop/oc-desktop-01.png" alt="OpenCloud Desktop Welcome mit Cloud-Serveradresse" loading="lazy" />
  <figcaption>Welcome: Serveradresse https://cloud.km0digital.com/</figcaption>
</figure>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Schritt 2</p>
  <h2 class="doc-block-heading">Mit dem Webbrowser anmelden</h2>
  <ol class="doc-list">
    <li>Unter <strong>Log in with your web browser</strong> <strong>Open web browser</strong> wählen.</li>
    <li>Gemeinsamen KM0-Login abschließen (Passwort und 2FA falls aktiv).</li>
    <li>Zum Desktop-Client zurück, wenn er zu den Sync-Optionen weitergeht.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/desktop/oc-desktop-01-browser.png" alt="OpenCloud Desktop fordert Öffnen des Webbrowsers für Login" loading="lazy" />
  <figcaption>Login-Schritt: Open web browser für den gemeinsamen KM0-Login.</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 3</p>
  <h2 class="doc-block-heading">Sync-Ordner wählen</h2>
  <ol class="doc-list">
    <li>Bei <strong>You're all set!</strong> bei Bedarf <strong>Advanced configuration</strong> öffnen.</li>
    <li>Prüfen, dass das lokale Verzeichnis der Ordner ist, den ihr schon nutzt (keinen zweiten Ordner aus Versehen anlegen).</li>
    <li>Sync der Spaces wählen, dann <strong>Finish</strong>.</li>
  </ol>
  <p class="doc-block-intro">Wenn der Client einen neuen leeren Ordner anbietet und ihr schon einen vollen habt: stoppen und <a href="/de/#contact">kontaktieren</a>, bevor ihr zustimmt.</p>
  <figure class="doc-figure">
  <img src="/tutorials/desktop/oc-desktop-02.png" alt="OpenCloud Desktop Sync-Optionen mit lokalem Download-Verzeichnis" loading="lazy" />
  <figcaption>Sync Options: lokalen Ordner wählen, dann Finish.</figcaption>
</figure>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Weiter</p>
  <h2 class="doc-block-heading">Weitere Hilfe</h2>
  <ul class="doc-list">
    <li><a href="/de/tutorials/keycloak-sign-in-cloud/">Mit dem gemeinsamen Login bei KM0 Cloud anmelden</a> (Browser).</li>
    <li><a href="/de/tutorials/desktop-sync/">So funktioniert Desktop-Sync auf KM0 Cloud</a>.</li>
  </ul>
</section>
