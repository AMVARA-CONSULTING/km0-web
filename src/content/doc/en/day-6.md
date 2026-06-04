---
title: "Day 6 - Native clients, tutorials, and a site that matches the vision"
description: "KM0 Cloud on every device: Dex OIDC clients for desktop and mobile sync, loopback login fix, branded sharing previews, multilingual tutorials, and a refreshed km0digital.com home."
pubDate: 2026-06-03
locale: en
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">Day 6 picks up after the <a href="/en/doc/day-5/">vision meeting</a>: the stack already worked in the browser (days 1–4), but real users also need native apps, clear onboarding, and a public site that tells the same story. This entry covers that stretch of work without naming individual calendar days.</p>
  <p class="doc-lead">Two fronts move in parallel: <strong>km0digital.com</strong> gets movement-focused copy, security FAQs, and step-by-step cloud guides; <strong>cloud.km0digital.com</strong> gets OIDC fixes for desktop and mobile sync, KM0 branding, and richer link previews when URLs are shared.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Summary</p>
  <h2 class="doc-block-heading">What changed</h2>
  <ul class="doc-list">
    <li><strong>Site:</strong> Vision and Community sections on the home page; FAQ accordion UX; security answers (ISO 27001 at AMVARA, EU hosting); <a href="/en/tutorials/">KM0 Cloud tutorials</a> for web, Android, and iOS in four languages; outreach decks (CA/ES/EN) as PPT and PDF.</li>
    <li><strong>Native auth:</strong> Dex static OIDC clients for <code>OpenCloudDesktop</code>, <code>OpenCloudAndroid</code>, and <code>OpenCloudIOS</code>; nginx sends only the web browser client to <code>/login.html</code>.</li>
    <li><strong>Desktop loopback:</strong> Dex upgraded to <code>v2.42.0</code> so OAuth redirect URIs like <code>http://127.0.0.1:&lt;port&gt;</code> work (RFC 8252).</li>
    <li><strong>Brand &amp; sharing:</strong> KM0 favicon on login, Dex, and the authenticated SPA; Open Graph / Twitter cards and <code>/brand/og-preview.png</code> for social crawlers.</li>
    <li><strong>Horizon:</strong> Facebook login investigated via Dex OAuth; documented and env-gated, not enabled in production yet.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Corporate site</p>
  <h2 class="doc-block-heading">From vision to onboarding</h2>
  <p class="doc-block-intro">After day 5, the home page needed to reflect the community narrative, not only the technical stack. New <strong>Vision</strong> and <strong>Community</strong> sections, refreshed movement copy across locales, and a simpler footer (GitHub + AMVARA) anchor the story in people and place.</p>
  <p>The FAQ was rebuilt as a measured accordion (one panel open at a time) and extended with honest security answers: AMVARA CONSULTING S.L. holds ISO 27001; KM0 Cloud scope certification is planned; data stays in the EU; no third-party model training on customer files.</p>
  <p>Onboarding guides live under <a href="/en/tutorials/">/tutorials/</a>: getting started on the web, Android, and iOS, each localized. The Services block links straight to the web guide so new users are not left guessing after reading about the cloud.</p>
  <p>Three presentation decks (<em>Origen Local</em> in Catalan, <em>Impacto Digital</em> in Spanish, <em>Sovereign Tech</em> in English) were generated from site and stack content for community outreach after the Masnou meeting.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Native sync clients and OIDC</h2>
  <p class="doc-block-intro">Web login through Dex LDAP (day 4) was fine; Android, iOS, and desktop apps failed with <code>invalid client_id</code>. Dex had no static clients for the native app IDs, and nginx redirected <em>every</em> <code>/dex/auth</code> request to the hybrid <code>login.html</code>, which native clients cannot render.</p>
  <ul class="doc-list">
    <li><strong>Dex:</strong> register <code>opencloud-web</code>, <code>OpenCloudDesktop</code>, <code>OpenCloudAndroid</code>, and <code>OpenCloudIOS</code> with the redirect URIs each platform expects.</li>
    <li><strong>nginx:</strong> redirect to <code>/login.html</code> only when <code>client_id=opencloud-web</code>; mobile and desktop clients keep the Dex authorization endpoint.</li>
  </ul>
  <p>Server-side smoke checks pass (WebFinger, auth endpoint status codes). Full file sync on a physical device remains operator verification.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Why desktop needed Dex v2.42.0</h2>
  <p class="doc-block-intro">Even with the client registered, the desktop app still failed: it uses OAuth loopback (<code>http://127.0.0.1:&lt;random-port&gt;</code> on each login). Dex <code>v2.41.1</code> required an exact redirect URI match; a fixed <code>http://127.0.0.1</code> entry does not cover a new port every time.</p>
  <p>Upgrade to <code>ghcr.io/dexidp/dex:v2.42.0</code> and set <code>OpenCloudDesktop</code> with empty <code>redirectURIs</code> so Dex accepts any loopback port on <code>127.0.0.1</code> or <code>localhost</code>. Web and mobile clients were already on fixed HTTPS or custom-scheme URIs and did not need this change.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">KM0 favicon and link previews</h2>
  <p class="doc-block-intro">Shared cloud links previously showed generic OpenCloud metadata. nginx now injects Open Graph and Twitter tags for crawlers; Dex and <code>login.html</code> carry the same KM0 title and preview image (<code>/brand/og-preview.png</code>).</p>
  <p>The KM0 gradient pin favicon replaces the default OpenCloud icon on the login page, Dex LDAP screens, and the authenticated SPA theme path, so tabs and bookmarks look consistent with <a href="https://km0digital.com/">km0digital.com</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Horizon</p>
  <h2 class="doc-block-heading">Facebook login (investigation only)</h2>
  <p class="doc-block-intro">Meta login was scoped for Dex as an upstream OAuth connector (Dex remains the sole OIDC issuer for OpenCloud). Investigation is complete: example config, env-gated entrypoint hook, and runbook notes on App Review and email claims.</p>
  <p>Production enablement waits on Meta app review and a product decision on accounts without a verified email. Google, Apple, and LDAP local login are unaffected.</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Next step</p>
  <h2 class="doc-block-heading">Day 7</h2>
  <p class="doc-closing">Day 6 closes the loop between vision and daily use: sync apps, tutorials, and a site that explains both. A <strong>special day 7 entry</strong> follows separately. Until then, try the <a href="/en/tutorials/">cloud guides</a> or sign in at <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</p>
</section>
