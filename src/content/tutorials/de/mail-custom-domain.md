---
title: "Eigene Domain mit KM0 Mail nutzen"
description: "Fügen Sie Ihre Domain hinzu, veröffentlichen Sie die DNS-Einträge, bestätigen Sie sie und erstellen Sie eigene E-Mail-Adressen, Schritt für Schritt."
locale: de
order: 3
platform: web
product: mail
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einführung</p>
  <p class="doc-lead">Mit KM0 Mail können Sie E-Mails über Ihre eigene Domain empfangen und senden, zum Beispiel <code>name@ihredomain.com</code>. Alles wird im Webmail verwaltet, ohne Installation.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Bevor Sie beginnen</p>
  <h2 class="doc-block-heading">Was Sie brauchen</h2>
  <ul class="doc-list">
    <li><strong>Ein KM0-Mail-Konto:</strong> falls noch nicht vorhanden, folgen Sie dem <a href="/de/tutorials/mail-register/">Tutorial zum Konto erstellen</a>.</li>
    <li><strong>Eine eigene Domain:</strong> eine bereits registrierte Domain (zum Beispiel bei Ihrem Domain-Anbieter).</li>
    <li><strong>Zugriff auf die DNS-Einträge:</strong> das Panel Ihres Anbieters, in dem MX und TXT bearbeitet werden.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Schritt 1</p>
  <h2 class="doc-block-heading">Öffnen Sie Einstellungen, Meine Domains</h2>
  <ol class="doc-list">
    <li>Melden Sie sich unter <a href="https://mail.km0digital.com/">https://mail.km0digital.com/</a> an.</li>
    <li>Öffnen Sie <strong>Einstellungen</strong> und gehen Sie zum Bereich <strong>Meine Domains</strong>.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 2</p>
  <h2 class="doc-block-heading">Fügen Sie Ihre Domain hinzu</h2>
  <ol class="doc-list">
    <li>Geben Sie Ihre Domain ein (zum Beispiel <code>ihredomain.com</code>).</li>
    <li>Klicken Sie auf <strong>Hinzufügen</strong>.</li>
    <li>Sie erscheint in der Liste als <em>ausstehend</em>, mit ihren DNS-Einträgen.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Schritt 3</p>
  <h2 class="doc-block-heading">Veröffentlichen Sie die DNS-Einträge</h2>
  <p class="doc-block-intro">Öffnen Sie das Panel Ihres Domain-Anbieters und kopieren Sie jeden von KM0 Mail angezeigten Eintrag. Nutzen Sie die Schaltfläche <strong>Kopieren</strong>, um Fehler zu vermeiden.</p>
  <ul class="doc-list">
    <li><strong>TXT (Eigentum):</strong> bestätigt, dass die Domain Ihnen gehört. Kopieren Sie Host und Wert genau aus dem Panel.</li>
    <li><strong>MX:</strong> leitet eingehende E-Mails an <code>mail.km0digital.com</code> mit Priorität <code>10</code>.</li>
    <li><strong>TXT (SPF):</strong> erlaubt den Versand: <code>v=spf1 mx a:mail.km0digital.com ~all</code>.</li>
    <li><strong>TXT (DKIM):</strong> am Host <code>mail._domainkey</code>, mit dem im Panel angezeigten Schlüssel.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 4</p>
  <h2 class="doc-block-heading">Bestätigen Sie die Domain</h2>
  <ol class="doc-list">
    <li>Gehen Sie zurück zu Meine Domains und klicken Sie auf <strong>Bestätigen</strong>.</li>
    <li>Jeder Eintrag wechselt von <em>ausstehend</em> zu <em>OK</em>, sobald er erkannt wird.</li>
  </ol>
  <p class="doc-block-intro">DNS-Änderungen können einige Minuten bis 48 Stunden zur Verbreitung brauchen. Wenn sie noch nicht erscheinen, warten Sie kurz und klicken Sie erneut auf Bestätigen.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Schritt 5</p>
  <h2 class="doc-block-heading">Erstellen Sie Adressen auf Ihrer Domain</h2>
  <p class="doc-block-intro">Sobald die Domain <em>aktiv</em> ist, können Sie E-Mail-Adressen erstellen.</p>
  <ol class="doc-list">
    <li>Klicken Sie bei Ihrer Domain auf <strong>Adressen</strong> und dann auf <strong>Adresse hinzufügen</strong>.</li>
    <li>Geben Sie den Benutzernamen ein (zum Beispiel <code>hallo</code>), um <code>hallo@ihredomain.com</code> zu erstellen.</li>
    <li>Legen Sie ein Passwort für diese Adresse fest und speichern Sie.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 6</p>
  <h2 class="doc-block-heading">Melden Sie sich mit der neuen Adresse an</h2>
  <ol class="doc-list">
    <li>Gehen Sie zu <a href="https://mail.km0digital.com/">https://mail.km0digital.com/</a>.</li>
    <li>Geben Sie die vollständige Adresse (zum Beispiel <code>hallo@ihredomain.com</code>) und ihr Passwort ein.</li>
    <li>Klicken Sie auf <strong>Anmelden</strong>.</li>
  </ol>
  <p class="doc-block-intro">Brauchen Sie Hilfe bei der Anmeldung? Siehe das <a href="/de/tutorials/mail-sign-in/">Anmelde-Tutorial</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Häufige Probleme</p>
  <h2 class="doc-block-heading">Fehlerbehebung</h2>
  <ul class="doc-list">
    <li><strong>Bestätigung schlägt fehl:</strong> prüfen Sie, ob Host und Wert mit dem Panel übereinstimmen, und warten Sie auf die DNS-Verbreitung.</li>
    <li><strong>Adressen lassen sich nicht hinzufügen:</strong> bestätigen Sie zuerst die Domain; Adressen lassen sich erst anlegen, wenn sie aktiv ist.</li>
    <li><strong>Domain bereits in Verwendung:</strong> ein anderes Konto hat sie registriert; nutzen Sie eine Domain, die Ihnen gehört.</li>
  </ul>
</section>
