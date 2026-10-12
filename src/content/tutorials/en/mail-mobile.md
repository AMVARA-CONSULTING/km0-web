---
title: "How to use KM0 Mail on mobile (Gmail and other apps)"
description: "Add your KM0 Mail address in Gmail as an Other account, or in any mobile app with IMAP."
locale: en
order: 5
platform: mobile
product: mail
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">You can read and send KM0 Mail from your phone. In Gmail, add an <strong>Other</strong> account with IMAP. The same settings work in Apple Mail, Outlook mobile, FairEmail, K-9, and other apps.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Before you start</p>
  <h2 class="doc-block-heading">What you need</h2>
  <ul class="doc-list">
    <li><strong>A KM0 Mail account:</strong> if you do not have one yet, follow the <a href="/en/tutorials/mail-register/">create account</a> tutorial.</li>
    <li><strong>Your address and password:</strong> the same ones you use at <a href="https://mail.km0digital.com/">mail.km0digital.com</a>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Server settings</p>
  <h2 class="doc-block-heading">IMAP and SMTP</h2>
  <p class="doc-block-intro">Use these values in any app. The username is always your full address.</p>
  <ul class="doc-list">
    <li>Incoming server (IMAP): <code>mail.km0digital.com</code></li>
    <li>Incoming port: <code>993</code></li>
    <li>Incoming encryption: SSL/TLS</li>
    <li>Outgoing server (SMTP): <code>mail.km0digital.com</code></li>
    <li>Outgoing port: <code>587</code></li>
    <li>Outgoing encryption: STARTTLS</li>
    <li>Username: your full address, for example <code>user@km0digital.com</code></li>
    <li>Password: your mailbox password</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 1</p>
  <h2 class="doc-block-heading">Gmail on Android</h2>
  <ol class="doc-list">
    <li>Open the <strong>Gmail</strong> app.</li>
    <li>Tap your photo or initial (top right) and choose <strong>Add another account</strong>.</li>
    <li>Choose <strong>Other</strong>.</li>
    <li>Enter your full address, for example <code>user@km0digital.com</code>, and continue.</li>
    <li>When asked for the account type, choose <strong>Personal (IMAP)</strong>.</li>
    <li>Enter your mailbox password.</li>
    <li>Fill in the incoming and outgoing servers with the settings above (ports 993 and 587).</li>
    <li>Finish the wizard. Your KM0 Mail account appears next to your other Gmail accounts.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Step 2</p>
  <h2 class="doc-block-heading">Gmail on iPhone or iPad</h2>
  <ol class="doc-list">
    <li>Open the <strong>Gmail</strong> app.</li>
    <li>Tap your photo or initial and choose <strong>Add another account</strong>.</li>
    <li>Choose <strong>Other</strong>.</li>
    <li>Enter your full address and password.</li>
    <li>Choose <strong>IMAP</strong> and complete servers, ports, and encryption as in the table above.</li>
    <li>Save the account.</li>
  </ol>
  <p class="doc-block-intro">You can also use Apple <strong>Mail</strong>: Settings → Mail → Accounts → Add Account → Other → Add Mail Account, with the same IMAP/SMTP values.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 3</p>
  <h2 class="doc-block-heading">Other mobile apps</h2>
  <p class="doc-block-intro">In Outlook mobile, FairEmail, K-9 Mail, or another IMAP app:</p>
  <ol class="doc-list">
    <li>Add a new account and choose manual setup or IMAP.</li>
    <li>Enter your full address and password.</li>
    <li>Use the same servers, ports, and encryption from <strong>Server settings</strong>.</li>
    <li>Turn on app notifications in system settings if you want alerts for new mail.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Step 4</p>
  <h2 class="doc-block-heading">Check mail and notifications</h2>
  <ol class="doc-list">
    <li>Open the KM0 Mail inbox in the app.</li>
    <li>Send a test message to another address.</li>
    <li>Ask someone to send you a test message and confirm that a notification arrives.</li>
  </ol>
  <p class="doc-block-intro">In Gmail, notifications for IMAP accounts can be a bit slower than in dedicated apps. For faster alerts, try FairEmail, K-9, or Apple Mail with the same settings.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Common problems</p>
  <h2 class="doc-block-heading">Troubleshooting</h2>
  <ul class="doc-list">
    <li><strong>Cannot sign in:</strong> the username must be the full address and the password must be the mailbox password (not your Google password).</li>
    <li><strong>Mail does not go out:</strong> outgoing server <code>mail.km0digital.com</code>, port 587, STARTTLS. If the account is new, verify the mailbox first.</li>
    <li><strong>Gmail suggests Google:</strong> go back and choose <strong>Other</strong> / <strong>Personal (IMAP)</strong>, not a Google account.</li>
    <li><strong>No notifications:</strong> check that Gmail (or the app) notifications are enabled for that account in phone settings.</li>
  </ul>
</section>
