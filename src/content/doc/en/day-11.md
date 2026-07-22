---
title: "Day 11 - KM0 Email in production"
description: "@km0digital.com mail with Postfix, Dovecot, Rspamd, and Roundcube on mail.km0digital.com; MX/SPF/DKIM/DMARC DNS, OpenCloud relay, and phase 1b plans."
pubDate: 2026-06-14
locale: en
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead"><a href="/en/doc/day-9/">Day 9</a> shipped pricing, legal, OpenCloud registration, and conversion polish. <strong>We did not publish a day 10 entry</strong> (internal mail deployment without an article). On 14 June 2026 we turned on <strong>KM0 Email</strong>: <code>@km0digital.com</code> mailboxes, webmail at <a href="https://mail.km0digital.com/">mail.km0digital.com</a>, and SMTP relay for OpenCloud notifications.</p>
  <p class="doc-lead">KM0 no longer relies on Gmail or external APIs for operational mail on the domain, and opens the path to registration verification, idea alerts, and marketing on the same infrastructure.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Summary</p>
  <h2 class="doc-block-heading">Day milestones</h2>
  <ul class="doc-list">
    <li><strong>Stack:</strong> <a href="https://github.com/AMVARA-CONSULTING/km0-mail">AMVARA-CONSULTING/km0-mail</a> repo with Postfix, Dovecot, Rspamd, Roundcube, and PostgreSQL (Docker Compose).</li>
    <li><strong>Hostname:</strong> <code>mail.km0digital.com</code> on the same VPS as OpenCloud (<code>116.202.10.106</code>).</li>
    <li><strong>Webmail:</strong> Nginx + Let's Encrypt to Roundcube on loopback <code>:8080</code>.</li>
    <li><strong>Operations:</strong> <code>postmaster@</code> and <code>noreply@</code> mailboxes; CLI <code>./scripts/km0-mail-admin</code>.</li>
    <li><strong>Security:</strong> Rspamd + DKIM signing; fail2ban <code>km0-mail</code> jail; UFW 25, 587, 993.</li>
    <li><strong>OpenCloud:</strong> local Postfix relay (<code>host.docker.internal:587</code>, no auth) with sender <code>noreply@km0digital.com</code>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">KM0 Email</p>
  <h2 class="doc-block-heading">Architecture and flow</h2>
  <div class="doc-note"><pre>Internet (MX @ → mail.km0digital.com)
        ↓
  Postfix (:25 / :587 submission)
        ↓
  Rspamd (anti-spam, DKIM signing)
        ↓
  Dovecot (:993 IMAPS) → Maildir
        ↓
  Roundcube (webmail, loopback :8080 → Nginx TLS)</pre></div>
  <ul class="doc-list">
    <li><strong>Inbound:</strong> Postfix accepts mail for <code>@km0digital.com</code> and delivers to Maildir via Dovecot LMTP.</li>
    <li><strong>Outbound:</strong> authenticated clients (587) and internal relay from OpenCloud without Docker-network credentials.</li>
    <li><strong>Webmail:</strong> Roundcube talks to Dovecot; public access only via HTTPS on the mail subdomain.</li>
    <li><strong>Admin:</strong> <code>km0-mail-admin create-mailbox</code>, <code>alias</code>, <code>set-password</code> documented in the <a href="https://github.com/AMVARA-CONSULTING/km0-mail/blob/main/docs/runbook.md">km0-mail runbook</a>.</li>
    <li><strong>Reference issue:</strong> <a href="https://github.com/AMVARA-CONSULTING/km0-mail/issues/1">km0-mail #1</a> (Redmine #7605).</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">DNS</p>
  <h2 class="doc-block-heading">Deliverability</h2>
  <p class="doc-block-intro">Without correct records mail lands in spam or bounces. The full checklist lives in <a href="https://github.com/AMVARA-CONSULTING/km0-mail/blob/main/docs/joker-dns-checklist.md">docs/joker-dns-checklist.md</a> in the km0-mail repo.</p>
  <ul class="doc-list">
    <li><strong>MX:</strong> <code>@</code> → <code>mail.km0digital.com</code>.</li>
    <li><strong>SPF:</strong> TXT record authorising the KM0 outbound server.</li>
    <li><strong>DKIM:</strong> selector <code>mail._domainkey</code> with public key in DNS.</li>
    <li><strong>DMARC:</strong> policy <code>p=none</code> with reports to <code>postmaster@km0digital.com</code>.</li>
    <li><strong>PTR:</strong> Hetzner points to <code>mail.km0digital.com</code> (consistent with HELO/EHLO).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Phase 1 integration (partial)</h2>
  <div class="doc-note"><pre>OpenCloud (notifications)
        ↓
  host.docker.internal:587 (Postfix relay, no auth)
        ↓
  Postfix → Rspamd → Internet outbound
  Sender: noreply@km0digital.com</pre></div>
  <ul class="doc-list">
    <li><strong>km0-opencloud:</strong> <code>SMTP_*</code> variables in <code>.env</code> and <code>extra_hosts</code> in compose to reach host Postfix.</li>
    <li><strong>Scope:</strong> cloud notifications already leave via KM0 Email; registration email verification remains pending (phase 1b).</li>
    <li><strong>LDAP:</strong> no unification in phase 1; <code>mail_accounts.opencloud_uuid</code> column reserved for later.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Product</p>
  <h2 class="doc-block-heading">Decisions today</h2>
  <ul class="doc-list">
    <li><strong>Pricing:</strong> mail included de facto in the KM0 offer; executive pricing decision later.</li>
    <li><strong>Scale:</strong> target &gt;1000 mailboxes before year end.</li>
    <li><strong>Legal:</strong> <a href="/en/legal/">/legal/</a> and <a href="/en/security/">/security/</a> pages do not yet cover <code>mail.km0digital.com</code> (separate issue).</li>
    <li><strong>Services:</strong> Email card on the home page stays disabled until phase 1b (separate issue).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Roadmap</p>
  <h2 class="doc-block-heading">Phase 1b pending</h2>
  <p class="doc-block-intro">The following is planned but <strong>not implemented yet</strong> in this release:</p>
  <ol class="doc-steps">
    <li><strong>register-api:</strong> email verification via local Postfix (replace Gmail/external).</li>
    <li><strong>km0-web</strong> <code>scripts/notify-idea-email.sh</code>: local relay (today AutoMail API).</li>
    <li><strong>Marketing / tmp:</strong> local SMTP for campaigns and temporary environments.</li>
    <li><strong>Legal and security</strong> on km0-web: cover <code>mail.km0digital.com</code>.</li>
    <li><strong>Email block</strong> in services: enable active card on the landing.</li>
    <li><strong>Backup:</strong> maildir cron documented in runbook.</li>
    <li><strong>Phase 2:</strong> ClamAV, LDAP unification, automated provisioning.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verification</p>
  <h2 class="doc-block-heading">Check day 11</h2>
  <ol class="doc-steps">
    <li><strong>Webmail:</strong> open <a href="https://mail.km0digital.com/">mail.km0digital.com</a> and verify TLS certificate.</li>
    <li><strong>MX:</strong> <code>dig +short MX km0digital.com</code> should resolve to <code>mail.km0digital.com</code>.</li>
    <li><strong>SPF:</strong> <code>dig +short TXT km0digital.com</code> includes an SPF record.</li>
    <li><strong>DKIM:</strong> <code>dig +short TXT mail._domainkey.km0digital.com</code> returns the public key.</li>
    <li><strong>DMARC:</strong> <code>dig +short TXT _dmarc.km0digital.com</code> shows policy and reporting.</li>
    <li><strong>PTR:</strong> <code>dig +short -x 116.202.10.106</code> matches the mail server hostname.</li>
    <li><strong>Checklist:</strong> follow <a href="https://github.com/AMVARA-CONSULTING/km0-mail/blob/main/docs/joker-dns-checklist.md">joker-dns-checklist.md</a> step by step.</li>
    <li><strong>OpenCloud:</strong> trigger a test notification and verify sender <code>noreply@km0digital.com</code>.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Series</p>
  <h2 class="doc-block-heading">Next entry</h2>
  <p class="doc-closing"><a href="/en/doc/day-12/">Day 12</a> covers the client talk on UX; <a href="/en/doc/day-13/">day 13</a> covers meet 6: visibility, associations (PTAs, neighbours), and commercial next steps. Meanwhile, try the <a href="https://mail.km0digital.com/">webmail</a> or see <a href="/en/pricing/">pricing</a>. Questions: <a href="/en/#contact">contact</a>.</p>
</section>
