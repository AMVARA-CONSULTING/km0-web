---
title: "Mit dem gemeinsamen Login bei KM0 Cloud anmelden"
description: "Cloud im Browser öffnen und die gemeinsame KM0-Anmeldung abschließen, die Web, Desktop und Mobil teilen."
locale: de
order: 9
platform: web
product: cloud
featured: true
---
<section class="doc-lead-block">
  <p class="doc-block-title">Einführung</p>
  <p class="doc-lead">KM0 Cloud im Browser, der Desktop-Client und die Mobile-Apps teilen einen Login. Diese Anleitung deckt den Browser-Weg ab. Ihr braucht KM0-Adresse (oder Benutzername) und Passwort.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 1</p>
  <h2 class="doc-block-heading">Cloud öffnen</h2>
  <ol class="doc-list">
    <li>Browser öffnen.</li>
    <li>Zu <a href="https://cloud.km0digital.com/">https://cloud.km0digital.com/</a> gehen.</li>
    <li>Wenn ihr nicht angemeldet seid, führt die Seite zum gemeinsamen KM0-Anmeldebildschirm.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Schritt 2</p>
  <h2 class="doc-block-heading">KM0-Zugangsdaten eingeben</h2>
  <ol class="doc-list">
    <li>E-Mail oder Benutzername eures KM0-Kontos eingeben.</li>
    <li>Passwort eingeben.</li>
    <li><strong>Sign in</strong> wählen (oder Sign in with Passkey / Google, falls genutzt).</li>
  </ol>
  <p class="doc-block-intro">Wenn Zwei-Faktor-Authentifizierung aktiv ist, den Code aus der Authenticator-App eingeben. Siehe <a href="/de/tutorials/keycloak-2fa/">2FA für euer KM0-Konto aktivieren</a>.</p>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-signin-02.png" alt="Gemeinsamer KM0-Anmeldebildschirm mit Benutzername und Passwort" loading="lazy" />
  <figcaption>Gemeinsamer KM0-Login (derselbe Bildschirm für Cloud Web, Desktop und Mobil).</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 3</p>
  <h2 class="doc-block-heading">Ihr landet bei euren Dateien</h2>
  <p class="doc-block-intro">Nach erfolgreicher Anmeldung kehrt ihr zu Cloud zurück und seht Spaces und Ordner. Dasselbe Konto gilt, wenn Desktop oder Mobil um Anmeldung bitten.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Häufige Probleme</p>
  <h2 class="doc-block-heading">Fehlerbehebung</h2>
  <ul class="doc-list">
    <li><strong>Passwort vergessen:</strong> <strong>Forgot Password?</strong> auf dem Anmeldebildschirm nutzen.</li>
    <li><strong>Seite schleift:</strong> Cookies für Cloud löschen oder privates Fenster, dann einmal anmelden.</li>
    <li><strong>Desktop-Sync steht:</strong> <a href="/de/tutorials/opencloud-desktop-relogin/">Erneute Anmeldung in OpenCloud Desktop</a> folgen.</li>
  </ul>
</section>
