---
title: "Day 12 - Client talk: user experience"
description: "Conversation with a real user about tutorials, service shortcuts on the web, indexing outside Europe, unified login, and KM0 privacy positioning."
pubDate: 2026-06-22
locale: en
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">After turning on <a href="/en/doc/day-11/">KM0 Mail in production</a>, we held a <strong>client conversation</strong> (Luzma) focused on what it feels like to use KM0 from the outside: where login lives, what still needs explaining, and which small improvements would matter without redesigning the whole product.</p>
  <p class="doc-lead">This entry is not a word-for-word transcript; it summarises the actionable themes and how they fit the immediate roadmap for km0-web and related services.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Summary</p>
  <h2 class="doc-block-heading">Key themes from the talk</h2>
  <ul class="doc-list">
    <li><strong>User experience:</strong> simple, visible tutorials, not long manuals or technical jargon.</li>
    <li><strong>Shortcuts:</strong> a Google-style nine-dot widget on the site with links to cloud, mail, registration, and docs.</li>
    <li><strong>New tutorials:</strong> macOS installation, how to share files, and a short getting-started video.</li>
    <li><strong>Indexing:</strong> improve discoverability outside the EU (browsers like Brave with regional filters).</li>
    <li><strong>Login and billing:</strong> one access flow, clear payment copy on the main screen, and fewer confusing logout pages.</li>
    <li><strong>Privacy:</strong> reinforce that KM0 is not a mega-corporation and does not monetise your data.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Tutorials</p>
  <h2 class="doc-block-heading">Learn in minutes, not hours</h2>
  <p class="doc-block-intro">The user did not ask for more features; she asked <strong>where to start</strong>. Recurring questions: «where do I sign in?», «how do I install this on my Mac?», and «how do I share a folder?».</p>
  <ul class="doc-list">
    <li><strong>macOS tutorial:</strong> step-by-step guide to install and connect the desktop app (separate km0-web issue).</li>
    <li><strong>Sharing:</strong> screenshots or a short video of the invite and permissions flow in OpenCloud.</li>
    <li><strong>Getting started:</strong> a few-minute video covering registration, login, file upload, and webmail access.</li>
    <li><strong>Login placement:</strong> visible links from the home page and from the services widget, not only from subdomains.</li>
    <li><strong>Language:</strong> materials in Spanish and Catalan at minimum; the site already offers four locales.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Services widget</p>
  <h2 class="doc-block-heading">Shortcuts on the home page</h2>
  <p class="doc-block-intro">Concrete proposal from the talk: a Google-style grid button on the landing page that lists KM0 services without memorising URLs.</p>
  <ul class="doc-list">
    <li><strong>Cloud:</strong> link to <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> with registration and login.</li>
    <li><strong>Mail:</strong> access to <a href="https://mail.km0digital.com/">mail.km0digital.com</a> for mailbox holders.</li>
    <li><strong>Documentation:</strong> link to the <a href="/en/doc/">blog / doc</a> and downloadable <a href="/en/presentation/">presentation</a>.</li>
    <li><strong>Ideas and contact:</strong> quick access to <a href="/en/ideas/">ideas</a> and <a href="/en/#contact">contact</a>.</li>
    <li><strong>Implementation:</strong> lightweight component in km0-web; it complements current navigation rather than replacing it.</li>
  </ul>
  <div class="doc-callout">
    <span class="doc-callout-title">Goal</span>
    <p>Someone new should reach cloud, mail, and help in one click from the home page, without hunting the footer or guessing subdomains.</p>
  </div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Login and billing</p>
  <h2 class="doc-block-heading">One entry point, less friction</h2>
  <p class="doc-block-intro">Several entry points coexist today (web, desktop app, Roundcube). The talk made clear that <strong>two different logins confuse</strong> and that the payment screen needs an honest sentence before the form.</p>
  <ul class="doc-list">
    <li><strong>Unified login:</strong> same destination from the desktop app and the public web (product work in progress).</li>
    <li><strong>Payment copy:</strong> brief text on the main registration screen: what the plan includes, when billing starts, and how to cancel.</li>
    <li><strong>Logout:</strong> simplify or remove intermediate pages that leave users stuck.</li>
    <li><strong>Desktop:</strong> the app should open the same SSO as the browser, not a parallel form.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Indexing and privacy</p>
  <h2 class="doc-block-heading">Being found outside Europe and saying who we are</h2>
  <p class="doc-block-intro">Part of the conversation covered regional search filters (for example Brave) and the need for km0digital to appear when someone looks for private alternatives to big cloud suites.</p>
  <ul class="doc-list">
    <li><strong>International SEO:</strong> hreflang, sitemap, and metadata already in km0-web; keep improving titles and descriptions per locale (see issue #58).</li>
    <li><strong>Useful content:</strong> blog entries like this one help organic indexing without paid campaigns.</li>
    <li><strong>Privacy message:</strong> KM0 is not a mega-corporation; we do not sell profiles or train models on your files.</li>
    <li><strong>Transparency:</strong> <a href="/en/legal/">legal</a> and <a href="/en/security/">security</a> pages linked from tutorials and the widget.</li>
    <li><strong>Radar:</strong> we prefer growth through referrals and associations (<a href="/en/doc/day-13/">day 13</a>) over advertising noise.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Roadmap</p>
  <h2 class="doc-block-heading">What follows this talk</h2>
  <ol class="doc-steps">
    <li><strong>Services widget</strong> on the km0-web landing page.</li>
    <li><strong>macOS tutorial</strong> and sharing guide in doc or embedded video.</li>
    <li><strong>SEO improvements</strong> and indexing outside the EU (issue #58).</li>
    <li><strong>Unified login</strong> and payment copy on OpenCloud registration.</li>
    <li><strong>Getting-started video</strong> linked from the home page and blog.</li>
  </ol>
  <p>Most items are small changes stacked together; combined they reduce the friction a real user described in the talk.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verification</p>
  <h2 class="doc-block-heading">Try what already exists</h2>
  <ol class="doc-steps">
    <li><strong>Home:</strong> open <a href="/en/">km0digital.com</a> and locate links to cloud, mail, and doc.</li>
    <li><strong>Cloud:</strong> test registration at <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</li>
    <li><strong>Mail:</strong> webmail at <a href="https://mail.km0digital.com/">mail.km0digital.com</a> if you have a mailbox.</li>
    <li><strong>Doc:</strong> read <a href="/en/doc/day-11/">day 11</a> (mail) and <a href="/en/doc/day-13/">day 13</a> (meet 6).</li>
    <li><strong>Feedback:</strong> send improvements via <a href="/en/ideas/">ideas</a> or <a href="/en/#contact">contact</a>.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Series</p>
  <h2 class="doc-block-heading">Related entries</h2>
  <p class="doc-closing"><a href="/en/doc/day-11/">Day 11</a> documented KM0 Mail; this talk (day 12) captures UX and accessibility; <a href="/en/doc/day-13/">day 13</a> summarises meet 6 on visibility and associations. Try the <a href="https://mail.km0digital.com/">webmail</a>, see <a href="/en/pricing/">pricing</a>, and tell us which tutorial you would miss most.</p>
</section>
