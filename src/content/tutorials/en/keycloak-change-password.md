---
title: "Change your KM0 account password"
description: "Change the shared KM0 login password (Cloud web, desktop, and mobile) in the Keycloak account console."
locale: en
order: 12
platform: web
product: cloud
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">The password for KM0 Cloud (browser, OpenCloud desktop, and mobile apps) is changed in the shared login account console, not inside OpenCloud. The new password applies to Cloud web, OpenCloud Desktop, and the mobile apps. You need your current password. KM0 Mail (mail.km0digital.com) may still use a separate mailbox password if it is not yet unified.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 1</p>
  <h2 class="doc-block-heading">Open the KM0 account console</h2>
  <ol class="doc-list">
    <li>Go to <a href="https://sso.km0digital.com/realms/km0digital/account/">https://sso.km0digital.com/realms/km0digital/account/</a>.</li>
    <li>If asked, sign in with your email or username and your <strong>current password</strong>.</li>
    <li>You land in the account console for your KM0 account.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Step 2</p>
  <h2 class="doc-block-heading">Open the signing-in section</h2>
  <ol class="doc-list">
    <li>In the left panel, open <strong>Account security</strong> (Seguridad de la cuenta).</li>
    <li>Open <strong>Signing in</strong> (Iniciando sesión).</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-2fa-01.png" alt="Account console: Account security, Signing in, password row" loading="lazy" />
  <figcaption>Account security → Signing in: the password row is here.</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 3</p>
  <h2 class="doc-block-heading">Update your password</h2>
  <ol class="doc-list">
    <li>On the <strong>My password</strong> (Mi contraseña) row, choose <strong>Update</strong>.</li>
    <li>Enter your current password when asked.</li>
    <li>Enter the new password, confirm it, and save.</li>
  </ol>
  <p class="doc-block-intro">If the account had no password yet, the control may say <strong>Set up Password</strong> (Configurar Contraseña) instead of Update.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Step 4</p>
  <h2 class="doc-block-heading">Check a fresh sign-in</h2>
  <ol class="doc-list">
    <li>Sign out of Cloud or the account console.</li>
    <li>Sign in again at <a href="https://cloud.km0digital.com/">https://cloud.km0digital.com/</a> with the new password.</li>
    <li>Confirm you reach your files. Desktop and mobile will use the same password on the next shared login.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Notes</p>
  <h2 class="doc-block-heading">If you forgot the password</h2>
  <p class="doc-block-intro">Use <strong>Forgot Password?</strong> on the shared sign-in screen. To turn on 2FA, follow <a href="/en/tutorials/keycloak-2fa/">Enable 2FA on your KM0 account</a>. Do not share passwords in chat.</p>
</section>
