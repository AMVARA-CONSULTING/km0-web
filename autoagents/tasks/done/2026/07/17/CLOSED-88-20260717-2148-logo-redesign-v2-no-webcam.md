---
## Closing summary (TOP)

- **What happened:** Prior mark (#81) still read as a webcam/camera lens; brand test failed.
- **What was done:** Shipped rectangular digit-0 Signal plaque (SVG/PNG/favicon/OG/mono), wired existing header/hero/footer paths, updated brand-tokens docs; version 1.1.116.
- **What was tested:** Tester PASS: SVG purity (no ellipse/gradient/iris), 16–32px favicon read, locales, OG color sample, docs.
- **Why closed:** Acceptance met; anti-slop skim found no purple/glow/map-pin regressions.
- **Closed at (UTC):** 2026-07-17 21:58
---

# FEAT-Task: Logo redesign v2  -  kill webcam look

## GitHub Issue
- **Number:** #88
- **Title:** Logo redesign v2: kill webcam look  -  IT-services mark system
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/88
- **Labels:** agent:wip

## Problem / goal
Current mark reads as a webcam/camera lens. #81 closed but failed the brand test. Redesign using IT/digital-services logo best practices: responsive tiers, favicon-first, one focal geometric/letter idea, no gadget tropes. Brief: `docs/design/logo-brief-it-services.md`.

## High-level instructions for coder
1. Read `docs/design/logo-brief-it-services.md`, brand tokens, anti-slop doctrine.
2. Explore **2–3 SVG candidates** (lettermark 0/KM, origin plaque with clear 0, milestone/signal bar). Pick one; reject any concentric-lens silhouette.
3. Ship system:
   - `public/brand/logo.svg` (+ mono if needed)
   - `public/favicon.svg` dedicated micro mark (full-bleed, minimal padding)
   - Refresh `og-preview.png` / `logo-icon.png` if they still show the lens
4. Wire Header, Hero, Footer, Layout favicon links; email icon path if used.
5. Update `docs/brand-tokens.md` Assets + one paragraph on usage + “not a webcam” silhouette note.
6. Build; bump patch; gh #88; agent:wip → UNTESTED with visual checks at 16px/32px/header.

## Acceptance
- Does not read as camera/webcam/iris at any size
- Passes 16×16 favicon and mono silhouette tests
- Aligned with Signal/Ink; no purple/glow
- Build green

## What was done
- **Candidates considered:** (A) circular lettermark 0 + milestone bar; (B) rectangular digit-0 plaque; (C) 0 + milestone bar under digit. Rejected A (still lens-adjacent) and C (read as monitor-on-stand). **Shipped B:** rectangular digit **0** on Signal plaque.
- **Assets:** `public/brand/logo.svg`, `logo-mono.svg`, `logo.png` (512), `logo-icon.png` (256), `og-preview.png` (1200×630), `public/favicon.svg` (full-bleed), `public/apple-touch-icon.png` (180).
- **Wiring:** Header/Hero/Footer/Presentation already use `/brand/logo.svg`; Layout already links favicon + apple-touch; email templates keep `logo-icon.png` URL (raster refreshed).
- **Docs:** `docs/brand-tokens.md` Assets + Digit-0 plaque usage / “not a webcam” note; doctrine mark motif line updated.
- **Version:** `1.1.115` → `1.1.116` via `./scripts/bump-patch-version.sh`.
- **Why not a webcam:** No `<ellipse>` rings, no center diamond/iris, single evenodd digit path with straighter sides.

## Testing instructions
1. **Build / container:** `docker compose build && docker compose up -d` succeeds; footer shows **Versión 1.1.116** (or locale equivalent) on `http://127.0.0.1:9180/`.
2. **HTTP 200:** `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/favicon.svg`, `/brand/logo.svg`, `/brand/logo.png`, `/brand/logo-icon.png`, `/brand/logo-mono.svg`, `/brand/og-preview.png`, `/apple-touch-icon.png`.
3. **Visual (favicon):** Open `/favicon.svg` and shrink view to ~16×16 and 32×32. Mark must read as a bold digit **0** on Signal; **not** a camera/webcam/iris. Full-bleed (no empty padding ring).
4. **Visual (header):** On `/`, `/ca/`, `/en/`, `/de/` confirm header/hero/footer stamp is the rounded Signal plaque with rectangular 0 (same motif as favicon, with `rx`).
5. **SVG purity:** `logo.svg` / `favicon.svg` contain **no** `<ellipse>`, `linearGradient`, or center diamond path. Colors only Signal `#0F766E` and Paper `#EEF0F2` (mono: Ink + white).
6. **Mono:** `/brand/logo-mono.svg` is a clear Ink/white silhouette of the same digit (readable without color).
7. **OG / email:** `/brand/og-preview.png` is Paper + Signal top rule + stamp + “Kilómetro 0 Digital”; no purple/magenta. `/brand/logo-icon.png` is 256×256 same plaque.
8. **Anti-slop:** No purple brand gradient, no map-pin stem, no glow. Docs in `docs/brand-tokens.md` describe Digit-0 plaque and webcam rejection.

## References
- docs/design/logo-brief-it-services.md
- docs/brand-tokens.md
- docs/design/anti-slop-doctrine.md
- Related closed: #81; favicon idea #72

## Test report

1. **Date/time (UTC):** 2026-07-17T21:56:59Z start → 2026-07-17T21:57:20Z end. Log window overlaps prior rebuild (21:55:39 UTC up) + access checks 21:57:07–21:57:14 UTC.
2. **Environment:** branch `main`; loopback via existing `km0-web` container from `docker compose build` (footer **1.1.116**); production spot-check `https://km0digital.com` (HTTP/2 200 on first poll for `/favicon.svg`, `/brand/logo.svg`, `/brand/og-preview.png`).
3. **What was tested:** Testing instructions 1–8: HTTP assets, SVG purity, visual read of PNG/SVG marks (logo.png, logo-icon, apple-touch, og-preview), mono colors, brand-tokens docs, anti-slop color sampling on OG.
4. **Results:**
   - Build/container + footer 1.1.116 → **PASS**
   - HTTP 200 for `/`, locales, `/doc/`, favicon, logo.svg/png/icon/mono, og-preview, apple-touch → **PASS**
   - Favicon visual: full-bleed Signal rect + evenodd digit **0** path; no outer `rx`; no ellipse/iris rings → **PASS** (reads as bold 0, not webcam)
   - Header/hero/footer: `/brand/logo.svg` wired on `/` + ca/en/de (4 refs each); plaque has `rx="5"` + same digit path → **PASS**
   - SVG purity (logo/favicon/mono): no `<ellipse>`, no gradients, no diamond; Signal `#0F766E` + Paper `#EEF0F2`; mono Ink `#0B1220` + white → **PASS**
   - Mono silhouette: same digit geometry, Ink/white → **PASS**
   - OG 1200×630: Paper field + Signal top rule (sampled RGB ≈15,118,110) + stamp + “Kilómetro 0 Digital”; purpleish pixels 0/240 samples; logo-icon 256×256 plaque → **PASS**
   - Anti-slop / docs: Digit-0 plaque + webcam rejection in `docs/brand-tokens.md`; no purple gradient / map-pin → **PASS**
5. **Overall:** **PASS**
6. **URLs:** `http://127.0.0.1:9180/` (+ ca/en/de, doc, brand assets, favicon, apple-touch); `https://km0digital.com/favicon.svg`, `/brand/logo.svg`, `/brand/og-preview.png`
7. **Logs:** prior nginx start 21:55:39; asset GETs 200 in this window; no errors observed.

