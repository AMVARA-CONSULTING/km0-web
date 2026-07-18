---
## Closing summary (TOP)

- **What happened:** Home `#cloud-users` Ink band was misaligned and the live count read bland next to the Cloud CTA.
- **What was done:** Rebuilt band hierarchy (stacked loud digits + secondary label), aligned count/CTA rhythm for desktop and mobile, and added once-only count-up via shared hero-capacity motion (reduced-motion safe). Version `1.1.142`.
- **What was tested:** Hard gate PASS vs pricing/hero 500 GB (parity + anti-slop); live API count; lg 1280 and mobile 390; EN locale; Docker build and locale HTTP 200.
- **Why closed:** All acceptance criteria and Hard gate protocol passed; no soft-evidence archive block.
- **Closed at (UTC):** 2026-07-18 08:27
---

# CLOSED-Task: Cloud registered-users band craft (align + loud count)

## Origin
- **Source:** Direct operator request (skip GitHub).
- **No GitHub issue** (`NEW-0`).
- **Sacred lock:** live Cloud user counter must stay; never invent or hardcode a fake number (`docs/design/remodel-epic.md`, anti-slop doctrine).

## Problem / goal
The home **Usuarios registrados / Registered cloud users** Ink band (`#cloud-users`, `CloudUserStats.astro` variant `band`) is **misaligned** and the **count looks bland** (“soso”). Rebuild the composition so the live number is a clear proof moment (peer energy to the 500 GB / pricing capacity craft) and the row lines up cleanly with the Cloud CTA on desktop and mobile.

## Current surface (coder starts here)
- Component: `src/components/CloudUserStats.astro` (`variant="band"` → `.cloud-proof`)
- Layout today: flex row, count + uppercase label on one baseline line, CTA `space-between`
- Count style: display face, Signal-hover color, clamp ~2.75–4.25rem, but reads flat; label capped at `max-width: 12rem` which often wraps awkwardly next to the digits
- Data: `fetchCloudUserCount()` from `src/lib/cloud-users` (keep)

## Locked requirements
| Rule | Detail |
|------|--------|
| Keep | Live count from API; `aria-live` / `countAria`; unavailable state |
| Keep | Ink earned band (`surface-ink`); Cloud primary CTA to `cloud.km0digital.com` |
| Keep | Section id `#cloud-users` (anchors / sacred counter) |
| Do not | Fake stats, vanity “10K+”, purple glow, equal icon-stat tiles |
| Do not | Remove the counter or hide it behind a soft decorative strip |

## Scope (only)
1. `src/components/CloudUserStats.astro` styles (+ markup if needed for hierarchy) for **`band`** variant used on the landing.
2. Optional thin motion: once-only count settle or opacity/transform when revealed (reuse hero/pricing capacity tokens if they fit; honor `prefers-reduced-motion`).
3. i18n only if label hierarchy needs a split (e.g. short kicker vs full label). Prefer keeping existing `cloudUsers.*` keys if layout alone fixes it.
4. `variant="section"` may get the same count typography for consistency, but **home band alignment is the acceptance target**.
5. Build; bump; Hard gate Testing instructions; `UNTESTED-`.

## Out of scope
- Changing `fetchCloudUserCount` backend / auth
- Inventing growth charts, avatars, or testimonial strips
- Full landing remodel; Offer sticky; hero QR

## Craft direction (must achieve)
1. **Alignment:** Desktop: count block and Cloud CTA share one clear horizontal rhythm (optical vertical center or shared baseline grid). Mobile: stacked order is deliberate (count first, CTA second), not a ragged wrap. Label must not collide with digits or look like a leftover caption.
2. **Loud number:** Count is the hero of the band (display scale / weight / Signal hierarchy). Label is secondary. Optional once-only entrance so the number is felt, not a muted flex item.
3. **Still Ink proof:** continuous Paper page → intentional Ink band → back; no zebra return.

## Acceptance (hard)
- [x] `#cloud-users` on `/` and `/en/`: number reads loud; label and CTA no longer look “dealigned”
- [x] Live count still real (API ok path); unavailable path still sane
- [x] Desktop + mobile both intentional (tester narrates both)
- [x] No fake metrics; no purple/glow; reduced-motion safe if motion added
- [x] Version bumped; build green; locales 200

## What changed (coder)
- **Markup:** Count stacked above label (`.cloud-proof__stack`); no side-by-side baseline wrap. CTA stays peer on desktop (`align-items: center`); mobile column count → CTA.
- **Loud digits:** Display clamp ~3.5–5.75rem, weight 800, Signal-hover; label secondary under digits (`max-width: 18rem`).
- **Motion:** Once-only count-up + opacity settle via shared `hero-capacity.ts` (`[data-cloud-user-count]`); `--duration-hero-capacity` + expo; `prefers-reduced-motion` shows finals immediately.
- **Section variant:** Matching loud digit typography + Signal-hover (consistency).
- **i18n:** Unchanged (`cloudUsers.*` keys kept).
- **Version:** `1.1.141` → `1.1.142`.

## Testing instructions

### Hard gate protocol (required)
| Item | Value |
|------|-------|
| Reference | Home hero **500 GB** proof (`/#home` capacity readout) and/or `/pricing/` masthead capacity |
| KM0 URL | http://127.0.0.1:9180/#cloud-users , http://127.0.0.1:9180/en/#cloud-users |
| Decisive viewport | Ink band: count + label + Cloud CTA at `lg` (~1280) and at ~390px width |

**3 parity claims (tester must narrate side-by-side with reference):**
1. Digits are the band’s visual hero at a scale peer to pricing/hero capacity energy (not a muted flex caption).
2. Desktop: count stack and Cloud CTA share one clean horizontal rhythm (optical vertical center); mobile: deliberate stack (count first, CTA second), no ragged wrap.
3. Still reads as live community proof (real API number, e.g. 29 at ship time), not a vanity marketing strip.

**3 anti-slop claims:**
1. No fake “10K+” / invented growth strip.
2. No purple/glow/orb decoration on the Ink band.
3. No equal three-stat icon-tile row.

### Smoke (coder evidence 2026-07-18)
```bash
curl -sI http://127.0.0.1:9180/          # HTTP/1.1 200 OK
curl -sI http://127.0.0.1:9180/en/       # HTTP/1.1 200 OK
curl -s http://127.0.0.1:9180/ | grep -E 'id="cloud-users"|cloud-proof__count|data-cloud-user-count|cloud-proof__stack'
# → aside#cloud-users, .cloud-proof__stack, data-cloud-user-count data-target="29", live "29"
curl -s http://127.0.0.1:9180/ | grep -o 'Versión [0-9.]*'
# → Versión 1.1.142
./scripts/check-no-em-dash.sh            # OK
./scripts/check-no-mailto.sh             # OK
docker compose build && docker compose up -d   # green; nginx started
```

### Tester checklist
1. Open `/#cloud-users` beside hero 500 GB or `/pricing/` capacity; claim loud digit + alignment parity (Hard gate above).
2. Resize to ~390px: count first, CTA second, label under digits (not colliding).
3. Confirm live number (not hardcoded); scroll-reveal count-up once; with reduced motion, finals immediate.
4. Spot-check `/en/#cloud-users` label + CTA.
5. Soft class-only / curl-200 alone = **FAIL**.

## References
- src/components/CloudUserStats.astro
- src/scripts/hero-capacity.ts
- src/lib/cloud-users.ts
- docs/design/remodel-epic.md (sacred user counter)
- docs/design/anti-slop-doctrine.md
- docs/brand-tokens.md (display type, Signal, motion)
- docs/design/hero-500gb-motion.md / pricing-500gb-craft.md (loud capacity peer, not copy-paste)

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-18 08:24:30 UTC; end 2026-07-18 08:27:15 UTC. Docker/nginx log window `2026-07-18T08:24:00Z` onward (build start through Playwright probes).
2. **Environment:** Branch `main` (synced). Build via `docker compose build && docker compose up -d` (host has no npm). Container `km0-web` healthy on `127.0.0.1:9180`. Footer **Versión / Version 1.1.142**. No GitHub issue (`NEW-0`); labels N/A.
3. **What was tested:** Hard gate side-by-side vs `/pricing/` 500 GB capacity + home hero capacity; `#cloud-users` band craft at lg 1280 and mobile 390; live API count + count-up + reduced-motion; EN locale; HTTP smoke locales/doc/pricing; anti-slop on Ink band. Playwright Chromium (docker `mcr.microsoft.com/playwright:v1.49.0-jammy`) for decisive viewports; screenshots `/tmp/cloud-users-es-lg.png`, `es-mobile`, `en-lg`, `/tmp/pricing-capacity-lg.png`.

### Hard gate protocol

| Item | Value |
|------|-------|
| Reference | http://127.0.0.1:9180/pricing/ masthead capacity (`500` / `GB`, computed 100px / weight 700) + home `[data-hero-capacity]` |
| KM0 URL | http://127.0.0.1:9180/#cloud-users , http://127.0.0.1:9180/en/#cloud-users |
| Decisive viewport | Ink band screenshots + geometry at 1280×800 and 390×844 |

**3 parity claims (side-by-side):**
1. **PASS - Loud digits:** Band count renders ~92px / weight 800 / Signal-hover teal `rgb(94, 234, 212)` at lg; pricing peer is 100px / 700. Non-dev sees the same “big proof number” energy as 500 GB, not a muted caption. Settled text `29`.
2. **PASS - Alignment:** Desktop: `.cloud-proof__inner` `flex-direction:row` + `align-items:center`; stack mid Y 409 vs CTA mid Y 424 (~15px optical center); count stack left, CTA right (`Abrir Cloud` / `Open Cloud`). Mobile 390: `flex-direction:column`; order count → label under digits → CTA; `countAboveLabel=true`; no ragged wrap.
3. **PASS - Live proof:** SSR `data-target="29"`; mid-animation texts 27/28 then settled `29` + `data-settled=true`; CTA `https://cloud.km0digital.com`. Reads as real community count, not vanity strip.

**3 anti-slop claims:**
1. **PASS:** No “10K+” / invented growth; sole metric is live API `29`.
2. **PASS:** Band bg `rgb(5, 8, 15)`, `box-shadow: none`, Signal teal accents; no purple/indigo/glow/orb in band markup or computed styles.
3. **PASS:** Single count + CTA row; no equal three-stat icon-tile grid.

4. **Results (acceptance):**
| Criterion | Result | Evidence |
|-----------|--------|----------|
| Loud number + alignment on `/` and `/en/` | **PASS** | Screenshots + geometry above; EN label “Registered cloud users”, CTA “Open Cloud” |
| Live count real; unavailable path sane | **PASS** | `data-target=29` + settle; unavailable markup retained in component (ok-path exercised) |
| Desktop + mobile intentional | **PASS** | lg row rhythm; 390 column stack |
| No fake metrics / no purple-glow / RM safe | **PASS** | Anti-slop claims; RM: JS writes finals immediately (`settled=true`, text `29`, opacity 1) via `prefers-reduced-motion` branch in bundled `hero-capacity` |
| Version bump; build green; locales 200 | **PASS** | 1.1.142; docker build green (em-dash/mailto OK); `/` `/ca/` `/en/` `/de/` `/doc/` `/en/doc/day-0/` `/pricing/` → 200 |
| Soft class-only alone | **N/A (avoided)** | Hard gate used Playwright viewports + screenshots |

5. **Overall: PASS**
6. **URLs tested:** http://127.0.0.1:9180/ , `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`, `/pricing/`, `/en/pricing/`, `/#cloud-users`, `/en/#cloud-users`; https://km0digital.com/ → HTTP/2 200 (smoke; loopback is deploy-under-test).
7. **Log excerpts:**
```
nginx started 08:24:44; health=healthy
GET / HTTP/1.1 200 (Playwright + curl)
GET /en/ HTTP/1.1 200
GET /pricing/ HTTP/1.1 200
km0-web@1.1.142 build Complete! (132 pages)
```
