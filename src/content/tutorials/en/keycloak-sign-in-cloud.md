---
title: "Sign in to KM0 Cloud with the shared login"
description: "Open Cloud in the browser and complete the shared KM0 sign-in used by web, desktop, and mobile."
locale: en
order: 9
platform: web
product: cloud
featured: true
---
<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">KM0 Cloud in the browser, the desktop client, and the mobile apps share one login. This guide covers the browser path. You need your KM0 address (or username) and password.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 1</p>
  <h2 class="doc-block-heading">Open Cloud</h2>
  <ol class="doc-list">
    <li>Open your browser.</li>
    <li>Go to <a href="https://cloud.km0digital.com/">https://cloud.km0digital.com/</a>.</li>
    <li>If you are not signed in, the site sends you to the shared KM0 sign-in screen.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Step 2</p>
  <h2 class="doc-block-heading">Enter your KM0 credentials</h2>
  <ol class="doc-list">
    <li>Type the email or username for your KM0 account.</li>
    <li>Type your password.</li>
    <li>Choose <strong>Sign in</strong> (or Sign in with Passkey / Google if you use those).</li>
  </ol>
  <p class="doc-block-intro">If you enabled two-factor authentication, enter the code from your authenticator app when asked. See <a href="/en/tutorials/keycloak-2fa/">Enable 2FA on your KM0 account</a>.</p>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-signin-02.png" alt="Shared KM0 sign-in screen with username and password fields" loading="lazy" />
  <figcaption>Shared KM0 login (same screen for Cloud web, desktop, and mobile).</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 3</p>
  <h2 class="doc-block-heading">You land in your files</h2>
  <p class="doc-block-intro">After a successful sign-in you return to Cloud and see your spaces and folders. The same account works when the desktop or mobile app asks you to sign in.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Common problems</p>
  <h2 class="doc-block-heading">Troubleshooting</h2>
  <ul class="doc-list">
    <li><strong>I forgot my password:</strong> use <strong>Forgot Password?</strong> on the sign-in screen.</li>
    <li><strong>The page loops:</strong> clear cookies for Cloud, or try a private window, then sign in once.</li>
    <li><strong>Desktop sync stopped:</strong> follow <a href="/en/tutorials/opencloud-desktop-relogin/">Re-login on OpenCloud Desktop</a>.</li>
  </ul>
</section>
