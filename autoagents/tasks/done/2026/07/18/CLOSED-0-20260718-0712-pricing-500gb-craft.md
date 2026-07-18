---
## Closing summary (TOP)

- **What happened:** Pricing masthead capacity felt flat as a single “500 GB” Signal string versus the home hero proof.
- **What was done:** Split capacity/unit/host meta in i18n, shipped display **500** + Signal **GB**, abundance meter, and once-only count-up via `hero-capacity.ts` on `.pricing-hero-stat` (site **1.1.134**).
- **What was tested:** Hard gate PASS (3 parity + 3 anti-slop vs home proof); Playwright motion + reduced-motion; four-locale 200; aria honesty; em-dash/mailto; prod `/en/pricing/` markers.
- **Why closed:** All acceptance criteria and craft Hard gate protocol passed; no soft-evidence or anti-slop blocks.
- **Closed at (UTC):** 2026-07-18 07:23
---

# NEW-Task: Pricing masthead 500 GB craft

## Origin
- **Source:** Direct operator request (skip GitHub). `/pricing/` capacity readout feels flat (“soso”).
- **Brief:** `docs/design/pricing-500gb-craft.md`
- **No GitHub issue** (`NEW-0`).

## Problem / goal
The pricing masthead shows **500 GB** as a single static Signal string. It does not sell capacity the way the home hero proof does after #104. Make the first viewport capacity moment visually louder and more intentional while staying civic dark / anti-slop.

## Scope (only)
1. `src/views/Pricing.astro` masthead `.pricing-hero-stat` (markup + styles)
2. i18n keys under `pricing.heroPrice` in `es` / `ca` / `en` / `de` if splitting capacity / unit / optional meta
3. Optional thin reuse of `src/scripts/hero-capacity.ts` patterns or a pricing-local once-only script + tokens already in `src/styles/tokens.css`
4. Brief already at `docs/design/pricing-500gb-craft.md` (update only if direction locks change)

## Out of scope
- Full pricing page remodel, compare table redesign, path-card layout rewrite
- Changing the public price (€1.99) or storage amount (500 GB)
- Fake metrics, testimonials, or new pricing tiers

## Implementation (coder)
- Split `heroPrice` into `capacity` / `unit` / `hostMeta` (removed flat `meta`) in es/ca/en/de + types.
- Masthead: display **500** + Signal **GB**, abundance meter (`--hero-meter-fill` 0.72), quiet Hetzner meta, price secondary.
- Extended `hero-capacity.ts` for `[data-pricing-capacity]` on `.pricing-hero-stat` reveal; once-only count-up; reduced-motion finals.
- Site version **1.1.134**. Deployed via `docker compose build && up -d`.

## Acceptance (hard)
- [ ] `/pricing/` first viewport: capacity reads louder than today’s flat “500 GB” label
- [ ] Number/unit hierarchy (or equivalent craft) + honest abundance cue
- [ ] Motion once only; reduced-motion shows final state immediately
- [ ] No purple/glow/Inter-only/fake usage %; no soft class-only pass
- [ ] All four locales render; price + aria remain honest (€1.99 / 500 GB)

## Testing instructions

### Hard gate protocol (required)
| Item | Value |
|------|-------|
| Reference | https://km0digital.com/en/ (hero 500 GB proof) |
| KM0 URL | http://127.0.0.1:9180/en/pricing/ and http://127.0.0.1:9180/pricing/ |
| Decisive viewport | Pricing masthead `.pricing-hero-stat` on first reveal (lg+ preferred) |
| Footer | Version **1.1.134** |

**Parity claims (tester must narrate side-by-side vs home hero proof):**
1. Capacity digits + unit hierarchy is readable as the capacity story (not a flat label), peer to home proof’s **500** / **GB** split.
2. Abundance meter settles at a roomy mid/high band (same honesty as home: plan size, not fake “28% used”).
3. Once-only entrance (count-up + meter fill + opacity settle within ~480ms) syncs to reveal the way home capacity does.

**Anti-slop claims (tester must confirm):**
1. No purple / glow / neon / bouncing digits on the capacity block.
2. No Inter-only / centered SaaS dual-pill recipe; left column (eyebrow, H1, intro, Cloud CTA) stays intact.
3. No fake usage % or vanity stats; aria-label still states €1.99 / month / 500 GB honestly.

**Reduced motion:** with `prefers-reduced-motion: reduce`, **500** and meter final state appear immediately (no count-up / no fill animation).

### Smoke
```bash
curl -sI http://127.0.0.1:9180/pricing/ http://127.0.0.1:9180/en/pricing/ http://127.0.0.1:9180/ca/pricing/ http://127.0.0.1:9180/de/pricing/
# expect 200
curl -s http://127.0.0.1:9180/en/pricing/ | grep -E 'data-pricing-capacity|pricing-hero-meter|Version.*1\.1\.134'
./scripts/check-no-em-dash.sh && ./scripts/check-no-mailto.sh
```

Coder smoke (2026-07-18): all four locale pricing URLs **200**; HTML has `data-pricing-capacity data-target="500"`, meter, Hetzner meta, footer **1.1.134**.

## References
- docs/design/pricing-500gb-craft.md
- docs/design/hero-500gb-motion.md
- docs/design/craft-parity-phase.md
- docs/design/anti-slop-doctrine.md
- docs/brand-tokens.md
- docs/runbook.md

## Test report

1. **Date/time (UTC) and log window:** Start `2026-07-18T07:20:51Z`, end `2026-07-18T07:23:25Z`. Docker access log window matches (HEAD/GET pricing locales + Playwright GETs).
2. **Environment:** Branch `main` @ `006ff91`, container `km0-web` healthy on `127.0.0.1:9180` (`docker compose ps`), site version **1.1.134**. Build method: existing Docker deploy (coder already up). Production `https://km0digital.com/` polled to **200** with same markers (ready confirmed by HTTP 200 + footer Version 1.1.134 + `data-pricing-capacity` present, not by sleep).
3. **What was tested:** Hard gate vs home hero capacity proof; Playwright lg viewport (1280×800) motion + reduced-motion; four-locale smoke; aria honesty; anti-slop visual read of masthead screenshots; em-dash/mailto checks; docker logs.
4. **Results:**

### Hard gate protocol
| Field | Value |
|-------|-------|
| Reference | http://127.0.0.1:9180/en/ (and production home craft peer) hero proof `.hero__proof-plan` |
| KM0 URL | http://127.0.0.1:9180/en/pricing/ , http://127.0.0.1:9180/pricing/ ; prod https://km0digital.com/en/pricing/ |
| Decisive viewport | Pricing masthead `.pricing-hero-stat` at first reveal (lg 1280×800 screenshots) |
| Footer | Version **1.1.134** (loopback all locales + prod) |

**Parity claims (side-by-side home proof vs pricing masthead):**
1. **PASS** - Digits + unit hierarchy: pricing shows display **500** (100px Bricolage ink) + Signal **GB** (28px teal); home proof same split (**500** ink + **GB** Signal). Not a flat “500 GB” label.
2. **PASS** - Abundance meter settles mid/high via `--hero-meter-fill: .72` on both surfaces; fill `rgb(45, 212, 191)` Signal; no fake “28% used” copy. Host meta **Hetzner · Falkenstein** on both.
3. **PASS** - Once-only entrance: Playwright sampled count-up ramp `144→327→…→500` with `data-settled=true` within ~480ms token; meter fill animates to `scaleX(1)` on `.is-visible`. Syncs to reveal the same way home capacity does.

**Anti-slop claims:**
1. **PASS** - Screenshot + computed styles: civic dark, Signal teal only (`rgb(45,212,191)`); no purple/glow/neon/bouncing digits on the capacity block.
2. **PASS** - Left column intact: eyebrow “PRICING”, H1 “One public price.”, intro, single Cloud CTA (`ctaCount: 1`). Fonts Bricolage + Source Serif + IBM Plex (not Inter-only dual-pill SaaS).
3. **PASS** - No fake usage % in HTML (all locales). Aria honest: EN “Price: €1.99 per month for 500 GB of storage”; ES/CA/DE equivalent with 1,99 € / 500 GB.

**Acceptance criteria:**
- Capacity louder than flat label: **PASS** (100px vs muted €1.99 at 22px secondary)
- Number/unit + abundance cue: **PASS**
- Motion once only; reduced-motion finals immediate: **PASS** (reduced: early text `500`, `data-settled=true`, opacity 1; motion saw ramp)
- No purple/glow/Inter-only/fake %; not class-only: **PASS** (Playwright + screenshots)
- Four locales; price + aria honest: **PASS** (es/ca/en/de **200**, capacity 500, meter present)

**Smoke:**
- `/pricing/` `/en/pricing/` `/ca/pricing/` `/de/pricing/` → **200** **PASS**
- Markers `data-pricing-capacity`, `pricing-hero-meter`, Version 1.1.134 → **PASS**
- `check-no-em-dash` / `check-no-mailto` → **PASS**
- Production `/en/pricing/` → **200**, `data-pricing-capacity`, Version 1.1.134 → **PASS**

5. **Overall: PASS**
6. **URLs tested:** http://127.0.0.1:9180/ , /ca/, /en/, /de/, /pricing/, /en/pricing/, /ca/pricing/, /de/pricing/; https://km0digital.com/ , https://km0digital.com/en/pricing/
7. **Log excerpts (km0-web, UTC window):**
```
HEAD /pricing/ /en/pricing/ /ca/pricing/ /de/pricing/ → 200
GET /en/pricing/ → 200 (curl + HeadlessChrome)
GET https://km0digital.com/en/pricing/ via proxy → 200
container STATUS: Up (healthy) 127.0.0.1:9180->80/tcp
```

**GitHub:** NEW-0 (no issue). Labels N/A.

