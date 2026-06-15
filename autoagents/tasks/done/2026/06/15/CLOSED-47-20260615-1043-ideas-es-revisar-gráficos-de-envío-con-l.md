---
## Closing summary (TOP)

- **What happened:** Issue #47 reported that social sharing graphics (Open Graph / preview images) still showed the old brand after logo and favicon updates.
- **What was done:** Regenerated PNG logo assets, added a 1200×630 `og-preview.png`, updated `Layout.astro` with og:image and Twitter card meta tags, and documented the asset in `docs/brand-tokens.md` (site v1.1.81).
- **What was tested:** Docker build, OG/PNG assets (dimensions + HTTP 200), share meta tags on home/locales/blog, smoke paths, footer version, and production readiness; all **PASS**.
- **Why closed:** All testing criteria passed; share previews now use the updated gradient pin logo on navy background.
- **Closed at (UTC):** 2026-06-15 10:47
---

# [ideas/es] Revisar gráficos de envío con logo actualizado

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/47
- **Number:** #47
- **Labels:** none
- **Created:** 2026-06-15T10:38:29Z

## Problem / goal
## Summary  The submitter reports that site logos and favicons were recently updated, but the social sharing graphics (Open Graph / preview images used when links are shared on WhatsApp, X, Discord, and similar platforms) may still show the old brand...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/47
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- Regenerated `public/brand/logo.png` (512×512) and `public/brand/logo-icon.png` (256×256) from the current centered `logo.svg` (gradient pin).
- Added `public/brand/og-preview.png` (1200×630, navy `#0B1220` background) for social crawlers (WhatsApp, X, Discord).
- Updated `src/layouts/Layout.astro`: `og:image` now points to `/brand/og-preview.png`; added `og:image:width`, `og:image:height`, `og:image:alt`, and Twitter card meta tags (`summary_large_image`).
- Documented the new asset in `docs/brand-tokens.md`.
- Site version bumped to **1.1.81**.

## Testing instructions
1. **Build & deploy:** `docker compose build && docker compose up -d`
2. **OG preview asset:** `http://127.0.0.1:9180/brand/og-preview.png` returns HTTP 200; image is 1200×630 with centered gradient pin on navy background.
3. **PNG fallbacks:** `/brand/logo.png` (512×512) and `/brand/logo-icon.png` (256×256) return HTTP 200; both show the current gradient pin logo.
4. **Meta tags (home):** `curl -s http://127.0.0.1:9180/ | grep og:image` shows `https://km0digital.com/brand/og-preview.png`; `twitter:card` is `summary_large_image`; `twitter:image` matches og:image.
5. **Meta tags (locales):** Repeat step 4 for `/ca/`, `/en/`, `/de/`; each locale page includes og:image and twitter:image pointing to og-preview.png.
6. **Blog index:** `/doc/` and `/en/doc/` include the same share-preview meta tags.
7. **Smoke paths:** `curl -sI` returns 200 for `/`, `/ca/`, `/en/`, `/de/`, `/doc/`.
8. **Footer version:** Page footer shows **1.1.81** on all locales.

## Test report

1. **Date/time (UTC):** 2026-06-15T10:45:32Z – 2026-06-15T10:46:00Z. Log window: Docker/nginx from 10:45:47Z.
2. **Environment:** branch `main` @ `794c5dc` (uncommitted working tree); build via `docker compose build && docker compose up -d` (`km0-web@1.1.81`, 88 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** OG preview asset and PNG fallbacks (HTTP + dimensions), share meta tags on home/locales/blog index, smoke paths, footer version, production readiness.
4. **Results:**
   - Docker build & deploy: **PASS** (`check-no-em-dash: OK`, 88 pages built)
   - OG preview asset HTTP 200, 1200×630 PNG: **PASS**
   - logo.png HTTP 200, 512×512 PNG: **PASS**
   - logo-icon.png HTTP 200, 256×256 PNG: **PASS**
   - Home meta: `og:image` → `https://km0digital.com/brand/og-preview.png`, `twitter:card` = `summary_large_image`, `twitter:image` matches: **PASS**
   - Locale meta (`/ca/`, `/en/`, `/de/`): og:image + twitter:image → og-preview.png: **PASS**
   - Blog index meta (`/doc/`, `/en/doc/`): same share-preview tags: **PASS**
   - Smoke paths HTTP 200 (`/`, `/ca/`, `/en/`, `/de/`, `/doc/`): **PASS**
   - Footer version **1.1.81** (ES Versión, CA Versió, EN/DE Version): **PASS**
   - Production readiness: **PASS** (`https://km0digital.com/` HTTP 200 on first poll; production og:image and twitter tags match)
   - GitHub label `agent:testing` on issue #47: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/`, `/brand/og-preview.png`, `/brand/logo.png`, `/brand/logo-icon.png`; `https://km0digital.com/`, `https://km0digital.com/brand/og-preview.png`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.81 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   10:45:46 [build] 88 page(s) built in 3.32s
   2026/06/15 10:45:47 [notice] 1#1: start worker processes
   172.21.0.1 - - [15/Jun/2026:10:45:51 +0000] "HEAD /brand/og-preview.png HTTP/1.1" 200 0
   172.21.0.1 - - [15/Jun/2026:10:45:53 +0000] "GET / HTTP/1.1" 200 49873
   172.21.0.1 - - [15/Jun/2026:10:45:53 +0000] "GET /doc/ HTTP/1.1" 200 18873
   ```
8. **GitHub:** label `agent:testing` applied on issue #47 at test start.
