---
## Closing summary (TOP)

- **What happened:** Primary button labels used font-medium and under-read as actions.
- **What was done:** Changed shared .btn-primary from font-medium to font-bold (700) in global.css.
- **What was tested:** Hard gate PASS: computed fontWeight 700 on hero and pricing primaries; Signal fill/shape unchanged; no purple/pill churn.
- **Why closed:** All acceptance and Hard gate criteria passed.
- **Closed at (UTC):** 2026-07-19 00:18
---

# FEAT-Task: Primary buttons - bold CTA label weight

## GitHub Issue
- **Number:** #112
- **Title:** Primary buttons: bold CTA label weight
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/112
- **Labels:** agent:wip (→ agent:untested after handoff)

## Origin
- **Source:** Direct operator request + GitHub #112.
- **Brief:** Labels like "Abrir …" on primary buttons should be bold. Craft check agrees: current weight is too soft.

## Problem / goal
`.btn-primary` in `src/styles/global.css` uses `font-medium` (500) with `font-sans text-sm` on Signal fill. Short CTAs ("Abrir KM0 Cloud", "Abrir Cloud", locale equivalents) under-read as actions. Bump the shared primary button type weight so labels feel decisive without redesigning the control.

## Locked decisions
1. Change **only** the shared `.btn-primary` weight in `global.css` (no per-instance Tailwind overrides).
2. Target weight: **`font-bold` (700)**. If Hard gate eye-test finds IBM Plex Sans at `text-sm` too heavy/shouty on Signal, fall back to `font-semibold` (600) and document why in Testing instructions. Do not stay on `font-medium`.
3. Keep shape, padding, Signal colors, and `text-white` as they are (no pill/`rounded-full` churn, no purple).
4. Secondary links (`hero__link`, text links, register secondaries) stay as they are; this FEAT is primary buttons only.
5. Independent of #110 (fewer Cloud CTAs) and #111 (footer Signal rule); may land before or after those.

## Scope
1. `src/styles/global.css` - `.btn-primary` (`font-medium` → `font-bold`, or `font-semibold` with documented Hard gate reason).
2. Eye-test on home hero CTA + one secondary page primary (e.g. pricing).
3. `./scripts/bump-patch-version.sh` once; `npm run build`; Testing instructions; `UNTESTED-`.

## Out of scope
- CTA copy / i18n string changes
- Reducing how many Open Cloud buttons appear (#110)
- Footer top border color (#111)
- New button component or secondary button system

## Acceptance (hard)
- [x] `.btn-primary` no longer uses `font-medium`
- [x] Primary CTA labels read clearly bolder than surrounding body/UI medium text
- [x] Same weight on all primary buttons (shared class)
- [x] No em dash; no mailto; site version bumped
- [x] Hard gate eye-test (below); soft class-only alone = fail

## High-level instructions for coder
- Read issue #112; confirm current rule in `global.css` (~`.btn-primary` with `font-medium`).
- One-line class change preferred; skills `km0-anti-slop-design` only for weight judgment.
- Do not invent a second `.btn-primary--bold` class.
- Deploy verification per `docs/runbook.md`.

## Implementation notes (coder)
- One-line change in `src/styles/global.css`: `.btn-primary` `font-medium` → `font-bold`.
- Hard gate eye-test kept **700** (not semibold): IBM Plex Sans at `text-sm` on Signal fill reads decisive, not shouty, on hero "Abrir KM0 Cloud" and pricing "Open KM0 Cloud".
- Site version: **1.2.4 → 1.2.5** via `./scripts/bump-patch-version.sh`.
- Build/deploy: `docker compose build && docker compose up -d` (host has no local `npm`).

## Testing instructions

### Deploy / smoke
1. Confirm container healthy on `http://127.0.0.1:9180/`.
2. `curl -sI` → **200** for `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/pricing/`.
3. Footer shows **Versión / Version 1.2.5** (or later if stacked bumps).
4. `./scripts/check-no-em-dash.sh` and `./scripts/check-no-mailto.sh` OK (also green in image `prebuild`).
5. Built CSS: `.btn-primary{…;font-weight:700;…}` in `/_astro/index.*.css` (no `font-weight:500` on that rule).

### Hard gate protocol
| Item | Value |
|------|-------|
| Reference | Prior `.btn-primary` with `font-medium` (500); soft CTA labels |
| KM0 URL | http://127.0.0.1:9180/ and http://127.0.0.1:9180/en/pricing/ |
| Decisive viewport | Hero primary CTA (first viewport, ES) + pricing primary (EN) |
| Evidence | `autoagents/.runtime/btn-bold-112/` (`01-hero-cta.png`, `02-pricing-cta.png`, `report.json`) |

**Parity claims:**
1. **Weight:** Playwright computed `fontWeight: "700"` on hero "Abrir KM0 Cloud" and pricing "Open KM0 Cloud"; labels read bold vs surrounding medium UI, not soft 500.
2. **Sitewide:** Both use shared class `btn-primary` only (no per-instance weight override); same 700 on home and pricing.
3. **Still Signal primary:** Solid Signal fill + white text + `border-radius: 6px` (`rounded-md`); only type weight changed. Hover/focus rules untouched in CSS.

**Anti-slop claims:**
1. No purple / gradient button fill (solid Signal teal/cyan fill only).
2. No `rounded-full` pill conversion (`border-radius: 6px`).
3. No copy rewrite; CTA strings unchanged (weight-only fix).

### Tester checklist
- [ ] Open `/` and `/en/pricing/`; confirm primary CTA labels look bold (700), not medium.
- [ ] Confirm secondary hero link ("Ver precios" / equivalent) is still not bold primary styling.
- [ ] Hard gate fields above match live deploy (parity + anti-slop + decisive viewport).
- [ ] Footer version ≥ 1.2.5; locales HTTP 200; no em dash / mailto regressions.
- [ ] `docker logs --since 10m km0-web` shows no 5xx for tested paths.

## References
- Issue: https://github.com/AMVARA-CONSULTING/km0-web/issues/112
- `src/styles/global.css` (`.btn-primary`)
- `docs/brand-tokens.md` (IBM Plex Sans UI)
- docs/runbook.md

## Test report

1. **Date/time (UTC) and log window:** Start `2026-07-19T00:14:37Z`, end `2026-07-19T00:14:41Z`. `docker logs --since 2026-07-19T00:14:37Z km0-web`.
2. **Environment:** Branch `main`, `http://127.0.0.1:9180` (footer **1.2.6** ≥ 1.2.5). Playwright → `autoagents/.runtime/tester-112/`. Production previously confirmed **200** / Versión 1.2.6.
3. **What was tested:** `.btn-primary` computed weight on hero + pricing; secondary link not bold-primary; built CSS rule; hard gate; locales HTTP; em-dash/mailto.
4. **Results:**
   - Weight 700 not medium: **PASS** - Playwright `fontWeight: "700"` on hero "Abrir KM0 Cloud" and pricing "Open KM0 Cloud"; CSS `.btn-primary{…font-weight:700…}` in `/_astro/index.D6Wp1yIj.css` (no 500 on that rule).
   - Shared class sitewide: **PASS** - both use `className: "btn-primary"` only.
   - Still Signal primary shape: **PASS** - `backgroundColor: rgb(45, 212, 191)`, `borderRadius: 6px` (not pill).
   - Secondary not bold primary: **PASS** - hero "Ver precios" `hero__link` weight **500**.
   - Locales / version / checks: **PASS** - `/` `/ca/` `/en/` `/de/` `/doc/` `/en/pricing/` → 200; Versión 1.2.6; em-dash/mailto OK.
   - Hard gate parity (3) + anti-slop (3): **PASS** - decisive viewports `01-hero-cta.png`, `02-pricing-cta.png`; no purple/gradient fill; no rounded-full; weight-only (copy unchanged).
5. **Overall: PASS**
6. **URLs:** `http://127.0.0.1:9180/` `/en/pricing/` + locale smoke.
7. **Logs:** GET `/` and `/en/pricing/` **200** in window; no 5xx for tested paths.

