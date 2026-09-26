---
title: "How to use KM0 Mail in Outlook"
description: "Add your KM0 Mail address to Outlook: servers, ports, and password."
locale: en
order: 4
platform: desktop
product: mail
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">You can read and send KM0 Mail from Outlook. Use the same address and the same password as on the website.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 1</p>
  <h2 class="doc-block-heading">Open Add account</h2>
  <p class="doc-block-intro">The first time, open Outlook and go to <strong>File</strong>, <strong>Account</strong>, <strong>Add account</strong>.</p>
  <p class="doc-block-intro">If Outlook is already open, choose <strong>Add account</strong>. The steps after that are the same.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Step 2</p>
  <h2 class="doc-block-heading">Choose IMAP</h2>
  <ol class="doc-list">
    <li>Enter your full address, for example <code>user@km0digital.com</code>.</li>
    <li>Open the advanced options.</li>
    <li>Choose <strong>IMAP</strong>.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 3</p>
  <h2 class="doc-block-heading">Fill in the servers</h2>
  <ul class="doc-list">
    <li>Incoming server: <code>mail.km0digital.com</code></li>
    <li>Incoming port: <code>993</code></li>
    <li>Incoming encryption: SSL/TLS</li>
    <li>Outgoing server: <code>mail.km0digital.com</code></li>
    <li>Outgoing port: <code>587</code></li>
    <li>Outgoing encryption: STARTTLS</li>
    <li>Username, for incoming and outgoing: your full address</li>
    <li>Password: your mailbox password</li>
  </ul>
  <p class="doc-block-intro">If Outlook fills the outgoing server with <code>smtp.km0digital.com</code>, change it to <code>mail.km0digital.com</code>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Step 4</p>
  <h2 class="doc-block-heading">Check the mail</h2>
  <ol class="doc-list">
    <li>Finish the wizard.</li>
    <li>Open the inbox.</li>
    <li>Send a test message to another address.</li>
  </ol>
  <p class="doc-block-intro">You can send mail after the account is verified. If you just created it, follow the <a href="/en/tutorials/mail-register/">create account</a> tutorial.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Common problems</p>
  <h2 class="doc-block-heading">Troubleshooting</h2>
  <ul class="doc-list">
    <li><strong>Cannot sign in:</strong> check that the username is the full address and that the password is the mailbox password.</li>
    <li><strong>Mail does not go out:</strong> the outgoing server must be <code>mail.km0digital.com</code>, port 587, with STARTTLS. If the account is new, verify the mailbox.</li>
  </ul>
</section>
