---
title: "Re-login on OpenCloud Desktop after the shared login"
description: "Reconnect the OpenCloud desktop client to KM0 Cloud using the shared login: server URL, browser sign-in, and sync folder."
locale: en
order: 11
platform: desktop
product: cloud
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">After the shared KM0 login went live, the OpenCloud desktop client may need a fresh account connection. This guide follows the Add account wizard: server address, browser login, then sync folder. Prefer reconnecting to your existing local folder. Server address stays <code>https://cloud.km0digital.com/</code>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 1</p>
  <h2 class="doc-block-heading">Enter the Cloud server address</h2>
  <ol class="doc-list">
    <li>Open the OpenCloud Desktop Client.</li>
    <li>If you add or reconnect an account, you see <strong>Welcome</strong> and <strong>What is your server's address?</strong>.</li>
    <li>Type exactly <code>https://cloud.km0digital.com/</code> (include <code>https://</code>, no extra spaces).</li>
    <li>Choose <strong>Next</strong>.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/desktop/oc-desktop-01.png" alt="OpenCloud Desktop Welcome with Cloud server address" loading="lazy" />
  <figcaption>Welcome: server address https://cloud.km0digital.com/</figcaption>
</figure>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Step 2</p>
  <h2 class="doc-block-heading">Sign in with the web browser</h2>
  <ol class="doc-list">
    <li>On <strong>Log in with your web browser</strong>, choose <strong>Open web browser</strong>.</li>
    <li>Complete the shared KM0 login (password and 2FA if enabled).</li>
    <li>Return to the desktop client when it continues to sync options.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/desktop/oc-desktop-01-browser.png" alt="OpenCloud Desktop prompting to open the web browser for login" loading="lazy" />
  <figcaption>Login step: Open web browser for the shared KM0 sign-in.</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 3</p>
  <h2 class="doc-block-heading">Choose the sync folder</h2>
  <ol class="doc-list">
    <li>When you see <strong>You're all set!</strong>, open <strong>Advanced configuration</strong> if you need to pick the folder.</li>
    <li>Confirm the local download directory is the folder you already use (avoid creating a second copy by mistake).</li>
    <li>Choose how spaces sync, then <strong>Finish</strong>.</li>
  </ol>
  <p class="doc-block-intro">If the client offers a brand-new empty folder and you already have a full sync folder, stop and <a href="/en/#contact">contact us</a> before accepting.</p>
  <figure class="doc-figure">
  <img src="/tutorials/desktop/oc-desktop-02.png" alt="OpenCloud Desktop sync options choosing local download directory" loading="lazy" />
  <figcaption>Sync Options: pick the local folder, then Finish.</figcaption>
</figure>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Related</p>
  <h2 class="doc-block-heading">More help</h2>
  <ul class="doc-list">
    <li><a href="/en/tutorials/keycloak-sign-in-cloud/">Sign in to KM0 Cloud with the shared login</a> (browser).</li>
    <li><a href="/en/tutorials/desktop-sync/">How desktop sync works on KM0 Cloud</a>.</li>
  </ul>
</section>
