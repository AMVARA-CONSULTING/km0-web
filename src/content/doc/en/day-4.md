---
title: "Day 4 - Dex local LDAP login against OpenCloud IDM"
description: "Dex LDAP connector to OpenCloud's integrated IDM, LDAPS TLS certificate fix, and GitHub issue #1 closed with automated tests in PASS."
pubDate: 2026-05-27
locale: en
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">Day 4 (window of the last four hours of 27 May 2026, ~11:40–15:40 CEST on the production Debian VPS) focuses on a single authentication goal: local login must accept any user from OpenCloud's integrated IDM (same <code>uid</code> and password as in Settings) while still issuing Dex OIDC tokens for the proxy.</p>
  <p class="doc-lead">Dex's static password store is replaced with an LDAP connector to the IDM's LDAPS, the internal LDAP service TLS certificate is fixed, and the autoagents loop closes GitHub issue #1 with automated tests in PASS.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Summary</p>
  <h2 class="doc-block-heading">Day outcome</h2>
  <ul class="doc-list">
    <li><strong>Dex ↔ IDM:</strong> <code>ldap</code> connector → <code>ldaps://opencloud:9235</code>, base <code>ou=users,o=libregraph-idm</code>; Dex on Docker network <code>opencloud_opencloud-net</code> with config/data volumes for CA <code>idm/ldap.crt</code>.</li>
    <li><strong>OpenCloud:</strong> <code>IDM_LDAPS_ADDR=0.0.0.0:9235</code> in external-proxy overlay; <code>login.html</code> uses <code>connector_id=ldap</code>; nginx and auth JSON aligned with <code>cloud.km0digital.com</code>.</li>
    <li><strong>IDM TLS:</strong> certificate regenerated with SAN <code>DNS:opencloud</code> (previously <code>localhost</code> only); script <code>regenerate-opencloud-idm-ldap-cert.sh</code>.</li>
    <li><strong>Autoagents:</strong> task closed PASS; package version 1.0.18; manual login with two distinct users pending operator verification.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Problem</p>
  <h2 class="doc-block-heading">GitHub #1</h2>
  <p class="doc-block-intro">The hybrid flow already routed Google/Apple and local login through Dex, but the local connector relied on Dex's static password store: it only worked for predefined credentials, not for all <code>inetOrgPerson</code> users created in OpenCloud's IDM.</p>
  <p>The requirement was to unify credentials with OpenCloud Settings and keep the OIDC issuer (<code>OC_OIDC_ISSUER</code>) consumed by the proxy.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Solution</p>
  <h2 class="doc-block-heading">Dex LDAP + IDM integration</h2>
  <ul class="doc-list">
    <li><strong>Dex:</strong> <code>type: ldap</code> connector in <code>dex/config.yaml</code>; local password DB removed.</li>
    <li><strong>Dex compose:</strong> joined to <code>opencloud_opencloud-net</code>; mounts <code>opencloud-config</code> and <code>opencloud-data</code> volumes to read CA and mounted config <code>idm_password</code>.</li>
    <li><strong>OpenCloud overlay:</strong> <code>IDM_LDAPS_ADDR=0.0.0.0:9235</code> so Dex reaches LDAPS via hostname <code>opencloud</code>.</li>
    <li><strong>UI:</strong> <code>login.html</code> with “local” button and <code>connector_id=ldap</code>; nginx <code>/dex/auth</code> without connector → login selector.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Flow</p>
  <h2 class="doc-block-heading">Login after the changes</h2>
  <div class="doc-note"><pre>login.html
  ├── Google  → Dex connector google  → OIDC token → OpenCloud proxy
  ├── Apple   → Dex connector apple   → (when configured)
  └── Local   → Dex connector ldap    → IDM LDAPS opencloud:9235
                                         (any inetOrgPerson uid + password)</pre></div>
  <p>Social connectors follow the same OIDC pattern; local login is no longer a fixed list in Dex but an LDAP bind against the stack's embedded directory.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Collabora</p>
  <h2 class="doc-block-heading">Co-editing after unified login</h2>
  <p class="doc-block-intro">The Collabora integration documented on <a href="/en/doc/day-3/">day 3</a> enables in-browser Office editing for all authenticated users. With day 4's Dex LDAP connector, any IDM user (same <code>uid</code> and password as Settings) can sign in and open shared spreadsheets or presentations; several people can edit the same <code>XLSX</code> or <code>PPT</code> file at once.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">TLS</p>
  <h2 class="doc-block-heading">IDM LDAPS certificate fix</h2>
  <p class="doc-block-intro">During testing, Dex reached <code>opencloud:9235</code> but the auto-generated <code>ldap.crt</code> only included <code>localhost</code> in the SAN → error <em>TLS certificate is valid for localhost, not opencloud</em>.</p>
  <p>Fix (<code>0a042db</code>): script <code>scripts/regenerate-opencloud-idm-ldap-cert.sh</code> regenerates the certificate with <code>DNS:localhost,DNS:opencloud,IP:127.0.0.1</code> and <code>--restart</code> option; documented in runbook and Dex README.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Commits</p>
  <h2 class="doc-block-heading">Day window (CEST)</h2>
  <ul class="doc-list">
    <li><code>cf5a561</code> (15:27) - <code>feat(auth): Dex LDAP login against OpenCloud IDM for all users</code>.</li>
    <li><code>0a042db</code> (15:39) - <code>fix(dex): regenerate IDM LDAP cert with opencloud SAN for Dex TLS</code>.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Autoagents</p>
  <h2 class="doc-block-heading">Closing checks</h2>
  <ul class="doc-list">
    <li>IDM cert SAN includes <code>opencloud</code> - PASS.</li>
    <li>Dex LDAP <code>host: opencloud:9235</code> - PASS.</li>
    <li><code>curl</code> with <code>connector_id=ldap</code> → <code>/dex/auth/ldap</code> - PASS.</li>
    <li>Wrong password → HTTP 401, LDAP bind, no x509 in logs - PASS.</li>
    <li>Google connector smoke - PASS.</li>
    <li>Manual login two distinct users → <code>/files</code> - NOT VERIFIED (operator).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Deployment</p>
  <h2 class="doc-block-heading">Verification (operator)</h2>
  <div class="doc-note"><pre>cd /opt/opencloud
./scripts/git-sync-main.sh
./scripts/apply-opencloud-compose-overrides.sh
./scripts/regenerate-opencloud-idm-ldap-cert.sh --restart
rsync -a /opt/opencloud/host-www/opencloud-auth/ /var/www/opencloud-auth/
cd dex && docker compose up -d

curl -sI https://cloud.km0digital.com/login.html</pre></div>
  <p>Manual: private window → <code>login.html</code> → local login with two distinct OpenCloud <code>uid</code>s; expect <code>/oidc-callback.html</code> then <code>/files</code> without JWKS errors or <code>/graph/v1.0/me</code> 500.</p>
  <div class="doc-note">User passwords and IDM bind secrets are not part of this entry; the happy path with two real accounts remains human verification in production.</div>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Next step</p>
  <h2 class="doc-block-heading">Day 5</h2>
  <p class="doc-closing"><strong>Day 5</strong> does not document deployments: it captures a vision meeting in Masnou on why we believe useful technology can already be offered without going through big digital corporations. In the meantime, explore the <a href="/en/#services">services</a> or the <a href="/en/doc/day-5/">day 5 story</a>.</p>
</section>
