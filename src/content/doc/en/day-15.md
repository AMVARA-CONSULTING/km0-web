---
title: "Day 15 - OpenCloud registration: expired Graph token and automated renewal"
description: "An expired Graph token blocked email registration on KM0 Cloud; we document the cause, safe register-api token rotation, and the defects we found while automating renewal."
pubDate: 2026-07-04
locale: en
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">On <strong>day 15</strong> we return to operational infrastructure in the sibling project <a href="https://github.com/AMVARA-CONSULTING/km0-opencloud">km0-opencloud</a>. On 4 July 2026 a user tried to register with email and password at <a href="https://cloud.km0digital.com/register.html">KM0 Cloud</a> and saw a generic error. Google OAuth still worked. The cause: the <strong>register-api Graph token had expired</strong>.</p>
  <p class="doc-lead">In <a href="https://github.com/AMVARA-CONSULTING/km0-opencloud/issues/17">issue #17</a> we implemented manual rotation, safe automatic renewal, and fixed two defects the tester found while validating the script. This article explains what happened, why it matters, and what is now automated.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Incident</p>
  <h2 class="doc-block-heading">What the user saw</h2>
  <p class="doc-block-intro">The form showed the generic message «Could not create the account. Try again later.» without indicating the service was temporarily down. The same user later signed in with <strong>Google OAuth</strong> without trouble.</p>
  <ul class="doc-list">
    <li><strong>Root cause:</strong> expired or invalid <code>GRAPH_SERVICE_APP_TOKEN</code> for register-api; Graph rejected the credentials.</li>
    <li><strong>Evidence:</strong> <code>GET /health</code> returned <code>graph_auth_ok: false</code>; <code>POST /api/register</code> responded HTTP 503.</li>
    <li><strong>OAuth intact:</strong> Google login uses Dex + OIDC, not register-api; one path worked while the other did not.</li>
    <li><strong>Prior context:</strong> <a href="https://github.com/AMVARA-CONSULTING/km0-opencloud/issues/16">issue #16</a> had already improved form error messages; this day we addressed the operational cause of the 503.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Why</p>
  <h2 class="doc-block-heading">Why register-api needs a token</h2>
  <p class="doc-block-intro">Email/password registration at <a href="https://cloud.km0digital.com/">KM0 Cloud</a> goes through a sidecar, <strong>register-api</strong>, that creates users via OpenCloud Graph (<code>POST /graph/v1.0/users</code>). In production Graph does not accept password Basic auth; register-api must authenticate with a dedicated <strong>Graph App Token</strong>.</p>
  <div class="doc-callout">
    <span class="doc-callout-title">Operational secret</span>
    <p>That token is a secret with an expiry date. If it expires and nobody renews it, manual registration fails quietly while OAuth keeps working. Treat it as infrastructure credentials, not a «set once and forget» setting.</p>
  </div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Implementation</p>
  <h2 class="doc-block-heading">Rotation and auto-renewal (issue #17)</h2>
  <ul class="doc-list">
    <li><strong>Policy:</strong> token dedicated to register-api only, <strong>3-month</strong> lifetime, automatic renewal when fewer than <strong>14 days</strong> remain.</li>
    <li><strong><code>setup-register-api-graph-token.sh</code>:</strong> creates the token with <code>--expires-in 90d</code>, writes <code>GRAPH_SERVICE_APP_TOKEN</code> and <code>GRAPH_SERVICE_APP_TOKEN_EXPIRES_AT</code> to <code>register-api/.env</code>.</li>
    <li><strong><code>renew-register-api-graph-token.sh</code>:</strong> checks health and expiry; renews if <code>graph_auth_ok</code> is false or margin is low; restarts <strong>register-api only</strong>; verifies <code>/health</code>.</li>
    <li><strong>Cron:</strong> weekly template (Monday 03:00 UTC) in <code>register-api-token-renewal.cron</code>.</li>
    <li><strong>Safety:</strong> the process never touches users, volumes, Dex/OIDC, databases, or the rest of OpenCloud <code>.env</code>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Errors found</p>
  <h2 class="doc-block-heading">What broke when testing automation</h2>
  <p class="doc-block-intro">The first version of the renewal script passed basic manual tests, but the tester found two defects when running real cron and forced-renewal scenarios.</p>
  <ul class="doc-list">
    <li><strong>Wrong Graph user:</strong> the renewal script did not propagate <code>GRAPH_SERVICE_USER</code> from <code>register-api/.env</code>. Setup generated the token for the default user (<code>admin</code>) instead of the configured operator. <strong>Fix:</strong> read <code>GRAPH_SERVICE_USER</code> from <code>.env</code> and pass it with <code>--user</code> to setup.</li>
    <li><strong>Restart race:</strong> <code>verify-register-api.sh</code> ran immediately after <code>docker compose up</code> and failed because register-api had not fully started. <strong>Fix:</strong> active wait up to 30 s (<code>REGISTER_API_HEALTH_WAIT_SEC</code>) checking <code>graph_auth_ok: true</code> before verify.</li>
  </ul>
  <p>After these changes, skip, forced renewal, and 7-day threshold scenarios all exited 0 with <code>graph_auth_ok: true</code>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Boundaries</p>
  <h2 class="doc-block-heading">What renewal must never do</h2>
  <p class="doc-block-intro">We documented explicit limits in the km0-opencloud runbook so an automated script cannot damage production.</p>
  <ul class="doc-list">
    <li>Do not run <code>docker compose down -v</code>, <code>docker volume rm</code>, or OpenCloud user reset commands.</li>
    <li>Do not modify Dex, OIDC, storage, databases, or existing groups.</li>
    <li>Only update the register-api token, restart that container, and check health.</li>
    <li>If renewal fails, Google OAuth and existing user data stay intact.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">KM0</p>
  <h2 class="doc-block-heading">Why we tell this story on the blog</h2>
  <p class="doc-block-intro">KM0 promises nearby, operable services: cloud, mail, and web under your control. An expired token is a reminder that <strong>operations matter as much as deployment</strong>.</p>
  <ul class="doc-list">
    <li><strong>Transparency:</strong> if email registration fails, there are now typed messages (issue #16) and documented rotation procedures.</li>
    <li><strong>Safe automation:</strong> weekly renewal with minimal scope, not «hero scripts» that restart the whole stack.</li>
    <li><strong>Series:</strong> <a href="/en/doc/day-14/">day 14</a> discussed AI and bureaucracy; here the bureaucracy is a token with an expiry date and a cron job that renews it before users notice.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verification</p>
  <h2 class="doc-block-heading">Check registration</h2>
  <ol class="doc-steps">
    <li><strong>Health:</strong> operators can run <code>./scripts/verify-register-api.sh</code> in km0-opencloud and confirm <code>graph_auth_ok: true</code>.</li>
    <li><strong>Registration:</strong> try <a href="https://cloud.km0digital.com/register.html">email/password registration</a> or sign in with Google if you already have an account.</li>
    <li><strong>Series:</strong> read <a href="/en/doc/day-14/">day 14</a> (Harari and AI) and <a href="/en/doc/day-11/">day 11</a> (KM0 Mail).</li>
    <li><strong>Ideas:</strong> tell us via the <a href="/en/ideas/">ideas form</a> or <a href="/en/#contact">contact</a> if you want more posts on KM0 Cloud operations.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Series</p>
  <h2 class="doc-block-heading">Previous days</h2>
  <p class="doc-closing"><a href="/en/doc/day-14/">Day 14</a> summarised Harari's video on AI and civilization; <a href="/en/doc/day-13/">day 13</a> covered meet 6 on visibility; <a href="/en/doc/day-11/">day 11</a> documented KM0 Mail. Follow the series and try <a href="https://cloud.km0digital.com/">KM0 Cloud</a> whenever you like.</p>
</section>
