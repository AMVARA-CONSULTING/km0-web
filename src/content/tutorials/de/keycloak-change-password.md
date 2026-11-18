---
title: "KM0-Kontopasswort ändern"
description: "Das Passwort des gemeinsamen KM0-Logins (Cloud Web, Desktop und Mobil) in der Keycloak-Kontokonsole ändern."
locale: de
order: 12
platform: web
product: cloud
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einführung</p>
  <p class="doc-lead">Das Passwort für KM0 Cloud (Browser, OpenCloud Desktop und Mobil-Apps) ändert ihr in der Kontokonsole des gemeinsamen Logins, nicht innerhalb von OpenCloud. Das neue Passwort gilt für Cloud Web, OpenCloud Desktop und die Mobil-Apps. Ihr braucht das aktuelle Passwort. KM0 Mail (mail.km0digital.com) kann weiterhin ein eigenes Postfach-Passwort nutzen, falls es noch nicht vereinheitlicht ist.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 1</p>
  <h2 class="doc-block-heading">KM0-Kontokonsole öffnen</h2>
  <ol class="doc-list">
    <li>Geht zu <a href="https://sso.km0digital.com/realms/km0digital/account/">https://sso.km0digital.com/realms/km0digital/account/</a>.</li>
    <li>Wenn gefragt, mit E-Mail oder Benutzername und dem <strong>aktuellen Passwort</strong> anmelden.</li>
    <li>Ihr landet in der Kontokonsole eures KM0-Kontos.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Schritt 2</p>
  <h2 class="doc-block-heading">Anmeldebereich öffnen</h2>
  <ol class="doc-list">
    <li>In der linken Leiste <strong>Account security</strong> / <strong>Seguridad de la cuenta</strong> öffnen.</li>
    <li><strong>Signing in</strong> / <strong>Iniciando sesión</strong> öffnen.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-2fa-01.png" alt="Kontokonsole: Account security, Signing in, Passwort-Zeile" loading="lazy" />
  <figcaption>Account security → Signing in: hier liegt die Passwort-Zeile.</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Schritt 3</p>
  <h2 class="doc-block-heading">Passwort aktualisieren</h2>
  <ol class="doc-list">
    <li>In der Zeile <strong>My password</strong> / <strong>Mi contraseña</strong> auf <strong>Update</strong> tippen.</li>
    <li>Das aktuelle Passwort eingeben, wenn gefragt.</li>
    <li>Neues Passwort eingeben, bestätigen und speichern.</li>
  </ol>
  <p class="doc-block-intro">Wenn noch kein Passwort gesetzt war, kann der Button <strong>Set up Password</strong> / <strong>Configurar Contraseña</strong> heißen statt Update.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Schritt 4</p>
  <h2 class="doc-block-heading">Anmeldung prüfen</h2>
  <ol class="doc-list">
    <li>Von Cloud oder der Kontokonsole abmelden.</li>
    <li>Erneut unter <a href="https://cloud.km0digital.com/">https://cloud.km0digital.com/</a> mit dem neuen Passwort anmelden.</li>
    <li>Bestätigen, dass die Dateien erreichbar sind. Desktop und Mobil nutzen dasselbe Passwort beim nächsten gemeinsamen Login.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Hinweise</p>
  <h2 class="doc-block-heading">Passwort vergessen</h2>
  <p class="doc-block-intro"><strong>Forgot Password?</strong> auf dem gemeinsamen Anmeldebildschirm nutzen. Für 2FA: <a href="/de/tutorials/keycloak-2fa/">2FA für euer KM0-Konto aktivieren</a>. Passwörter nicht im Chat teilen.</p>
</section>
