---
title: "Day 8 - Strategy, pricing, and first marketing materials"
description: "A multi-hour meeting on KM0's future: customer acquisition, marketing campaign, DIN A6 flyers, and a 500 GB / €1.99 pricing model. The website starts to reflect it."
pubDate: 2026-06-08
locale: en
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">After closing the feedback loop on <a href="/en/doc/day-7/">day 7</a>, the team spent the first week of June on a different conversation: not about commits or deployments, but about <strong>how to reach people who do not know KM0 yet</strong>. The project lead and development team talked for several hours, across multiple sessions, about the application's future, customer acquisition, and the need for a concrete marketing campaign.</p>
  <p class="doc-lead">Decisions from that table are already visible on km0digital.com: an honest public price, materials to hand out in DIN A6 format, and a downloadable presentation page that summarises the offer without technical jargon.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Summary</p>
  <h2 class="doc-block-heading">What we decided</h2>
  <ul class="doc-list">
    <li><strong>Acquisition:</strong> combine local presence (word of mouth, associations, neighbourhood shops) with digital channels (website, WhatsApp, ideas form).</li>
    <li><strong>Marketing:</strong> prepare a light but steady campaign; centrepiece: printed <strong>DIN A6</strong> flyers (hand-sized postcard, cheap to print, easy to leave on counters).</li>
    <li><strong>Price:</strong> <strong>500 GB for €1.99/month</strong> - enough to sustain infrastructure, clearly below competitors' basic plans.</li>
    <li><strong>Web:</strong> <a href="/en/presentation/">presentation</a> page with PDF, user count on <a href="/en/cloud/">/cloud/</a>, quick access to the WhatsApp group, and clearer navigation.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Strategy</p>
  <h2 class="doc-block-heading">Several hours on the future</h2>
  <p class="doc-block-intro">The underlying question was not "what feature is missing?" but "how do we find the first people who trust us?" KM0 already works technically; what is missing is visibility and an offer understandable in thirty seconds.</p>
  <ul class="doc-list">
    <li><strong>Target audience:</strong> families, associations, cooperatives, local shops, and small organisations that overpay for cloud storage without knowing alternatives.</li>
    <li><strong>Message:</strong> proximity, transparency, and fair pricing - the same narrative as <a href="/en/doc/day-5/">day 5</a>, now with concrete numbers.</li>
    <li><strong>Campaign:</strong> not a big ad spend, but repeatable actions: flyers, short talks, QR codes to the website, and follow-up via WhatsApp.</li>
    <li><strong>Measurement:</strong> track visits and sign-ups from each channel before scaling what works.</li>
  </ul>
  <div class="doc-callout">
    <span class="doc-callout-title">Quote from the table</span>
    <p>"We do not need to be the cheapest in the entire market; we need to be cheap enough for people to try, and sustainable enough to keep operating."</p>
  </div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pricing</p>
  <h2 class="doc-block-heading">500 GB for €1.99 per month</h2>
  <p class="doc-block-intro">We ran the numbers against real infrastructure cost (storage, backups, EU operations). The goal: one simple, readable, sustainable plan - not maximising margin per customer, but covering costs and growing with volume.</p>
  <ul class="doc-list">
    <li><strong>Public offer:</strong> 500 GB for €1.99/month - up to five times more space than reference basic plans (~100 GB for ~€2).</li>
    <li><strong>Internal logic:</strong> with infrastructure cost on the order of ~€2/TB/month, the plan leaves operational margin even if a customer uses the full quota; with lower average usage (prudent overselling scenario), the model holds better.</li>
    <li><strong>Principle:</strong> charge what it costs to run the service cleanly, not replicate big-platform margins.</li>
    <li><strong>Next step:</strong> publish the comparison and pricing explanation on <a href="/en/pricing/">/pricing/</a> (day 9).</li>
  </ul>
  <div class="doc-note">Full economics live in internal repo documentation (<code>docs/pricing-economics.md</code>); the public site shows only the offer and indicative market references.</div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Marketing</p>
  <h2 class="doc-block-heading">DIN A6 flyers and web presentation</h2>
  <p class="doc-block-intro">The DIN A6 flyer fits the proximity strategy: pocket-sized, cheap to print in small runs, and carries QR codes to km0digital.com and the cloud. Content reuses the corporate presentation message - values, comparison with big platforms, price, and contact.</p>
  <ul class="doc-list">
    <li><strong>Format:</strong> DIN A6 (105 × 148 mm), double-sided, QR to <a href="/en/presentation/">/presentation/</a> and <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</li>
    <li><strong>Web:</strong> new <a href="/en/presentation/">Presentation</a> page with original PDF download (~618 KB) in four languages.</li>
    <li><strong>WhatsApp:</strong> visible hint in the contact section to join the community group.</li>
    <li><strong>Planned distribution:</strong> neighbourhood shops, local associations, and community events around Masnou / Maresme.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Corporate site</p>
  <h2 class="doc-block-heading">Technical delivery (5–6 June, km0-web)</h2>
  <ul class="doc-list">
    <li><strong>Presentation</strong> (<code>2d90880</code>): localised <code>/presentation/</code> page with downloadable PDF; shared brand logo and asset caching.</li>
    <li><strong>Cloud</strong> (<code>4a5442b</code>): OpenCloud user count on localised <a href="/en/cloud/">/cloud/</a> pages.</li>
    <li><strong>Contact</strong> (<code>cafd20f</code>): WhatsApp hint and "Powered by" credits in the footer.</li>
    <li><strong>Navigation</strong> (<code>e8df837</code>): streamlined menu and improved mobile scroll in <code>Header.astro</code>.</li>
    <li><strong>Footer</strong> (<code>6bb66d4</code>, <code>974f303</code>, <code>abc725b</code>): GitHub repo creation date, "Powered by AMVARA" credit, and GitHub logo beside the link.</li>
    <li><strong>Routes</strong> (<code>a5b7c4a</code>): unified <code>/presentation/</code> path (formerly <code>presentacion</code>).</li>
  </ul>
  <p>Site version at day 8 close: <strong>1.1.x</strong> (5–6 June commits; pricing page arrives on day 9).</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Next step</p>
  <h2 class="doc-block-heading">Day 9</h2>
  <p class="doc-closing"><a href="/en/doc/day-9/">Day 9</a> publishes the <a href="/en/pricing/">pricing</a> page, <a href="/en/legal/">legal</a> and <a href="/en/security/">security</a> pages, public cloud registration, and landing conversion polish. Meanwhile, download the <a href="/en/presentation/">presentation</a> or try the <a href="/en/ideas/">ideas form</a>.</p>
</section>
