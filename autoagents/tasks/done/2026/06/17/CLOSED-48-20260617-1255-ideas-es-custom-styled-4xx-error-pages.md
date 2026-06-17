---
## Closing summary (TOP)

- **What happened:** GitHub issue #48 requested custom styled 4xx error pages (404 and 403) with localized copy and a home link across all site locales.
- **What was done:** Added `ErrorPage.astro`, locale-aware 404/403 routes, i18n keys in es/ca/en/de, and nginx `error_page` maps; site version bumped to 1.1.82.
- **What was tested:** Tester verified HTTP status codes, localized body copy, 403 direct access, smoke paths, footer version on loopback and production; overall **PASS**.
- **Why closed:** All testing criteria passed.
- **Closed at (UTC):** 2026-06-17 13:00
---

# [ideas/es] Custom styled 4xx error pages

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/48
- **Number:** #48
- **Labels:** agent:wip
- **Created:** 2026-06-17T12:54:20Z

## Problem / goal
Custom error pages for HTTP 4xx responses (404 and 403), matching km0digital.com styling, with localized copy and a clear link back to the home page in all locales (es/ca/en/de).

## Implementation summary
- Added `src/views/ErrorPage.astro`: shared error layout with site header/footer, navy hero-style background, logo, error code, localized heading/description, and primary CTA back to home.
- Added locale-aware error routes: `404.astro` and `403.astro` under `src/pages/` (es default) and `src/pages/{ca,en,de}/`.
- Added `errors.notFound` and `errors.forbidden` i18n keys in `es.json`, `ca.json`, `en.json`, `de.json`; updated `src/i18n/types.ts`.
- Updated `nginx/container.conf`: locale-aware `error_page` maps for 404/403; `try_files` now returns 404 instead of falling back to home; internal locations for error page assets.
- Site version bumped to **1.1.82**.

## Testing instructions
1. **Build & deploy:** `docker compose build && docker compose up -d`
2. **404 status (default es):** `curl -sI http://127.0.0.1:9180/this-page-does-not-exist/` returns HTTP **404** (not 200).
3. **404 status (locales):** Same for `/ca/`, `/en/`, `/de/` prefixed missing paths; each returns HTTP **404**.
4. **404 body (es):** Response HTML contains "Página no encontrada" and "Volver a la página principal".
5. **404 body (en):** `/en/this-page-does-not-exist/` contains "Page not found" and "Back to home".
6. **404 body (ca/de):** Verify localized headings and back-home CTA on `/ca/` and `/de/` missing paths.
7. **403 pages exist:** `curl -sI http://127.0.0.1:9180/403/` and `/en/403/` return HTTP 200 (direct access to error page assets).
8. **Smoke paths still 200:** `curl -sI` returns 200 for `/`, `/ca/`, `/en/`, `/de/`, `/doc/`.
9. **Footer version:** Page footer shows **1.1.82** on all locales.

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Test report

1. **Date/time (UTC):** 2026-06-17T12:59:10Z – 2026-06-17T12:59:45Z. Log window: Docker/nginx from 12:59:22Z.
2. **Environment:** branch `main` @ `2715759` (uncommitted working tree); build via `docker compose build && docker compose up -d` (`km0-web@1.1.82`, 96 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Custom 404/403 error pages per testing instructions: HTTP status codes, localized body copy (es/ca/en/de), 403 direct access, smoke paths, footer version, production readiness.
4. **Results:**
   - Docker build & deploy: **PASS** (`check-no-em-dash: OK`, 96 pages built)
   - 404 status (es default `/this-page-does-not-exist/`): **PASS** (HTTP/1.1 404 Not Found)
   - 404 status (locales `/ca/`, `/en/`, `/de/` missing paths): **PASS** (HTTP/1.1 404 each)
   - 404 body (es): "Página no encontrada" + "Volver a la página principal": **PASS**
   - 404 body (en): "Page not found" + "Back to home": **PASS**
   - 404 body (ca): "Pàgina no trobada" + "Tornar a la pàgina principal": **PASS**
   - 404 body (de): "Seite nicht gefunden" + "Zur Startseite": **PASS**
   - 403 pages (`/403/`, `/en/403/`): **PASS** (HTTP/1.1 200 OK)
   - Smoke paths (`/`, `/ca/`, `/en/`, `/de/`, `/doc/`): **PASS** (HTTP/1.1 200 OK each)
   - Footer version **1.1.82** (ES Versión, CA Versió, EN/DE Version): **PASS**
   - Production readiness: **PASS** (`https://km0digital.com/` HTTP 200 on first poll; production 404 for missing paths; footer shows Versión 1.1.82)
   - GitHub label `agent:testing` on issue #48: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/this-page-does-not-exist/`, `/ca/this-page-does-not-exist/`, `/en/this-page-does-not-exist/`, `/de/this-page-does-not-exist/`, `/403/`, `/en/403/`, `/`, `/ca/`, `/en/`, `/de/`, `/doc/`; `https://km0digital.com/`, `https://km0digital.com/this-page-does-not-exist/`, `https://km0digital.com/en/this-page-does-not-exist/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.82 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   12:59:20 [build] 96 page(s) built in 3.88s
   2026/06/17 12:59:22 [notice] 1#1: start worker processes
   172.21.0.1 - - [17/Jun/2026:12:59:28 +0000] "HEAD /this-page-does-not-exist/ HTTP/1.1" 404 0
   172.21.0.1 - - [17/Jun/2026:12:59:28 +0000] "HEAD /ca/this-page-does-not-exist/ HTTP/1.1" 404 0
   172.21.0.1 - - [17/Jun/2026:12:59:28 +0000] "HEAD /en/this-page-does-not-exist/ HTTP/1.1" 404 0
   172.21.0.1 - - [17/Jun/2026:12:59:28 +0000] "HEAD /de/this-page-does-not-exist/ HTTP/1.1" 404 0
   172.21.0.1 - - [17/Jun/2026:12:59:28 +0000] "HEAD /403/ HTTP/1.1" 200 0
   172.21.0.1 - - [17/Jun/2026:12:59:28 +0000] "HEAD /en/403/ HTTP/1.1" 200 0
   172.21.0.1 - - [17/Jun/2026:12:59:30 +0000] "GET /this-page-does-not-exist/ HTTP/1.1" 404 12725
   ```
8. **GitHub:** label `agent:testing` applied on issue #48 at test start.
