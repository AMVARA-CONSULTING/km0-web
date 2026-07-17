---
## Closing summary (TOP)

- **What happened:** KM0 got a restrained Origin-field atmosphere motif (grid + grain + optional biased cross), not zebra/orbs/purple glow.
- **What was done:** Added `--km0-motif-*` tokens and `.km0-motif` / `.km0-motif--origin`; applied on Hero (origin), Why, Contact; documented in brand-tokens and doctrine.
- **What was tested:** Tester PASS - class placement; static motif CSS; reduced-motion safe; docs mention Origin field; em-dash OK.
- **Why closed:** All acceptance criteria and test report PASS; motif distinct from glow/orb slop.
- **Closed at (UTC):** 2026-07-17 20:57
---
# FEAT-Task: KM0 signature atmosphere

## GitHub Issue
- **Number:** #84
- **Title:** KM0 signature atmosphere
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/84
- **Labels:** agent:untested

## Problem / goal
Need KM0 atmosphere with soul: not zebra, not orbs, not purple. Nous has imprint; we need our own quiet motif.

## Depends on
#80; coordinates with #81 mark language.

## High-level instructions for coder
1. Propose one signature motif (paper grain / quiet grid / signal geometry) - CSS variables + 1–2 classes.
2. Apply sparingly (hero + ≤2 bands). `prefers-reduced-motion` safe.
3. Document in brand-tokens + doctrine (ban glow-as-brand).
4. Build; bump; gh #84.

## Acceptance
- Motif reusable and restrained
- Distinct from POS orbs and AI gradients

## Implementation summary
- **Motif:** Origin field - quiet civic grid + paper grain + optional biased kilometer-zero cross/diamond (Signal ink only; no soft orbs).
- **Tokens:** `--km0-motif-*` in `src/styles/tokens.css`.
- **Classes:** `.km0-motif` and `.km0-motif--origin` in `src/styles/global.css`.
- **Applied:** Hero (grid + origin), Why (grid), Contact snow band (grid). Static (no motif animation).
- **Docs:** `docs/brand-tokens.md`, `docs/design/anti-slop-doctrine.md` (glow/orb ban), skill `km0-anti-slop-design`.
- **Version:** `1.1.112` via `./scripts/bump-patch-version.sh`.

## Testing instructions

1. `docker compose ps` - `km0-web` healthy; footer shows **1.1.112**.
2. `curl -sI http://127.0.0.1:9180/` and `/ca/`, `/en/`, `/de/`, `/doc/` - expect **200**.
3. Home HTML: `#home` has `km0-motif km0-motif--origin`; `#why` and `#contact` have `km0-motif` only (no origin on every band).
   ```bash
   docker exec km0-web sh -c 'grep -oE "id=\"(home|why|contact)\"[^>]*class=\"[^\"]+\"" /usr/share/nginx/html/index.html'
   ```
4. Visual: hero shows quiet grid + faint biased cross/diamond (upper-right); Why/Contact show grid+grain only. No purple glow, no POS-style orbs, no soft radial blob as the motif.
5. `prefers-reduced-motion: reduce` - motif stays (static); no new motion regressions on hero meter / reveals.
6. Spot-check docs mention Origin field: `docs/brand-tokens.md` section **Signature atmosphere**; doctrine hard ban #7 references glow/orbs vs Origin field.
7. `./scripts/check-no-em-dash.sh` - OK.

## References
- Runbook: docs/runbook.md
- Study: docs/design/reference-study-stirling-satisfecho-nous.md
- Doctrine: docs/design/anti-slop-doctrine.md
- Tokens: docs/brand-tokens.md
- Site: https://km0digital.com

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-17 20:56:49 UTC; end ~20:57:05 UTC.
2. **Environment:** Branch `main`. `km0-web` healthy at `http://127.0.0.1:9180/`. Production `https://km0digital.com/` HTTP/2 200 with matching motif classes (immediate 200).
3. **What was tested:** Testing instructions 1-7 for KM0 signature atmosphere (#84).
4. **Results:**
   - Docker + footer: **PASS** - healthy; **Versión 1.1.113** (>= task 1.1.112).
   - HTTP locales: **PASS** - `/` `/ca/` `/en/` `/de/` `/doc/` → 200.
   - Motif class placement: **PASS** - `#home` = `km0-motif km0-motif--origin`; `#why` and `#contact` = `km0-motif` only (docker exec + production HTML).
   - Motif visual (CSS): **PASS** - grid + grain via `--km0-motif-*`; origin cross/diamond via `.km0-motif--origin::before`; no radial-gradient/blur/purple in motif rules; comment documents static / no glow orbs.
   - prefers-reduced-motion: **PASS** - motif has no animation; global reduced-motion kill-switch present; motif remains static backgrounds.
   - Docs: **PASS** - `docs/brand-tokens.md` **Signature atmosphere: Origin field**; doctrine hard ban #7 references Origin field vs glow/orbs.
   - Em dash: **PASS** - `./scripts/check-no-em-dash.sh` OK.
   - GitHub label `agent:testing` on issue #84: **PASS**.
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`; `https://km0digital.com/`.
7. **Log excerpts:** prior container nginx healthy; home GETs 200 in shared smoke window.
8. **GitHub:** label `agent:testing` applied on issue #84 at test start.

