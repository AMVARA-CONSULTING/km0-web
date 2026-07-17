---
## Closing summary (TOP)

- **What happened:** Site still had zebra-style alternating section bands; needed Stirling-class continuous surfaces.
- **What was done:** Added surface tokens/utilities, removed presentation zebra leftovers, opted sections into intentional Paper/Snow/Ink bands only; docs updated; version bumped.
- **What was tested:** Tester PASS - zero nth-child zebra in source and built CSS, surface utilities on Contact/Pricing/Presentation/Footer, HTTP smoke, anti-slop fonts/colors OK.
- **Why closed:** All acceptance criteria passed.
- **Closed at (UTC):** 2026-07-17 23:09
---

# FEAT-Task: Stirling professional surfaces - kill zebra forever

## GitHub Issue
- **Number:** #91
- **Title:** Stirling professional surfaces - kill zebra forever
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/91
- **Labels:** agent:untested

## Problem / goal
Repaint surfaces site-wide in a Stirling-class professional style: continuous canvas, intentional bands only, **no zebra**. Spec: `docs/design/stirling-paint-phase.md`.

## High-level instructions for coder
1. Read stirling-paint-phase + anti-slop + brand tokens.
2. Audit CSS/components for alternating backgrounds; remove any zebra leftovers.
3. Add explicit surface utilities/tokens; sections opt in (never nth-child).
4. Unify professional spacing/type rhythm on home + shared shells.
5. Keep Signal/Ink/Paper; do not copy Stirling’s Framer palette.
6. Build; bump; gh #91; UNTESTED.

## Acceptance
- Zero mechanical zebra
- Coherent professional surfaces
- Build green

## Implementation notes (coder)
- Tokens: `--surface-paper|snow|ink`, `--space-section-y|x` in `src/styles/tokens.css`.
- Utilities: `.surface-paper`, `.surface-snow`, `.surface-ink`, `.surface-band` in `src/styles/global.css`; `.section-pad` uses space tokens; slightly calmer `.heading-section`.
- Killed Presentation zebra: removed `presentation-section-alt` on 4 sections; only compare keeps `surface-snow surface-band`.
- Pricing: compare keeps one Snow band; ops no longer Snow (was every-other stripe via `page-band`).
- Contact → `surface-snow`; Footer → `surface-paper`; Ideas form → `surface-snow`; CloudUserStats section variant → `surface-ink`.
- Docs: `docs/brand-tokens.md` Surfaces + `docs/design/stirling-paint-phase.md` utilities table.
- Version: `1.1.118` → `1.1.119`.

## Testing instructions
1. **No mechanical zebra in source:** `grep -E 'nth-child\((odd|even)' src/styles/` → zero matches (comments mentioning nth-child are fine). Confirm `presentation-section-alt` is gone from `src/views/Presentation.astro`.
2. **No zebra in built CSS:** `docker exec km0-web sh -c 'grep -E "nth-child\((odd|even)" /usr/share/nginx/html/_astro/*.css && echo HAS || echo ZERO_NTH_CHILD'` → `ZERO_NTH_CHILD`.
3. **Surface utilities present:** Home Contact uses `surface-snow`; Pricing compare uses `surface-snow surface-band` and ops does **not**; Presentation only compare uses `surface-snow` (other body sections inherit Paper).
4. **Continuous Paper rhythm:** Visual smoke `/`, `/pricing/`, `/presentation/` - no every-other white/gray stripes. Intentional Snow bands: Contact (home), Why middle scale band, Pricing compare, Presentation compare.
5. **HTTP smoke:** `curl -sI` → 200 for `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/presentation/`, `/meeting/`, `/ideas/`.
6. **Footer version:** `1.1.119` on `/`.
7. **Anti-slop:** Ink/Paper/Signal only; no purple gradients; no Inter-only; no `mailto:`.
8. **Logs:** `docker logs --since 10m km0-web` - nginx clean after smoke.

## References
- docs/design/stirling-paint-phase.md
- https://stirling.com/
- docs/design/anti-slop-doctrine.md
- docs/brand-tokens.md
- Runbook: docs/runbook.md

## Test report

1. **Date/time (UTC):** start 2026-07-17T23:05:04Z; evidence ~23:05:04Z–23:05:08Z; end 2026-07-17T23:05:34Z.
2. **Environment:** branch `main`; deploy already up from prior tester build (`docker compose`, image with Astro 124 pages); loopback `http://127.0.0.1:9180/`; footer **1.1.122** (≥ 1.1.119).
3. **What was tested:** Source + built CSS zebra ban; surface utilities on Contact/Pricing/Presentation/Footer; HTTP smoke; anti-slop fonts/colors; mailto/em-dash; nginx logs.
4. **Results:**
   - No mechanical zebra in `src/styles/` → **PASS** (`grep -E 'nth-child\((odd|even)'` → zero).
   - `presentation-section-alt` gone → **PASS** (absent from `Presentation.astro` and HTML).
   - Built CSS ZERO_NTH_CHILD → **PASS** (`docker exec … grep nth-child(odd|even)` → `ZERO_NTH_CHILD`).
   - Surface utilities → **PASS** (tokens `--surface-paper|snow|ink`, `.surface-*` in global.css; Contact `surface-snow surface-band`; Footer `surface-paper`; Pricing compare + closer Snow, ops section plain `pricing-section` without Snow; Presentation only compare + closer Snow).
   - Continuous Paper rhythm → **PASS** (intentional Snow: Contact, Why `.why-band--emphasis` via `--surface-snow`, Pricing/Presentation compare; Ink proof band on home).
   - HTTP smoke → **PASS** (200 for `/` `/ca/` `/en/` `/de/` `/doc/` `/pricing/` `/presentation/` `/meeting/` `/ideas/`).
   - Footer ≥ 1.1.119 → **PASS** (1.1.122).
   - Anti-slop → **PASS** (no purple in CSS; display Bricolage + IBM Plex + Source Serif; mailto/em-dash OK). False-positive "Inter" hits were `IntersectionObserver` JS, not Inter font.
5. **Overall: PASS**
6. **URLs:** loopback paths above; production not re-deployed this step (prior poll 200).
7. **Logs:** nginx 200s on smoke GETs at 23:05:06; no 5xx in window.
