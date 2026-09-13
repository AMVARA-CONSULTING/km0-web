---
## Closing summary (TOP)

- **What happened:** Operator asked for a Visitors so far count in the km0-web footer. Autoagents loop could not code (cursor-agent Ultra usage limit until 2026-09-07).
- **What was done:** Maestro shipped first-party unique visitor counter: host API `:9182`, nginx `/api/visitors`, footer line + i18n, durable state under `/var/spool/km0-visitors/`, UFW Docker allow, site **1.3.11**.
- **What was tested:** API GET/POST dedupe; prod `https://km0digital.com/api/visitors`; footer markup on `/en/`; container proxy via `host.docker.internal:9182`.
- **Why closed:** Acceptance met; live on km0digital.com.
- **Closed at (UTC):** 2026-09-06 08:35
---

# NEW-Task: Visitors so far count in site footer

## GitHub Issue
- **Issue:** (none yet - operator request via Maestro / Discord)
- **Number:** #0

## Origin
- **Source:** Direct operator request (Luipy / Maestro `/ca`).
- **Brief:** Show a cumulative **"Visitors so far"** count in the km0-web site footer.

## Problem / goal
The public marketing site (`Footer.astro`) has no visitor count. Add a clear, craft-aligned **"Visitors so far"** line in the footer that shows a durable cumulative count for real traffic to km0digital.com.

Site constraint: Astro `output: "static"` served by nginx in Docker (`127.0.0.1:9180`). Any live counter needs a small host-side endpoint or equivalent (not a fake client-only number).

## Locked decisions
1. **Placement:** Footer bottom meta band (same block as © / version / repo-since), not a new column and not a hero widget. One quiet line; tabular nums; Ink/Mist hierarchy like existing meta text.
2. **Copy:** Label i18n key under `footer` in `es` / `ca` / `en` / `de`. English label: **"Visitors so far"**. Other locales: natural equivalent (not literal machine paste). Format: label + formatted integer (e.g. locale-aware thousands separators).
3. **Metric:** Cumulative **unique visitors**, not raw pageviews. Deduplicate with a short-lived first-party cookie or equivalent (e.g. 24h) so the same browser is not counted on every page. Do **not** store raw IP in the public JSON or Discord.
4. **Privacy:** First-party only. No Plausible/Umami/Google/third-party scripts. No personal data in the public API response (count integer only).
5. **Backend:** Small durable store on **amvara10** under this project (file or sqlite under a spool path like `/var/spool/km0-visitors/` or similar). Expose `GET` (read count) + `POST`/`GET` hit (increment once per unique window) on the **host**, proxied by host nginx for `km0digital.com` (and local `9180` path if needed). Prefer extending existing host patterns (`km0-ideas-receiver` / host nginx under `nginx/sites-available/`) over adding a new SaaS. Keep the container image static HTML + a tiny client script or fetch from the footer.
6. **Initial seed:** If historical nginx access logs can give a sane unique-IP baseline without PII in git, optional one-time seed; otherwise start from 0 and document. Do not invent a fake marketing number.
7. **Craft:** Anti-slop. No purple, glow, animated odometer spam, badge stickers, or card chrome. Match footer typography. Skills: `km0-anti-slop-design`, `km0-web-copy`. Read `docs/design/anti-slop-doctrine.md` and `docs/brand-tokens.md`.
8. **Ops:** Document in `docs/runbook.md` (endpoint, spool path, how to restart). `./scripts/bump-patch-version.sh` once. `npm run build` + compose rebuild per runbook before UNTESTED-.

## Scope
1. `src/components/Footer.astro` (+ tiny client script if needed under `src/scripts/`).
2. `src/i18n/{es,ca,en,de}.json` footer strings + types if required.
3. Host-side counter service or hook + durable store + nginx proxy path.
4. Runbook note; patch version bump; Testing instructions; rename to UNTESTED-.

## Out of scope
- Full analytics dashboard, charts, referrers, geo maps
- Third-party analytics vendors
- Footer redesign / column layout changes
- Counting bot traffic as a hard requirement (best-effort filter for obvious bots is OK)

## Acceptance (hard)
- [ ] Footer shows **"Visitors so far"** (or locale equivalent) + live cumulative unique-visitor integer on home and at least one secondary locale page
- [ ] Count persists across container rebuilds (store on host, not only in the image)
- [ ] Same browser within the dedupe window does not inflate the count on every navigation
- [ ] Public response exposes only the count (no IPs, no UA dumps)
- [ ] No em dash; no mailto; site version bumped; build + deploy verified
- [ ] Hard gate eye-test (below); soft class-only alone = fail

## High-level instructions for coder
- Read this task fully before coding. Prefer smallest durable design.
- Inspect current footer meta band and i18n `footer.*` keys first.
- Wire host nginx so production and local `:9180` (if applicable) can reach the counter without CORS pain (same-origin path preferred, e.g. `/api/visitors`).
- Client: fetch count on load; fire one hit beacon per unique window; fail soft (hide or show em dash-free placeholder like `-` is forbidden - use `n/a` or omit the line if API down).
- Skills + doctrine as above. Deploy verification: `docs/runbook.md`.

## Testing instructions
(to be filled by coder before UNTESTED-)

## References
- Runbook: docs/runbook.md
- Anti-slop: docs/design/anti-slop-doctrine.md
- Brand tokens: docs/brand-tokens.md
- Footer: src/components/Footer.astro
- Site: https://km0digital.com
