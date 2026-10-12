---
## Closing summary (TOP)

- **What happened:** Issue #155 asked to remove Eberesche and any Google Fonts CSS from the km0digital product surface.
- **What was done:** Repo audit found no Eberesche; marketing already self-hosts IBM Plex Sans. Google Fonts `@import` CDN pulls were removed from email templates and public testing mirrors; docs and footer version bumped to 1.3.29.
- **What was tested:** Tester PASS - locales and email mirrors 200, zero googleapis/gstatic and zero Eberesche, self-hosted woff2 + Version 1.3.29, clean nginx logs; production `/en/` spot-check also clean.
- **Why closed:** All testing criteria passed; no anti-slop or craft-parity hard-gate issues (fonts hygiene only, brand face unchanged).
- **Closed at (UTC):** 2026-10-12 06:06
---

# [ideas/es] Remove Eberesche / Google fonts

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/155
- **Number:** #155
- **Labels:** none
- **Created:** 2026-10-12T05:49:45Z

## Problem / goal
The submitter wants any Eberesche fonts and related Google Fonts CSS removed from the site. This item targets the public web product (km0digital).

Original submission: Need to remove any Eberesche fonts or css from google.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/155
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md
- Prior: #117 self-host brand fonts (marketing Layout already CDN-free)

## Implementation summary
- **Eberesche:** Repo-wide audit found **zero** `Eberesche` / `eberesche` references in `src/`, `public/`, or `email-templates/`. Nothing to delete for that family name.
- **Marketing site:** Already self-hosts IBM Plex Sans via `src/styles/fonts.css` + `public/fonts/` (no Google Fonts in `Layout.astro`). Confirmed live HTML for `/`, `/ca/`, `/en/`, `/de/` has zero `fonts.googleapis` / `fonts.gstatic`.
- **Remaining Google Fonts CSS:** Removed `@import url('https://fonts.googleapis.com/css2?...')` from all 10 `email-templates/**/*.html` files and the 4 public mirrors under `public/en/testing/{welcome,webstyle,cloudstyle,message}.html`. Font stacks stay `IBM Plex Sans`, Helvetica Neue, Helvetica, Arial (email-safe fallbacks; unused Source Serif 4 CDN pull dropped with the import).
- **Docs:** Noted no Google Fonts CDN in `email-templates/README.md`.
- **Version:** `1.3.28` → `1.3.29` via `./scripts/bump-patch-version.sh`.
- **Deploy:** `docker compose build && docker compose up -d` succeeded; footer shows **Version 1.3.29**.

Pre-emit (fonts/copy hygiene, not a UI remodel): P4 H4 E5 S5 R5 V5. No token/hex improvisation; brand face unchanged (IBM Plex Sans).

## Testing instructions

1. **HTTP smoke (local container):**
   ```bash
   curl -sI http://127.0.0.1:9180/en/
   curl -sI http://127.0.0.1:9180/ca/
   curl -sI http://127.0.0.1:9180/de/
   curl -sI http://127.0.0.1:9180/en/testing/welcome.html
   ```
   Expect **200** on prefixed locales and testing pages. Unprefixed `/` may **302** (Accept-Language negotiation).

2. **Zero Google Fonts CDN in shipped HTML:**
   ```bash
   for p in /en/ /ca/ /de/ /en/testing/welcome.html /en/testing/webstyle.html /en/testing/cloudstyle.html /en/testing/message.html; do
     echo -n "$p "; curl -sL "http://127.0.0.1:9180$p" | grep -ciE 'fonts\.googleapis|fonts\.gstatic' || true
   done
   grep -r 'fonts\.googleapis\|fonts\.gstatic' email-templates public --include='*.html' || echo ZERO
   ```
   Expect **0** hits on every path and **ZERO** in repo shipped HTML.

3. **No Eberesche:**
   ```bash
   grep -ri 'eberesche' src public email-templates || echo ZERO_EBERESCHE
   ```
   Expect **ZERO_EBERESCHE**.

4. **Self-hosted marketing fonts still load:**
   ```bash
   curl -sI http://127.0.0.1:9180/fonts/ibm-plex-sans-latin-400-normal.woff2 | head -5
   curl -sL http://127.0.0.1:9180/en/ | grep -o 'fonts/ibm-plex-sans[^"]*' | head -5
   ```
   Expect `Content-Type: font/woff2` (or equivalent) and `/fonts/ibm-plex-sans-...` references from CSS/preload.

5. **Footer version:** page source or footer shows **1.3.29** (e.g. `Version 1.3.29` on `/en/`).

6. **Email template preview:** open `http://127.0.0.1:9180/en/testing/` and spot-check welcome/webstyle/cloudstyle/message; layout and stacks intact, no Google Fonts network request in DevTools.

7. **Logs:** `docker logs --since 10m km0-web` - no nginx emerg/error from this deploy.

## Test report

1. **Date/time (UTC) and log window:** Start 2026-10-12T06:04:03Z (UNTESTED → TESTING + `agent:testing` on #155). Container already healthy from coder deploy (created ~06:02:50Z). Checks 06:04:18Z–06:04:38Z. Report close 2026-10-12T06:04:57Z. Docker log window 06:02:50Z–06:04:38Z. Host `npm` unavailable; verification used docker compose path (runbook).

2. **Environment:** branch `main` @ `5784271`. Build method: existing `km0-web` container (healthy, `127.0.0.1:9180->80`). Local URLs under `http://127.0.0.1:9180/`. Production spot: `https://km0digital.com/en/` (ready when HEAD returned HTTP/2 200).

3. **What was tested:** HTTP smoke for locales + email testing mirrors; zero Google Fonts CDN in served HTML and repo shipped HTML; zero Eberesche; self-hosted IBM Plex Sans woff2 + page references; footer **1.3.29**; email preview stacks; nginx logs for emerg/error/crit.

4. **Results:**
   - **HTTP smoke:** **PASS** - `/en/`, `/ca/`, `/de/`, `/en/testing/welcome.html` all `200`; `/` `302` → `/en/` (Accept-Language negotiation).
   - **Zero Google Fonts CDN (served):** **PASS** - counts `0` for `/en/`, `/ca/`, `/de/`, and all four `/en/testing/{welcome,webstyle,cloudstyle,message}.html`.
   - **Zero Google Fonts CDN (repo shipped HTML):** **PASS** - `grep -r fonts.googleapis|fonts.gstatic email-templates public --include='*.html'` → `ZERO`. Sample templates have no `@import`.
   - **No Eberesche:** **PASS** - `grep -ri eberesche src public email-templates` → `ZERO_EBERESCHE`.
   - **Self-hosted marketing fonts:** **PASS** - `/fonts/ibm-plex-sans-latin-400-normal.woff2` → `200`, `Content-Type: font/woff2`. `/en/` references `fonts/ibm-plex-sans-latin-600-normal.woff2` and `fonts/ibm-plex-sans-latin-400-normal.woff2`.
   - **Footer version:** **PASS** - `/en/` shows `Version 1.3.29`; `package.json` `"version": "1.3.29"`.
   - **Email template preview:** **PASS** - `/en/testing/` `200`; welcome/webstyle/cloudstyle/message keep `font-family: 'IBM Plex Sans', 'Helvetica Neue', Helvetica, Arial, sans-serif`; served HTML has `0` matches for googleapis/gstatic/`@import`.
   - **Logs:** **PASS** - `docker logs --since 2026-10-12T06:02:00Z km0-web` filtered for emerg/error/crit → `NO_EMERG_ERROR_CRIT`. Access lines show expected 200/302 only.
   - **Production spot (informational):** **PASS** - `https://km0digital.com/en/` HTTP/2 200, Google Fonts count `0`, `Version 1.3.29` (site ready via curl 200, no fixed sleep).
   - **GitHub label:** **PASS** - `agent:testing` on #155 at start; removed on PASS → CLOSED.

5. **Overall:** **PASS**

6. **URLs tested:**
   - http://127.0.0.1:9180/ (302)
   - http://127.0.0.1:9180/en/ (200)
   - http://127.0.0.1:9180/ca/ (200)
   - http://127.0.0.1:9180/de/ (200)
   - http://127.0.0.1:9180/en/testing/ (200)
   - http://127.0.0.1:9180/en/testing/welcome.html (200)
   - http://127.0.0.1:9180/en/testing/webstyle.html (200)
   - http://127.0.0.1:9180/en/testing/cloudstyle.html (200)
   - http://127.0.0.1:9180/en/testing/message.html (200)
   - http://127.0.0.1:9180/fonts/ibm-plex-sans-latin-400-normal.woff2 (200, font/woff2)
   - https://km0digital.com/en/ (200)

7. **Relevant log excerpts:**
   ```
   2026/10/12 06:02:50 [notice] 1#1: start worker process ...
   NO_EMERG_ERROR_CRIT
   172.21.0.1 - - [12/Oct/2026:06:04:18 +0000] "HEAD /en/ HTTP/1.1" 200
   172.21.0.1 - - [12/Oct/2026:06:04:22 +0000] "GET /en/testing/welcome.html HTTP/1.1" 200 7515
   172.21.0.1 - - [12/Oct/2026:06:04:22 +0000] "HEAD /fonts/ibm-plex-sans-latin-400-normal.woff2 HTTP/1.1" 200
   ```

8. **GitHub:** label `agent:testing` on #155 at start; removed on PASS → CLOSED.
