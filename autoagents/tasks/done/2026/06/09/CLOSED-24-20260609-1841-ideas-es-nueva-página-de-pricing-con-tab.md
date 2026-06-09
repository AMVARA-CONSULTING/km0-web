---
## Closing summary (TOP)

- **What happened:** Issue #24 requested a scaffolded Pricing page with a competitor comparison table for km0-web.
- **What was done:** Added `/pricing/` across all locales with a six-row comparison table (KM0 plus five competitors), nav/footer links, i18n copy, custom proposal mailto CTA, and site version bump to 1.1.42.
- **What was tested:** Docker build (80 pages), HTTP 200 on all locale pricing routes, table content, nav/footer links, locale switcher, hreflang, em-dash check, and production poll at km0digital.com/pricing/; all PASS.
- **Why closed:** All testing criteria passed; production readiness confirmed.
- **Closed at (UTC):** 2026-06-09 18:46
---

# [ideas/es] Nueva página de Pricing con tabla comparativa

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/24
- **Number:** #24
- **Labels:** none
- **Created:** 2026-06-09T18:35:41Z

## Problem / goal
## Summary  The submitter requests a new Pricing page, scaffolded now so it can be filled in when enough pricing data is available. The initial version should include a small comparison table (up to five well-known competitors) showing monthly price...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/24
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation notes
- Added `/pricing/` route in all locales (`src/pages/**/pricing/index.astro`, `src/views/Pricing.astro`).
- Comparison table: KM0 Digital (1,99 €, ?? GB placeholder) plus Google Drive, Dropbox, OneDrive, iCloud, MEGA with indicative figures.
- Custom proposal CTA links to `hello.yoel@amvara.de`.
- Nav link in header (desktop + mobile burger) and footer.
- Site version bumped to **1.1.42**.

## Testing instructions
1. `docker compose build && docker compose up -d` (build passed during implementation).
2. Confirm HTTP 200:
   - `curl -sI http://127.0.0.1:9180/pricing/`
   - `curl -sI http://127.0.0.1:9180/ca/pricing/`
   - `curl -sI http://127.0.0.1:9180/en/pricing/`
   - `curl -sI http://127.0.0.1:9180/de/pricing/`
3. Open `/pricing/` in a browser: table shows 6 rows (KM0 highlighted), disclaimer text, and custom proposal mailto CTA.
4. Header nav (desktop and mobile burger) includes **Precios** / localized label linking to `/pricing/`.
5. Footer includes pricing link next to Legal / Security.
6. Switch locale (CA, EN, DE) on `/pricing/` and confirm translated copy and table headers.
7. Footer shows version **1.1.42** on pricing and home pages.
8. Optional: `grep -r $'\u2014' src/` returns zero matches (em dash check).

## Test report

1. **Date/time (UTC):** 2026-06-09T18:44:39Z – 2026-06-09T18:45:48Z. Log window: nginx access logs from 18:45:15Z through 18:45:23Z.
2. **Environment:** branch `main` @ `cd5579e` (uncommitted local changes for issue #24); build via `docker compose build && docker compose up -d` (`km0-web@1.1.42`, 80 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Docker build/deploy, HTTP 200 on pricing routes (all locales), standard smoke paths, pricing page content (6-row table, KM0 highlight, disclaimer, mailto CTA), header nav (desktop + mobile), footer pricing link, locale switcher and translated copy, footer version 1.1.42, em-dash check, hreflang tags, production poll for `/pricing/`.
4. **Results:**
   - Docker build/up (80 pages, em-dash check OK): **PASS** (`[build] 80 page(s) built in 3.11s`; container Up)
   - HTTP 200 on `/pricing/`, `/ca/pricing/`, `/en/pricing/`, `/de/pricing/`: **PASS** (all `HTTP/1.1 200 OK`)
   - HTTP 200 on `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`: **PASS**
   - Pricing table 6 rows with KM0 highlighted (`pricing-table-row-highlight`): **PASS** (KM0 Digital + 5 competitors)
   - Disclaimer note (`Cifras orientativas de referencia`): **PASS**
   - Custom proposal mailto CTA (`hello.yoel@amvara.de`): **PASS**
   - Header nav Precios link to `/pricing/` (desktop): **PASS**
   - Header nav Precios link (mobile burger `data-mobile-nav-link`): **PASS**
   - Footer pricing link next to Legal / Security: **PASS**
   - Locale switcher on `/pricing/` (CA, EN, DE, ES with correct paths): **PASS**
   - Translated copy (EN `Cloud storage comparison`, CA `Comparativa d'emmagatzematge al núvol`, DE `Cloud-Speicher-Vergleich`): **PASS**
   - Footer version **1.1.42** on home and pricing: **PASS**
   - `hreflang` (ca, de, en, es, x-default): **PASS**
   - Em dash check (`rg U+2014 src/`): **PASS** (zero matches)
   - Docker logs: no errors after deploy: **PASS** (nginx startup + 200 responses only)
   - Production readiness: **PASS** (`https://km0digital.com/pricing/` returned HTTP 200 on first poll; Precios nav, highlighted KM0 row, mailto CTA, version 1.1.42 present)
   - GitHub label `agent:testing` on issue #24: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/pricing/`, `/ca/pricing/`, `/en/pricing/`, `/de/pricing/`, `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`; `https://km0digital.com/`, `https://km0digital.com/pricing/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.42 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   18:45:13 [build] 80 page(s) built in 3.11s
   2026/06/09 18:45:15 [notice] 1#1: start worker processes
   172.21.0.1 - - [09/Jun/2026:18:45:18 +0000] "HEAD /pricing/ HTTP/1.1" 200 0
   172.21.0.1 - - [09/Jun/2026:18:45:19 +0000] "HEAD /ca/pricing/ HTTP/1.1" 200 0
   172.21.0.1 - - [09/Jun/2026:18:45:19 +0000] "GET /pricing/ HTTP/1.1" 200 17215
   172.21.0.1 - - [09/Jun/2026:18:45:20 +0000] "GET /ca/pricing/ HTTP/1.1" 200 17242
   ```
8. **GitHub:** label `agent:testing` applied on issue #24 at test start.
