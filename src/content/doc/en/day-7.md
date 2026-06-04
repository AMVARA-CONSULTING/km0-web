---
title: "Day 7 - From request to ticket, automated"
description: "End-to-end automation: the ideas form and Admin Help turn submissions into clear tickets, with human review before anything gets built."
pubDate: 2026-06-04
locale: en
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">Day 7 is a special entry: it documents automation that closes a gap the earlier days left open. Someone submits an idea or incident; a developer used to read raw text, rewrite it as a GitHub issue, and only then start implementation. That handoff was the bottleneck.</p>
  <p class="doc-lead">On 4 June 2026 we wired the full loop in two channels: public feedback on <a href="https://km0digital.com/en/ideas/">km0digital.com</a> (production) and internal admin Help on a Laravel ecommerce staging stack. Same mental model: queue, autoissue draft, human label, autoagents pickup.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Summary</p>
  <h2 class="doc-block-heading">Before and after</h2>
  <ul class="doc-list">
    <li><strong>Request:</strong> loose message or email → structured JSON in a queue.</li>
    <li><strong>Understanding:</strong> developer parses raw text → <code>cursor-agent</code> writes a structured <code>.md</code> draft.</li>
    <li><strong>Ticket:</strong> manual <code>gh issue create</code> → automated issue with clean Markdown body.</li>
    <li><strong>Human control:</strong> implicit → label <code>waiting for human validation</code>.</li>
    <li><strong>Implementation:</strong> developer assigns work → human removes the label → autoagents (001 / FEAT) pick up the issue.</li>
  </ul>
  <p>The developer no longer opens a raw submission and writes the ticket from scratch. The system enqueues, drafts, and publishes to GitHub in seconds. A human validates or edits by removing the label; then the agent pipeline can implement.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Architecture</p>
  <h2 class="doc-block-heading">Two inputs, one pattern</h2>
  <div class="doc-note"><pre>INPUT
  km0-web:     POST /hooks/ideas        (public /ideas/)
  ecommerce:   POST /api/v1/admin/help  (authenticated /admin/help)
        ↓
  JSON queue (spool / storage)
        ↓
  Immediate trigger (systemd path / queue job)
        ↓
  cursor-agent (--yolo) + autoissue prompt → draft .md
        ↓
  gh issue create --body-file + label waiting for human validation
        ↓
  Human reviews → removes label → autoagents 001 → FEAT → code</pre></div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Why it fits</p>
  <h2 class="doc-block-heading">A practical pattern for small teams</h2>
  <p class="doc-block-intro">We were not chasing automation for its own sake. We wanted useful requests to stop dying in a chat thread, an inbox, or someone's memory. The system turns each submission into a readable ticket, with context and scope, in seconds.</p>
  <ul class="doc-list">
    <li><strong>Speed:</strong> the sender does not wait for someone to find time to write up the incident.</li>
    <li><strong>Quality:</strong> every draft follows the same shape (what happens, for whom, what is expected).</li>
    <li><strong>Control:</strong> nothing enters development until a person on the team approves it.</li>
    <li><strong>Reusable:</strong> the same pattern works for public feedback and internal requests.</li>
  </ul>
  <p>For KM0 it is especially apt: we hear from non-technical people and want to treat their input with the same care as a report from an ecommerce admin.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Where it applies</p>
  <h2 class="doc-block-heading">Two entry points, one journey</h2>
  <ul class="doc-list">
    <li><strong>KM0 users:</strong> the <a href="/en/ideas/">Ideas</a> form on km0digital.com. Product suggestions, website improvements, or gaps someone notices while using the cloud.</li>
    <li><strong>People running an internal project:</strong> the Admin Help screen on an online shop in staging. For when a team member spots a bug or needs a change and wants it logged with a clear trail.</li>
  </ul>
  <p>In both cases the journey is the same: form → queue → drafted ticket → human review → implementation. Only the writer and the surface change, not the logic.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Examples</p>
  <h2 class="doc-block-heading">What it looks like in practice</h2>
  <p class="doc-block-intro">Suppose someone submits via <a href="/en/ideas/">Ideas</a>: “I'd like a button to share blog posts.” Within about fifteen seconds the system produces a titled, structured ticket: what the person asked for, which language they used, which part of the site it touches. It is marked <em>waiting for human validation</em>.</p>
  <p>Someone on the team reads it. If the wording is fine, they remove the mark and the ticket joins the automated implementation queue. If it needs nuance (“mobile only”, “WhatsApp icon”), they edit the ticket before approving. No copying the original message by hand.</p>
  <p>Another case: a shop admin in staging reports through Admin Help that a product filter does not save correctly. Same mechanics: a clear ticket, a review step, then development. The goal is that nobody has to guess what the sender meant.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">People</p>
  <h2 class="doc-block-heading">What automation does (and does not)</h2>
  <p class="doc-block-intro">The machine drafts and classifies. A person decides. Development agents do not pick up tickets while they are still marked pending validation, so we avoid building on vague messages or noise.</p>
  <p>For someone sending an idea, the benefit is simple: write once in plain language and the team receives something actionable. For whoever runs the service, the benefit is no longer being the permanent translator between “WhatsApp message” and “well-written ticket”.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Outcome</p>
  <h2 class="doc-block-heading">What day 7 achieved</h2>
  <p class="doc-block-intro">The manual step between “someone asks for something” and “there is a ticket that can be implemented” is gone in production (KM0 public ideas) and on the ecommerce staging environment (Admin Help).</p>
  <p>The full cycle now works: request, drafted ticket, human validation, and agent-assisted implementation. It was the missing piece to close the loop between listening to the community and shipping changes with judgment.</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Series</p>
  <h2 class="doc-block-heading">Days 1–6</h2>
  <p class="doc-closing">Earlier entries cover the stack (OpenCloud, Dex, LDAP, native clients, tutorials, vision). Day 7 adds the feedback loop: try the <a href="/en/ideas/">ideas form</a> or browse <a href="/en/doc/day-6/">day 6</a> for device onboarding. Questions: <a href="/en/#contact">get in touch</a>.</p>
</section>
