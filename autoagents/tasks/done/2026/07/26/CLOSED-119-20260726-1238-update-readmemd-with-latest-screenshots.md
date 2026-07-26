---
## Closing summary (TOP)

- **What happened:** Issue #119 asked to replace the outdated README hero screenshot that still showed the old centered SaaS design.
- **What was done:** Replaced `docs/preview-hero.png` with a fresh Playwright capture of the live Spanish landing (current civic dark first viewport); README path unchanged; site version bump correctly skipped (docs asset only).
- **What was tested:** Tester PASS - PNG 2880×1800 real PNG (not JPEG), hero shows current civic layout not old gradient map-pin dual-pill CTA, HTTP smoke 200 on loopback locales + `/doc/` and production `/`.
- **Why closed:** All testing criteria passed; docs-only scope, not a UI craft FEAT (Hard gate N/A); no anti-slop regression in the new capture.
- **Closed at (UTC):** 2026-07-26 12:42
---

# Update README.md with latest screenshots

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/119
- **Number:** #119
- **Labels:** agent:wip (was agent:planned)
- **Created:** 2026-07-26T12:32:17Z

## Problem / goal
The README still shows a screenshot at the top with old design. Update the screenshot

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/119
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary

Replaced `docs/preview-hero.png` (README hero preview) with a fresh capture of the live Spanish landing at `http://127.0.0.1:9180/`.

- **Before:** Old centered SaaS hero with orange–pink–violet gradient map-pin mark and dual pill CTAs (JPEG mislabeled as PNG, 1024×581).
- **After:** Current civic dark first viewport (Paper navy, Signal teal accent, biased copy + live KM0 Cloud proof panel with QR). Real PNG, 2880×1800 @2x (1440×900 clip).
- **README.md:** Unchanged path `![Hero preview - KM0 Digital](docs/preview-hero.png)`; image file only.
- **Site version bump:** Skipped per `.cursor/rules/site-version-bump.mdc` (diff limited to `docs/` README asset; does not ship in Astro build / footer).
- **Capture method:** Playwright 1.49 via existing `mcr.microsoft.com/playwright:v1.49.0-jammy` against local `km0-web` on `:9180` (no new host packages).

Not a UI remodel FEAT; no P/H/E/S/R/V scores (docs asset only).

## Testing instructions

1. Open `README.md` on GitHub (or locally in a Markdown preview) and confirm the top image shows the **current** dark civic hero: teal accent, "Nube privada y correo.", primary CTA "Abrir KM0 Cloud", live Cloud proof panel with QR, **not** the old gradient map-pin / dual pill CTA layout.
2. File check: `file docs/preview-hero.png` → `PNG image data, 2880 x 1800` (not JPEG).
3. Smoke (unchanged site): `curl -sI http://127.0.0.1:9180/` and `/ca/`, `/en/`, `/de/`, `/doc/` → all `200`.
4. Optional: re-open `docs/preview-hero.png` and confirm nav includes Servicios / Precios / Blog and locale switcher CA/DE/EN/ES.

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-26T12:41:25Z (UNTESTED → TESTING); checks 12:41:44Z–12:41:45Z; report close 12:41:56Z. Docker access log window 12:41:45Z (HEAD checks).
2. **Environment:** Branch `main` @ `22041f5`. Docs asset only (`docs/preview-hero.png`); no rebuild. Container `km0-web` healthy Up 15h on `http://127.0.0.1:9180/`. Production `https://km0digital.com/` HEAD **200** on first poll (ready via immediate 200). Craft Hard gate: **N/A** (README screenshot asset, not UI craft FEAT).
3. **What was tested:** Testing instructions 1–4 (README hero image content, PNG file geometry, HTTP smoke, optional nav/locale visibility in capture).
4. **Results:**
   - README hero image current design: **PASS** - `docs/preview-hero.png` shows dark Paper civic first viewport: brand "Kilómetro 0 Digital", headline "Nube privada y correo." (teal on "y correo"), support line, primary CTA "Abrir KM0 Cloud" + "Ver precios", live KM0 Cloud proof panel with QR / Entrar / Crear cuenta / cloud.km0digital.com. Not the old centered gradient map-pin / dual pill CTA layout.
   - File check: **PASS** - `file docs/preview-hero.png` → `PNG image data, 2880 x 1800, 8-bit/color RGB, non-interlaced` (real PNG, not JPEG). Size ~586506 bytes (was ~36KB JPEG-mislabeled).
   - HTTP smoke: **PASS** - loopback HEAD `/` `/ca/` `/en/` `/de/` `/doc/` all **200**. Production `/` **200**.
   - Optional nav/locales in capture: **PASS** - screenshot shows Inicio / Servicios / Precios / Blog / Ideas / Encuentros / Contacto and locale switcher CA | DE | EN | ES (ES active).
   - Scope / bump N/A: **PASS** - ship diff vs `origin/main` is `docs/preview-hero.png` only; `README.md` path unchanged (`![Hero preview - KM0 Digital](docs/preview-hero.png)`); no `src/` / `package.json` change (bump correctly skipped).
   - Docker logs: **PASS** - tested paths **200**; no 5xx in test window.
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/`; `https://km0digital.com/` (ready check).
7. **Log excerpts:**
   ```
   172.21.0.1 - - [26/Jul/2026:12:41:45 +0000] "HEAD / HTTP/1.1" 200
   172.21.0.1 - - [26/Jul/2026:12:41:45 +0000] "HEAD /ca/ HTTP/1.1" 200
   172.21.0.1 - - [26/Jul/2026:12:41:45 +0000] "HEAD /en/ HTTP/1.1" 200
   172.21.0.1 - - [26/Jul/2026:12:41:45 +0000] "HEAD /de/ HTTP/1.1" 200
   172.21.0.1 - - [26/Jul/2026:12:41:45 +0000] "HEAD /doc/ HTTP/1.1" 200
   ```
8. **GitHub:** label `agent:testing` on #119 at start; removed on PASS → CLOSED.
