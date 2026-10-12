---
title: "Enable 2FA on your KM0 account"
description: "Turn on two-factor authentication in the KM0 account console for the shared login used by Cloud web, desktop, and mobile."
locale: en
order: 10
platform: web
product: cloud
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">Two-factor authentication (2FA) asks for a code from an authenticator app after your password. It protects the same KM0 login used by Cloud in the browser, desktop, and mobile. You set it up in the KM0 account console. You need a phone with an authenticator app (for example Google Authenticator, FreeOTP, or Microsoft Authenticator).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 1</p>
  <h2 class="doc-block-heading">Open the KM0 account console</h2>
  <ol class="doc-list">
    <li>Go to <a href="https://sso.km0digital.com/realms/km0digital/account">https://sso.km0digital.com/realms/km0digital/account</a>.</li>
    <li>If you are not signed in, complete the shared KM0 login (email or username and password).</li>
    <li>You land in the account console for your KM0 account.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Step 2</p>
  <h2 class="doc-block-heading">Open two-factor authentication</h2>
  <ol class="doc-list">
    <li>In the sidebar, open <strong>Account security</strong> (Seguridad de la cuenta).</li>
    <li>Open <strong>Signing in</strong> (Iniciando sesión).</li>
    <li>Under <strong>Two-factor authentication</strong>, choose <strong>Set up Authenticator application</strong> (Configurar Aplicación autenticadora).</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-2fa-01.png" alt="Account console Signing in page with two-factor authentication section" loading="lazy" />
  <figcaption>Account security → Signing in: set up the authenticator app.</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 3</p>
  <h2 class="doc-block-heading">Link your authenticator app</h2>
  <ol class="doc-list">
    <li>Install an authenticator app on your phone if you do not have one yet.</li>
    <li>Scan the QR code shown on <strong>Mobile Authenticator Setup</strong> (the QR in our public screenshot is blurred on purpose).</li>
    <li>Enter the one-time code from the app, optionally set a device name, then <strong>Submit</strong>.</li>
    <li>If the flow offers recovery codes, save them offline in a safe place.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-2fa-02.png" alt="Mobile Authenticator Setup screen with QR area blurred" loading="lazy" />
  <figcaption>Mobile Authenticator Setup: scan the QR, enter the one-time code, Submit.</figcaption>
</figure>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Step 4</p>
  <h2 class="doc-block-heading">Check a fresh sign-in</h2>
  <ol class="doc-list">
    <li>Sign out of Cloud (or the account console).</li>
    <li>Sign in again at <a href="https://cloud.km0digital.com/">https://cloud.km0digital.com/</a> with password, then the authenticator code.</li>
    <li>Confirm you reach your files.</li>
  </ol>
  <p class="doc-block-intro">Desktop and mobile will ask for the same second factor when they open the shared login.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Notes</p>
  <h2 class="doc-block-heading">If you lose the phone</h2>
  <p class="doc-block-intro">Use a recovery code if you saved one. If you have no recovery path, contact KM0 support through the site <a href="/en/#contact">contact</a> form and prove account ownership. Do not share passwords in chat.</p>
</section>
