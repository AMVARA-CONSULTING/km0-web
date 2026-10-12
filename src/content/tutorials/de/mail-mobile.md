---
title: "KM0 Mail auf dem Handy (Gmail und andere Apps)"
description: "Fügen Sie KM0 Mail in Gmail als Other-Konto oder in jeder mobilen App per IMAP hinzu."
locale: de
order: 5
platform: mobile
product: mail
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einführung</p>
  <p class="doc-lead">Sie können KM0 Mail auf dem Handy lesen und senden. In Gmail wählen Sie ein Konto <strong>Other</strong> (Andere) mit IMAP. Dieselben Werte gelten für Apple Mail, Outlook mobil, FairEmail, K-9 und andere Apps.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Bevor Sie starten</p>
  <h2 class="doc-block-heading">Was Sie brauchen</h2>
  <ul class="doc-list">
    <li><strong>Ein KM0-Mail-Konto:</strong> wenn Sie noch keines haben, folgen Sie dem Tutorial <a href="/de/tutorials/mail-register/">Konto erstellen</a>.</li>
    <li><strong>Adresse und Passwort:</strong> dieselben wie unter <a href="https://mail.km0digital.com/">mail.km0digital.com</a>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Serverdaten</p>
  <h2 class="doc-block-heading">IMAP und SMTP</h2>
  <p class="doc-block-intro">Verwenden Sie diese Werte in jeder App. Der Benutzername ist immer die vollständige Adresse.</p>
  <ul class="doc-list">
    <li>Posteingangsserver (IMAP): <code>mail.km0digital.com</code></li>
    <li>Port für den Posteingang: <code>993</code></li>
    <li>Verschlüsselung für den Posteingang: SSL/TLS</li>
    <li>Postausgangsserver (SMTP): <code>mail.km0digital.com</code></li>
    <li>Port für den Postausgang: <code>587</code></li>
    <li>Verschlüsselung für den Postausgang: STARTTLS</li>
    <li>Benutzername: Ihre vollständige Adresse, zum Beispiel <code>benutzer@km0digital.com</code></li>
    <li>Passwort: das Passwort des Postfachs</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 1</p>
  <h2 class="doc-block-heading">Gmail unter Android</h2>
  <ol class="doc-list">
    <li>Öffnen Sie die App <strong>Gmail</strong>.</li>
    <li>Tippen Sie auf Ihr Foto oder Ihre Initiale (oben rechts) und wählen Sie <strong>Weiteres Konto hinzufügen</strong>.</li>
    <li>Wählen Sie <strong>Other</strong> (Andere).</li>
    <li>Geben Sie Ihre vollständige Adresse ein, zum Beispiel <code>benutzer@km0digital.com</code>, und fahren Sie fort.</li>
    <li>Wenn nach dem Kontotyp gefragt wird, wählen Sie <strong>Persönlich (IMAP)</strong>.</li>
    <li>Geben Sie das Passwort des Postfachs ein.</li>
    <li>Tragen Sie Postein- und Postausgangsserver mit den Werten oben ein (Ports 993 und 587).</li>
    <li>Schließen Sie den Assistenten ab. Ihr KM0-Mail-Konto erscheint neben Ihren anderen Gmail-Konten.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Schritt 2</p>
  <h2 class="doc-block-heading">Gmail auf iPhone oder iPad</h2>
  <ol class="doc-list">
    <li>Öffnen Sie die App <strong>Gmail</strong>.</li>
    <li>Tippen Sie auf Ihr Foto oder Ihre Initiale und wählen Sie <strong>Weiteres Konto hinzufügen</strong>.</li>
    <li>Wählen Sie <strong>Other</strong> (Andere).</li>
    <li>Geben Sie die vollständige Adresse und das Passwort ein.</li>
    <li>Wählen Sie <strong>IMAP</strong> und tragen Sie Server, Ports und Verschlüsselung wie in der Tabelle oben ein.</li>
    <li>Speichern Sie das Konto.</li>
  </ol>
  <p class="doc-block-intro">Sie können auch Apple <strong>Mail</strong> nutzen: Einstellungen → Mail → Accounts → Account hinzufügen → Andere → Mail-Account hinzufügen, mit denselben IMAP/SMTP-Werten.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 3</p>
  <h2 class="doc-block-heading">Andere mobile Apps</h2>
  <p class="doc-block-intro">In Outlook mobil, FairEmail, K-9 Mail oder einer anderen IMAP-App:</p>
  <ol class="doc-list">
    <li>Fügen Sie ein neues Konto hinzu und wählen Sie manuelle Einrichtung oder IMAP.</li>
    <li>Geben Sie die vollständige Adresse und das Passwort ein.</li>
    <li>Verwenden Sie dieselben Server, Ports und Verschlüsselung aus <strong>Serverdaten</strong>.</li>
    <li>Schalten Sie App-Benachrichtigungen in den Systemeinstellungen ein, wenn Sie Alerts für neue Post wollen.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Schritt 4</p>
  <h2 class="doc-block-heading">Post und Benachrichtigungen prüfen</h2>
  <ol class="doc-list">
    <li>Öffnen Sie den Posteingang des KM0-Mail-Kontos in der App.</li>
    <li>Senden Sie eine Testnachricht an eine andere Adresse.</li>
    <li>Lassen Sie sich eine Testmail schicken und prüfen Sie, ob eine Benachrichtigung ankommt.</li>
  </ol>
  <p class="doc-block-intro">In Gmail können Benachrichtigungen für IMAP-Konten etwas langsamer sein als in speziellen Apps. Für schnellere Alerts nutzen Sie FairEmail, K-9 oder Apple Mail mit denselben Werten.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Häufige Probleme</p>
  <h2 class="doc-block-heading">Fehler beheben</h2>
  <ul class="doc-list">
    <li><strong>Anmeldung scheitert:</strong> der Benutzername muss die vollständige Adresse sein und das Passwort das des Postfachs (nicht das Google-Passwort).</li>
    <li><strong>Post geht nicht raus:</strong> Postausgangsserver <code>mail.km0digital.com</code>, Port 587, STARTTLS. Bei einem neuen Konto bestätigen Sie zuerst das Postfach.</li>
    <li><strong>Gmail schlägt Google vor:</strong> gehen Sie zurück und wählen Sie <strong>Other</strong> / <strong>Persönlich (IMAP)</strong>, kein Google-Konto.</li>
    <li><strong>Keine Benachrichtigungen:</strong> prüfen Sie, dass Benachrichtigungen für Gmail (oder die App) für dieses Konto in den Telefoneinstellungen aktiv sind.</li>
  </ul>
</section>
