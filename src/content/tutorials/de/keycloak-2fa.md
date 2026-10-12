---
title: "2FA für euer KM0-Konto aktivieren"
description: "Zwei-Faktor-Authentifizierung in der KM0-Kontokonsole für den gemeinsamen Login von Cloud Web, Desktop und Mobil einschalten."
locale: de
order: 10
platform: web
product: cloud
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einführung</p>
  <p class="doc-lead">Zwei-Faktor-Authentifizierung (2FA) verlangt nach dem Passwort einen Code aus einer Authenticator-App. Sie schützt denselben KM0-Login für Cloud im Browser, Desktop und Mobil. Die Einrichtung läuft über die KM0-Kontokonsole. Ihr braucht ein Handy mit Authenticator-App (zum Beispiel Google Authenticator, FreeOTP oder Microsoft Authenticator).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 1</p>
  <h2 class="doc-block-heading">KM0-Kontokonsole öffnen</h2>
  <ol class="doc-list">
    <li>Geht zu <a href="https://sso.km0digital.com/realms/km0digital/account">https://sso.km0digital.com/realms/km0digital/account</a>.</li>
    <li>Wenn ihr nicht angemeldet seid, den gemeinsamen KM0-Login abschließen (E-Mail oder Benutzername und Passwort).</li>
    <li>Ihr landet in der Kontokonsole eures KM0-Kontos.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Schritt 2</p>
  <h2 class="doc-block-heading">Zwei-Faktor-Authentifizierung öffnen</h2>
  <ol class="doc-list">
    <li>In der Seitenleiste <strong>Account security</strong> / <strong>Seguridad de la cuenta</strong> öffnen.</li>
    <li><strong>Signing in</strong> / <strong>Iniciando sesión</strong> öffnen.</li>
    <li>Unter <strong>Two-factor authentication</strong> <strong>Set up Authenticator application</strong> / <strong>Configurar Aplicación autenticadora</strong> wählen.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-2fa-01.png" alt="Kontokonsole Signing-in-Seite mit Zwei-Faktor-Bereich" loading="lazy" />
  <figcaption>Account security → Signing in: Authenticator-App einrichten.</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 3</p>
  <h2 class="doc-block-heading">Authenticator-App verknüpfen</h2>
  <ol class="doc-list">
    <li>Authenticator-App auf dem Handy installieren, falls noch keine vorhanden ist.</li>
    <li>QR-Code auf <strong>Mobile Authenticator Setup</strong> scannen (in unserem öffentlichen Screenshot ist der QR absichtlich unscharf).</li>
    <li>Einmalcode eingeben, optional Gerätename setzen, dann <strong>Submit</strong>.</li>
    <li>Falls Wiederherstellungscodes angeboten werden, offline sicher ablegen.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-2fa-02.png" alt="Mobile Authenticator Setup mit unscharfem QR-Bereich" loading="lazy" />
  <figcaption>Mobile Authenticator Setup: QR scannen, Code eingeben, Submit.</figcaption>
</figure>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Schritt 4</p>
  <h2 class="doc-block-heading">Frische Anmeldung prüfen</h2>
  <ol class="doc-list">
    <li>Von Cloud (oder der Kontokonsole) abmelden.</li>
    <li>Unter <a href="https://cloud.km0digital.com/">https://cloud.km0digital.com/</a> mit Passwort und danach Authenticator-Code erneut anmelden.</li>
    <li>Prüfen, dass die Dateien erreichbar sind.</li>
  </ol>
  <p class="doc-block-intro">Desktop und Mobil verlangen denselben zweiten Faktor, wenn sie den gemeinsamen Login öffnen.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Hinweise</p>
  <h2 class="doc-block-heading">Wenn das Handy weg ist</h2>
  <p class="doc-block-intro">Wiederherstellungscode nutzen, falls gespeichert. Ohne Wiederherstellungsweg KM0-Support über das <a href="/de/#contact">Kontakt</a>-Formular der Seite erreichen und Kontoinhaberschaft nachweisen. Passwörter nicht im Chat teilen.</p>
</section>
