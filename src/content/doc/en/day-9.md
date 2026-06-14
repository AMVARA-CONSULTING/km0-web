---
title: "Day 9 - Public pricing, trust, and open registration"
description: "Pricing page with market comparison, legal and security pages in four languages, public registration on cloud.km0digital.com, email alert to the dev team when an idea is submitted, and conversion polish on the landing and blog."
pubDate: 2026-06-10
locale: en
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead"><a href="/en/doc/day-8/">Day 8</a> set strategy and numbers; day 9 turns them into shippable product. Between 9 and 10 June 2026 we deployed the <a href="/en/pricing/">pricing</a> page, <a href="/en/legal/">legal</a> and <a href="/en/security/">security</a> sections, self-registration on <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>, and conversion improvements on the home page and blog.</p>
  <p class="doc-lead">KM0 stops being "something that works if we explain it" and becomes a service anyone can discover, compare, sign up for, and use without a middleman.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Summary</p>
  <h2 class="doc-block-heading">Day milestones</h2>
  <ul class="doc-list">
    <li><strong>Pricing:</strong> <a href="/en/pricing/">/pricing/</a> with 500 GB / €1.99 hero, indicative comparison table, model explanation, and CTA to cloud (#24, #25).</li>
    <li><strong>Trust:</strong> <a href="/en/legal/">legal</a> (notice, GDPR privacy, cookies) and <a href="/en/security/">security</a> (AMVARA ISO 27001, responsible disclosure) pages in four languages (#21).</li>
    <li><strong>Registration:</strong> public email/password self-registration via <code>register-api</code> on OpenCloud; Dex login with <code>dex-auth.js</code> and post-register auto sign-in.</li>
    <li><strong>Conversion:</strong> landing with more visible KM0 Cloud (#26); refined blog and tutorial typography (#27); polished service card CTAs.</li>
    <li><strong>Ideas:</strong> immediate email to the development team when someone submits an idea on <a href="/en/ideas/">/ideas/</a> (<code>f41329c</code>).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pricing</p>
  <h2 class="doc-block-heading">Public page and comparison</h2>
  <p class="doc-block-intro">The offer agreed on day 8 reaches the website with localised copy (ES, CA, EN, DE) and brand-consistent design.</p>
  <ul class="doc-list">
    <li><strong>Hero:</strong> gradient price block - <strong>€1.99/month · 500 GB</strong> - and "Start using now" button to <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</li>
    <li><strong>Comparison:</strong> indicative references (Google Drive, OneDrive, iCloud, Dropbox, MEGA) with monthly price, storage, and approximate cost per TB.</li>
    <li><strong>Claim:</strong> up to five times more space than reference basic plans at a similar price; operational trust copy below the table.</li>
    <li><strong>Transparency:</strong> "Why is our price different?" section - optimised infrastructure, operational efficiency, enough margin to sustain the service.</li>
  </ul>
  <p>Key commits: <code>7a7e9da</code> (comparison, 9 Jun), <code>9d7906c</code> (messaging and trust rework, #25), <code>82a3ef0</code> / <code>65a32d2</code> (hero and CTA, 10 Jun).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Trust</p>
  <h2 class="doc-block-heading">Multilingual legal and security</h2>
  <p class="doc-block-intro">Before asking for registration and payment, the site must answer "who operates this?" and "what happens to my data?" The new pages centralise legal information for km0digital.com and cloud.km0digital.com.</p>
  <ul class="doc-list">
    <li><strong>Legal</strong> (<code>cd5579e</code>, #21): AMVARA CONSULTING S.L. notice, GDPR privacy policy, cookies, and KM0 Cloud-specific section.</li>
    <li><strong>Security:</strong> operational practices (TLS, headers, EU/Hetzner), AMVARA ISO/IEC 27001:2022 scope, and responsible disclosure policy.</li>
    <li><strong>FAQ:</strong> existing answers now link to <a href="/en/security/#iso27001">/security/</a> and <a href="/en/legal/">/legal/</a> across all four locales.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Public registration (km0-opencloud)</h2>
  <div class="doc-note"><pre>User → /register (register.html)
        ↓
  POST /api/register → register-api (:8091, nginx rate limit)
        ↓
  Graph API (app token) creates LDAP user
        ↓
  dex-auth.js + auto sign-in → Dex session → OpenCloud</pre></div>
  <ul class="doc-list">
    <li><strong>Self-registration</strong> (<code>67fe250</code>, 10 Jun): <code>register.html</code>, loopback API, nginx <code>/api/register</code> proxy, ES/CA/EN/DE i18n.</li>
    <li><strong>Graph auth</strong> (<code>7d52675</code>): fix using <code>GRAPH_SERVICE_APP_TOKEN</code> (app Basic auth, not user password); health <code>graph_auth_ok</code>.</li>
    <li><strong>dex-auth.js</strong> (<code>efefcd3</code>): shared OIDC/PKCE module for login, register, and Dex password pages; post-register auto sign-in via session storage.</li>
    <li><strong>Operations:</strong> <code>setup-register-api-graph-token.sh</code> and <code>verify-register-api.sh</code> scripts; canonical URL <code>/register</code> (301 from <code>/register.html</code>).</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Corporate site</p>
  <h2 class="doc-block-heading">Conversion and readability (km0-web, 10 Jun)</h2>
  <ul class="doc-list">
    <li><strong>Landing</strong> (<code>5f021e4</code>, #26): more visible KM0 Cloud, accessibility, and refined conversion CTAs.</li>
    <li><strong>Services</strong> (<code>471e407</code>): KM0 Cloud card with clear CTAs to registration and tutorials.</li>
    <li><strong>Blog</strong> (<code>2425cc1</code>, <code>4487bef</code>, #27): article typography, definition-style lists, mobile TOC, and general readability.</li>
    <li><strong>Styles</strong> (<code>e5223f4</code>): global CSS import in layout; fixed <code>.doc-body</code> selectors.</li>
  </ul>
  <p>Site version at close: <strong>1.1.70</strong>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Ideas</p>
  <h2 class="doc-block-heading">Email alert to the team (last-minute)</h2>
  <p class="doc-block-intro">The <a href="/en/doc/day-7/">day 7</a> loop already queued ideas and generated GitHub tickets, but the team only found out when checking the queue or repository. With day 8's marketing push, we needed to react sooner.</p>
  <div class="doc-note"><pre>POST /hooks/ideas → receive-idea.sh
        ↓
  JSON in /var/spool/km0-ideas/incoming/
        ↓
  notify-idea-email.sh (background, fire-and-forget)
        ↓
  AutoMail API → email to dev team (subject + first 100 characters)
        ↓
  (unchanged) autoissue → gh issue create</pre></div>
  <ul class="doc-list">
    <li><strong>Script:</strong> <code>scripts/notify-idea-email.sh</code> - calls AutoMail (<code>AUTOMAIL_TOKEN</code> in repo <code>.env</code>); no <code>cursor-agent</code>.</li>
    <li><strong>Trigger:</strong> <code>receive-idea.sh</code> launches it in the background right after writing JSON to the queue.</li>
    <li><strong>Content:</strong> subject "Nueva idea km0digital" and message preview (100 characters); destination configurable via <code>AUTOMAIL_NOTIFY_TO</code>.</li>
    <li><strong>Receiver:</strong> Docker webhook sidecar moved to host systemd (<code>km0-ideas-receiver.service</code>); secrets from repo <code>.env</code>.</li>
  </ul>
  <p>The automated ticket and <code>waiting for human validation</code> label stay the same; the email is an early heads-up so someone on the team reads the idea as soon as it arrives.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verification</p>
  <h2 class="doc-block-heading">Check day 9</h2>
  <ol class="doc-steps">
    <li><strong>Pricing:</strong> visit <a href="/en/pricing/">/pricing/</a> and check hero, table, and CTA in each language.</li>
    <li><strong>Legal:</strong> review <a href="/en/legal/">/legal/</a> and <a href="/en/security/">/security/</a>; links from FAQ and footer.</li>
    <li><strong>Registration:</strong> create a test account at <a href="https://cloud.km0digital.com/register">cloud.km0digital.com/register</a>; verify auto sign-in.</li>
    <li><strong>Ideas:</strong> submit a test on <a href="/en/ideas/">/ideas/</a>; check JSON in spool and team email via AutoMail.</li>
    <li><strong>Smoke:</strong> autoagents loop - issues #21, #24, #25, #26, #27 closed; register-api health OK.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Next step</p>
  <h2 class="doc-block-heading">Day 11</h2>
  <p class="doc-closing">We did not publish a day 10 entry (internal mail deployment). <a href="/en/doc/day-11/">Day 11</a> documents <strong>KM0 Mail</strong> in production: <a href="https://mail.km0digital.com/">mail.km0digital.com</a>, DNS, deliverability, and partial OpenCloud integration. Meanwhile, try <a href="https://cloud.km0digital.com/">KM0 Cloud</a> or see <a href="/en/pricing/">pricing</a>.</p>
</section>
