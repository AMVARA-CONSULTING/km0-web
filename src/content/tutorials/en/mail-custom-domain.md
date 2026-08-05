---
title: "How to use your own domain with KM0 Mail"
description: "Add your domain, publish the DNS records, verify it, and create your own email addresses, step by step."
locale: en
order: 3
platform: web
product: mail
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">With KM0 Mail you can receive and send mail from your own domain, for example <code>name@yourdomain.com</code>. Everything is managed from webmail, with nothing to install.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Before you start</p>
  <h2 class="doc-block-heading">What you need</h2>
  <ul class="doc-list">
    <li><strong>A KM0 Mail account:</strong> if you do not have one yet, follow the <a href="/en/tutorials/mail-register/">create account tutorial</a>.</li>
    <li><strong>Your own domain:</strong> one you already have registered (for example with your domain provider).</li>
    <li><strong>Access to the DNS records:</strong> your provider's panel where MX and TXT records are edited.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Step 1</p>
  <h2 class="doc-block-heading">Open Settings, My domains</h2>
  <ol class="doc-list">
    <li>Sign in at <a href="https://mail.km0digital.com/">https://mail.km0digital.com/</a>.</li>
    <li>Open <strong>Settings</strong> and go to the <strong>My domains</strong> section.</li>
  </ol>
  <figure class="doc-figure">
    <img src="/tutorials/mail/settings-my-domains.png" alt="My domains section in webmail settings with the field to add a domain" />
    <figcaption>Settings, My domains, in KM0 Mail webmail.</figcaption>
  </figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 2</p>
  <h2 class="doc-block-heading">Add your domain</h2>
  <ol class="doc-list">
    <li>Type your domain (for example <code>yourdomain.com</code>).</li>
    <li>Click <strong>Add</strong>.</li>
    <li>It appears in the list as <em>pending</em>, with its DNS records.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Step 3</p>
  <h2 class="doc-block-heading">Publish the DNS records</h2>
  <p class="doc-block-intro">Open your domain provider's panel and copy each record shown by KM0 Mail. Use the <strong>Copy</strong> button to avoid mistakes.</p>
  <ul class="doc-list">
    <li><strong>TXT (ownership):</strong> confirms the domain is yours. Copy the exact host and value from the panel.</li>
    <li><strong>MX:</strong> routes incoming mail to <code>mail.km0digital.com</code> with priority <code>10</code>.</li>
    <li><strong>TXT (SPF):</strong> authorizes sending: <code>v=spf1 mx a:mail.km0digital.com ~all</code>.</li>
    <li><strong>TXT (DKIM):</strong> at host <code>mail._domainkey</code>, with the key shown in the panel.</li>
  </ul>
  <figure class="doc-figure">
    <img src="/tutorials/mail/dns-records.png" alt="DNS records table for TXT, MX, SPF, and DKIM with pending or OK status" />
    <figcaption>The DNS records and their status in My domains.</figcaption>
  </figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 4</p>
  <h2 class="doc-block-heading">Verify the domain</h2>
  <ol class="doc-list">
    <li>Return to My domains and click <strong>Verify</strong>.</li>
    <li>Each record turns from <em>pending</em> to <em>OK</em> once it is detected.</li>
  </ol>
  <p class="doc-block-intro">DNS changes can take from a few minutes to 48 hours to propagate. If they do not show yet, wait a bit and click Verify again.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Step 5</p>
  <h2 class="doc-block-heading">Create addresses on your domain</h2>
  <p class="doc-block-intro">Once the domain is <em>active</em>, you can create email addresses.</p>
  <ol class="doc-list">
    <li>On your domain, click <strong>Addresses</strong> and then <strong>Add address</strong>.</li>
    <li>Type the username (for example <code>hello</code>) to create <code>hello@yourdomain.com</code>.</li>
    <li>Set a password for that address and save.</li>
  </ol>
  <figure class="doc-figure">
    <img src="/tutorials/mail/add-address.png" alt="Form to add an address with username and password fields" />
    <figcaption>Creating an address on the verified domain.</figcaption>
  </figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Step 6</p>
  <h2 class="doc-block-heading">Sign in with the new address</h2>
  <ol class="doc-list">
    <li>Go to <a href="https://mail.km0digital.com/">https://mail.km0digital.com/</a>.</li>
    <li>Enter the full address (for example <code>hello@yourdomain.com</code>) and its password.</li>
    <li>Click <strong>Sign in</strong>.</li>
  </ol>
  <p class="doc-block-intro">Need help signing in? See the <a href="/en/tutorials/mail-sign-in/">sign-in tutorial</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Common problems</p>
  <h2 class="doc-block-heading">Troubleshooting</h2>
  <ul class="doc-list">
    <li><strong>Verification does not pass:</strong> check that host and value match the panel and wait for DNS to propagate.</li>
    <li><strong>Cannot add addresses:</strong> verify the domain first; addresses can only be created once it is active.</li>
    <li><strong>Domain already in use:</strong> another account registered it; use a domain you own.</li>
  </ul>
</section>
