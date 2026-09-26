---
title: "KM0 Mail in Outlook einrichten"
description: "Fügen Sie Ihre KM0-Mail-Adresse in Outlook hinzu: Server, Ports und Passwort."
locale: de
order: 4
platform: desktop
product: mail
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einführung</p>
  <p class="doc-lead">Sie können KM0 Mail in Outlook lesen und senden. Verwenden Sie dieselbe Adresse und dasselbe Passwort wie auf der Website.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 1</p>
  <h2 class="doc-block-heading">Konto hinzufügen öffnen</h2>
  <p class="doc-block-intro">Beim ersten Start öffnen Sie Outlook und gehen zu <strong>Datei</strong>, <strong>Konto</strong>, <strong>Konto hinzufügen</strong>.</p>
  <p class="doc-block-intro">Wenn Outlook schon offen ist, wählen Sie <strong>Konto hinzufügen</strong>. Danach sind die Schritte gleich.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Schritt 2</p>
  <h2 class="doc-block-heading">IMAP wählen</h2>
  <ol class="doc-list">
    <li>Geben Sie Ihre vollständige Adresse ein, zum Beispiel <code>benutzer@km0digital.com</code>.</li>
    <li>Öffnen Sie die erweiterten Optionen.</li>
    <li>Wählen Sie <strong>IMAP</strong>.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 3</p>
  <h2 class="doc-block-heading">Server eintragen</h2>
  <ul class="doc-list">
    <li>Posteingangsserver: <code>mail.km0digital.com</code></li>
    <li>Port für den Posteingang: <code>993</code></li>
    <li>Verschlüsselung für den Posteingang: SSL/TLS</li>
    <li>Postausgangsserver: <code>mail.km0digital.com</code></li>
    <li>Port für den Postausgang: <code>587</code></li>
    <li>Verschlüsselung für den Postausgang: STARTTLS</li>
    <li>Benutzername, für Ein- und Ausgang: Ihre vollständige Adresse</li>
    <li>Passwort: das Passwort des Postfachs</li>
  </ul>
  <p class="doc-block-intro">Wenn Outlook als Postausgangsserver <code>smtp.km0digital.com</code> einträgt, ändern Sie ihn in <code>mail.km0digital.com</code>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Schritt 4</p>
  <h2 class="doc-block-heading">Post prüfen</h2>
  <ol class="doc-list">
    <li>Schließen Sie den Assistenten ab.</li>
    <li>Öffnen Sie den Posteingang.</li>
    <li>Senden Sie eine Testnachricht an eine andere Adresse.</li>
  </ol>
  <p class="doc-block-intro">Senden geht erst nach der Bestätigung des Kontos. Wenn Sie es gerade angelegt haben, folgen Sie dem Tutorial <a href="/de/tutorials/mail-register/">Konto erstellen</a>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Häufige Probleme</p>
  <h2 class="doc-block-heading">Fehler beheben</h2>
  <ul class="doc-list">
    <li><strong>Anmeldung scheitert:</strong> prüfen Sie, ob der Benutzername die vollständige Adresse ist und das Passwort zum Postfach gehört.</li>
    <li><strong>Post geht nicht raus:</strong> der Postausgangsserver muss <code>mail.km0digital.com</code> sein, Port 587, mit STARTTLS. Bei einem neuen Konto bestätigen Sie das Postfach.</li>
  </ul>
</section>
