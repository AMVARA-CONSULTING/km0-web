---
title: "Day 7 - From user request to GitHub issue, automated"
description: "End-to-end automation: public /ideas/ and admin Help forms enqueue JSON, cursor-agent drafts structured issues, human validation gate, then autoagents implement."
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
  <p class="doc-block-title">km0-web</p>
  <h2 class="doc-block-heading">Public ideas (<code>/ideas/</code>)</h2>
  <p class="doc-block-intro"><strong>Host:</strong> production VPS · <strong>Repo:</strong> <a href="https://github.com/AMVARA-CONSULTING/km0-web">AMVARA-CONSULTING/km0-web</a></p>
  <p>Issue <a href="https://github.com/AMVARA-CONSULTING/km0-web/issues/14">#14</a> shipped Script 1 only (form + webhook + enqueue). Script 2, systemd units, host spool <code>/var/spool/km0-ideas/</code>, and the Docker bind mount were never deployed. JSON piled up in <code>incoming/</code> with no consumer.</p>
  <h3 class="doc-block-heading">What we deployed</h3>
  <ul class="doc-list">
    <li><strong>Script 2:</strong> <code>scripts/process-idea.sh</code>, <code>scripts/setup-ideas-processor.sh</code>, <code>scripts/autoissue.sh</code>.</li>
    <li><strong>systemd:</strong> <code>deploy/systemd/km0-idea-processor.{path,service,timer}</code> (path trigger on new JSON; 24 h timer fallback).</li>
    <li><strong>Docker:</strong> bind mount <code>/var/spool/km0-ideas/incoming</code> in <code>docker-compose.yml</code>.</li>
    <li><strong>Autoissue:</strong> <code>autoissue/autoissue-agent.md</code> prompt; <code>cursor-agent</code> writes draft under <code>autoissue/drafts/</code>; parse frontmatter; <code>gh issue create --body-file</code>.</li>
    <li><strong>Gate:</strong> label <code>waiting for human validation</code>; <code>issue_checker_agent.py</code> and <code>001-gh-reviewer.md</code> skip labelled issues.</li>
  </ul>
  <div class="doc-note"><pre>Browser POST /hooks/ideas
  → receive-idea.sh → JSON in incoming/
  → systemd path trigger
  → autoissue.sh → cursor-agent → draft .md
  → gh issue create → archive JSON + draft in processed/</pre></div>
  <p>Verification: 10/10 PASS (form → queue, ~15 s E2E, clean Markdown on <a href="https://github.com/AMVARA-CONSULTING/km0-web/issues/17">issue #17</a>, label applied, autoagents ignore until removed).</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">laravel-ecommerce</p>
  <h2 class="doc-block-heading">Admin Help (staging)</h2>
  <p class="doc-block-intro"><strong>Staging:</strong> <a href="https://stage-serra.ldeluipy.es">stage-serra.ldeluipy.es</a> · <strong>Branch:</strong> <code>autoagents</code> · <strong>Repo:</strong> <a href="https://github.com/Luipy56/laravel-ecommerce">Luipy56/laravel-ecommerce</a></p>
  <p>Three blockers cleared the same day: CI was green but <code>STAGE_DEPLOY_ENABLED=false</code> (stale container, API 404); broken deploy SSH (<code>PROD_PORT=60022</code>); Admin Help lagged km0 (5 min scheduler, JSON prompt, no human gate).</p>
  <ul class="doc-list">
    <li><strong>CI/CD:</strong> staging deploy enabled via GitHub Actions (<code>stage.yml</code>); SSH secrets fixed; container at <code>0.1.340+</code>.</li>
    <li><strong>Autoissue aligned with km0:</strong> <code>autoissue/admin-help-agent.md</code>, <code>AdminHelpIssueProcessor</code>, <code>ProcessAdminHelpIssueJob</code> on POST; daily fallback <code>admin-help:process</code> at 03:00 UTC.</li>
    <li><strong>Runtime:</strong> <code>docker-compose.stage.yml</code> mounts <code>cursor-agent</code> and auth from host; <code>GH_TOKEN</code> in <code>.env</code>.</li>
  </ul>
  <p>Verified: <a href="https://github.com/Luipy56/laravel-ecommerce/issues/27">issue #27</a> E2E autoissue test on staging, confirmed by operator. Admin Help live at <code>/admin/help</code> (<a href="https://github.com/Luipy56/laravel-ecommerce/issues/26">#26</a>).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Comparison</p>
  <h2 class="doc-block-heading">Two audiences, one pipeline</h2>
  <ul class="doc-list">
    <li><strong>km0-web:</strong> public user → <code>/ideas/</code> → host spool → systemd path (+ 24 h timer) → <a href="https://github.com/AMVARA-CONSULTING/km0-web/issues/17">#17</a> example.</li>
    <li><strong>laravel-ecommerce:</strong> internal admin → <code>/admin/help</code> → Laravel storage queue → queue job (+ daily cron) → <a href="https://github.com/Luipy56/laravel-ecommerce/issues/27">#27</a> example.</li>
    <li><strong>Shared:</strong> cursor-agent draft, <code>waiting for human validation</code>, autoagents after label removal.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Outcome</p>
  <h2 class="doc-block-heading">What day 7 achieved</h2>
  <p class="doc-block-intro">The manual step between “someone asks for something” and “there is a GitHub issue a developer or agent can implement” is gone in production (km0 public ideas) and staging (ecommerce admin help).</p>
  <p>Push to <code>autoagents</code> on ecommerce updates staging in about two to three minutes. Both stacks share the same gate: draft the ticket automatically, hold for human validation, then let autoagents implement when approved.</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Series</p>
  <h2 class="doc-block-heading">Days 1–6</h2>
  <p class="doc-closing">Earlier entries cover the stack (OpenCloud, Dex, LDAP, native clients, tutorials, vision). Day 7 adds the feedback loop: try the <a href="/en/ideas/">ideas form</a> or browse <a href="/en/doc/day-6/">day 6</a> for device onboarding. Questions: <a href="/en/#contact">get in touch</a>.</p>
</section>
