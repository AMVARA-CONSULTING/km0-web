---
## Closing summary (TOP)

- **What happened:** Weak teal map-pin mark system was replaced with a Signal/Paper origin-stamp across logo, favicon, apple-touch, and OG.
- **What was done:** New stamp assets under `public/brand/` + favicon/apple-touch; Layout links wired; brand-tokens docs updated; version bumped with phase-2 work.
- **What was tested:** Tester PASS - assets 200; full-bleed favicon; no purple/gradient/pin; OG Paper+Signal; locales render mark.
- **Why closed:** All acceptance criteria and test report PASS; anti-slop mark check clean.
- **Closed at (UTC):** 2026-07-17 20:57
---
# FEAT-Task: Evolve logo + favicon + OG mark system

## GitHub Issue
- **Number:** #81
- **Title:** Evolve logo + favicon + OG mark system
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/81
- **Labels:** agent:wip → agent:untested

## Problem / goal
Logo and favicon are the same weak teal pin. Brand test fails; tabs unreadable. Evolve the full mark system. Related: #72.

## High-level instructions for coder
1. Follow brand tokens (Ink / Paper / Signal). Anti-slop: no purple, no Inter wordmark defaults.
2. Redesign symbol (+ optional wordmark treatment) for Kilómetro 0: origin/local/signal - **not** a generic map-pin clone.
3. Ship: `public/brand/logo.svg`, raster exports if needed, `public/favicon.svg` (full-bleed, minimal padding), apple-touch if used, refresh `og-preview.png`.
4. Wire Header, Hero, Footer, Layout favicon links, `logo-icon` if email templates depend on it.
5. Update `docs/brand-tokens.md` Assets + short usage notes.
6. Build; bump; gh on #81.

## Acceptance
- New mark recognisable at 16×16 and in header
- No purple-era OG
- All locales render new assets

## Implementation notes (coder)
- New **origin stamp** mark: Signal field + Paper geometric 0 + origin diamond + milestone baseline (not a map pin).
- Assets: `public/brand/logo.svg`, `logo.png` (512), `logo-icon.png` (256), `og-preview.png` (1200×630 Paper + stamp + wordmark), `public/favicon.svg` (full-bleed), `public/apple-touch-icon.png` (180).
- `Layout.astro`: favicon + apple-touch links. Header/Hero/Footer/Presentation already use `/brand/logo.svg`. Email templates keep `logo-icon.png` URL.
- Docs: `docs/brand-tokens.md` Assets + mark usage. Site version **1.1.110**.

## Testing instructions
1. **Docker:** `docker compose ps` shows `km0-web` up; footer on `/` shows **Versión 1.1.110**.
2. **Locales HTTP 200:** `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/`.
3. **Favicon:** `http://127.0.0.1:9180/favicon.svg` - full-bleed Signal stamp (0 + diamond + baseline), no map-pin stem, no `linearGradient` / purple. Open in a browser tab: mark fills the tab icon (minimal padding, #72).
4. **Logo SVG/PNG:** `/brand/logo.svg` and `/brand/logo.png` - rounded Signal stamp; appears in header, hero proof, footer, presentation on es/ca/en/de.
5. **Email icon:** `/brand/logo-icon.png` HTTP 200, 256×256, same stamp (no purple gradient).
6. **Apple touch:** `/apple-touch-icon.png` HTTP 200; `<link rel="apple-touch-icon">` present in home HTML.
7. **OG:** `/brand/og-preview.png` - Paper canvas, Signal top rule, stamp + “Kilómetro 0 Digital”; spot-check no magenta/purple pixels (old gradient pin gone).
8. **Anti-slop:** Mark is not Inter wordmark-only; not purple/indigo gradient; not generic map-pin clone.
9. **Logs:** `docker logs --since 10m km0-web` - no nginx errors on asset GETs.

## References
- Runbook: docs/runbook.md
- Study: docs/design/reference-study-stirling-satisfecho-nous.md
- Doctrine: docs/design/anti-slop-doctrine.md
- Tokens: docs/brand-tokens.md
- Site: https://km0digital.com

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-17 20:55:15 UTC; end ~20:56:05 UTC. Asset GET evidence in `docker logs` around 20:55:56-20:55:57 UTC.
2. **Environment:** Branch `main`. Container `km0-web` healthy on `127.0.0.1:9180` (prior `docker compose build && up -d`). Production `https://km0digital.com/` HTTP/2 200 for HTML and assets (immediate 200, no sleep).
3. **What was tested:** Testing instructions 1-9 for evolve logo/favicon/OG (#81).
4. **Results:**
   - Docker up + footer version: **PASS** - healthy; footer **Versión 1.1.113** (task noted 1.1.110; later phase-2 bumps in workspace).
   - Locales HTTP: **PASS** - `/` `/ca/` `/en/` `/de/` `/doc/` → 200.
   - Favicon: **PASS** - `/favicon.svg` 200, viewBox 0 0 32 32 full-bleed Signal `#0F766E` + Paper 0/diamond; no `linearGradient`, no purple, no pin keyword.
   - Logo SVG/PNG in chrome: **PASS** - `/brand/logo.svg` + `.png` (512×512) 200; stamp comment "not a map pin"; `/` `/ca/` `/en/` `/de/` `/presentation/` `/ca/presentation/` each include `/brand/logo.svg` (count 2) + favicon + apple-touch.
   - Email icon: **PASS** - `/brand/logo-icon.png` 200, 256×256.
   - Apple touch: **PASS** - `/apple-touch-icon.png` 200 (180×180); `<link rel="apple-touch-icon">` in home HTML; Layout.astro lines wire favicon + apple-touch.
   - OG: **PASS** - `/brand/og-preview.png` 1200×630; Paper corners `(238,240,242)`; Signal teal stamp region + top rule; purpleish/magentaish pixel samples **0**.
   - Anti-slop: **PASS** - Signal/Paper stamp mark, not Inter-only wordmark, not purple gradient, not map-pin clone.
   - Logs: **PASS** - all asset GETs 200; no 5xx on those paths.
   - GitHub label `agent:testing` on issue #81: **PASS**.
5. **Overall: PASS**
6. **URLs tested:** loopback home locales + `/doc/` + `/presentation/`; assets `/favicon.svg`, `/brand/logo.svg`, `/brand/logo.png`, `/brand/logo-icon.png`, `/apple-touch-icon.png`, `/brand/og-preview.png`; production home + favicon + logo.svg.
7. **Log excerpts:**
   ```
   GET /favicon.svg HTTP/1.1" 200 503
   GET /brand/logo.svg HTTP/1.1" 200 558
   GET /brand/logo.png HTTP/1.1" 200 3936
   GET /brand/logo-icon.png HTTP/1.1" 200 1765
   GET /apple-touch-icon.png HTTP/1.1" 200 1118
   GET /brand/og-preview.png HTTP/1.1" 200 19869
   ```
8. **GitHub:** label `agent:testing` applied on issue #81 at test start.

