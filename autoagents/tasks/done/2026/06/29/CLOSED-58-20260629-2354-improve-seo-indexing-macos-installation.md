---
## Closing summary (TOP)

- **What happened:** GitHub issue #58 requested improved SEO discoverability, a macOS web-app installation tutorial, and stronger privacy-first messaging.
- **What was done:** Added `robots.txt`, enhanced `SeoManager.astro` JSON-LD and meta, macOS tutorials in four locales, `PrivacyTrust.astro` landing section, FAQ and legal copy updates, and runbook operator steps (v1.1.90).
- **What was tested:** Docker build, HTTP smoke, robots.txt, sitemap, SEO metadata, privacy section, FAQ, legal policy, macOS tutorial, tutorials index, footer version, and production poll: all **PASS** (Search Console/Bing submission N/A, manual post-deploy).
- **Why closed:** All automated testing instructions passed; operator-only steps documented in runbook.
- **Closed at (UTC):** 2026-06-30 00:05
---

# Improve SEO indexing, macOS installation guidance, and privacy positioning

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/58
- **Number:** #58
- **Created:** 2026-06-29T23:34:30Z

## Problem / goal
Improve search discoverability for `km0digital`, add a macOS web-app installation tutorial, and strengthen privacy-first messaging on the marketing site.

## Implementation summary

### SEO / indexing
- Added `public/robots.txt` (Allow all, sitemap reference).
- Enhanced `src/components/SeoManager.astro`: Organization + WebSite + WebPage JSON-LD, `og:site_name`, robots meta, `application-name`.
- Updated home `meta.title` / `meta.description` in all four locales to include `km0digital` brand keyword.
- Documented Search Console and Bing Webmaster Tools operator steps in `docs/runbook.md`.

### macOS installation tutorial
- Extended tutorials schema with `macos` platform (`src/content.config.ts`).
- Added `getting-started-macos.md` in `src/content/tutorials/{es,ca,en,de}/` (Safari Add to Dock, Chromium PWA, manage/remove, troubleshooting).

### Privacy messaging
- New landing section `PrivacyTrust.astro` (`#privacy-trust`) with i18n copy in all locales.
- New FAQ item `data-privacy` in all locales.
- Privacy-first paragraph added to legal privacy policy section in all locales.
- README privacy and SEO notes.

## Site version
- `package.json`: **1.1.90**

## Testing instructions

1. **Build:** `docker compose build && docker compose up -d` (or `npm run build`).
2. **Em dash:** `./scripts/check-no-em-dash.sh` → OK.
3. **HTTP smoke:**
   - `curl -sI http://127.0.0.1:9180/` → 200
   - `curl -sI http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/de/` → 200
   - `curl -sI http://127.0.0.1:9180/doc/` → 200
4. **robots.txt:** `curl -s http://127.0.0.1:9180/robots.txt` → contains `Sitemap: https://km0digital.com/sitemap-index.xml`.
5. **Sitemap:** `curl -sI http://127.0.0.1:9180/sitemap-index.xml` → 200.
6. **SEO metadata (EN home):** View source at `/en/` → `<title>` contains `km0digital`, JSON-LD includes Organization/WebSite, canonical and hreflang present.
7. **Privacy section:** Open `/en/#privacy-trust` → privacy-first heading and body visible.
8. **FAQ:** Open `/en/#faq` → new question about data collection/profiling.
9. **Legal:** Open `/en/legal/#privacy` → privacy-first paragraph at top of policy.
10. **macOS tutorial:** `curl -sI http://127.0.0.1:9180/en/tutorials/getting-started-macos/` → 200; page lists Safari Add to Dock and Chromium PWA steps.
11. **Tutorials index:** `/en/tutorials/` lists four guides including macOS (platform badge `macos`).
12. **Footer version:** all locales show **1.1.90**.
13. **Operator (manual, post-deploy):** submit `https://km0digital.com/sitemap-index.xml` in Google Search Console and Bing Webmaster Tools per `docs/runbook.md`.

## Test report

1. **Date/time (UTC):** 2026-06-30T00:03:49Z – 2026-06-30T00:04:30Z. Log window: Docker/nginx from 00:04:02Z.
2. **Environment:** branch `main` @ `fabdf64` (uncommitted combined delivery for #56–#58); build via `docker compose build && docker compose up -d` (108 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** SEO/indexing, macOS tutorial, and privacy messaging per testing instructions: build, em dash, HTTP smoke, robots.txt, sitemap, EN home SEO metadata, privacy section, FAQ, legal policy, macOS tutorial, tutorials index, footer version, production poll.
4. **Results:**
   - Docker build & deploy: **PASS**
   - Em dash check: **PASS**
   - HTTP smoke (`/`, `/ca/`, `/en/`, `/de/`, `/doc/`): **PASS** (200)
   - `robots.txt` with `Sitemap: https://km0digital.com/sitemap-index.xml`: **PASS**
   - `/sitemap-index.xml` → 200: **PASS**
   - EN home `<title>` contains `km0digital`; JSON-LD Organization + WebSite; canonical + hreflang: **PASS**
   - `/en/#privacy-trust` section (`id="privacy-trust"`, privacy-first heading/body): **PASS**
   - FAQ data-privacy question (collect/sell/profile): **PASS**
   - `/en/legal/` privacy-first paragraph: **PASS**
   - macOS tutorial → 200; Safari Add to Dock + Chromium PWA steps: **PASS**
   - `/en/tutorials/` lists four guides with `macos` badge: **PASS**
   - Footer version **1.1.90** all locales: **PASS**
   - Operator Search Console/Bing submission: **N/A** (manual post-deploy per runbook)
   - Production `https://km0digital.com/` and `/en/tutorials/getting-started-macos/`: **PASS** (200 on first poll)
   - GitHub label `agent:testing` on issue #58: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/robots.txt`, `/sitemap-index.xml`, `/en/`, `/en/legal/`, `/en/tutorials/`, `/en/tutorials/getting-started-macos/`, `/ca/`, `/de/`, `/doc/`; `https://km0digital.com/`, `https://km0digital.com/en/tutorials/getting-started-macos/`.
7. **Log excerpts:**
   ```
   172.21.0.1 - - [30/Jun/2026:00:04:15 +0000] "GET /robots.txt HTTP/1.1" 200 77
   172.21.0.1 - - [30/Jun/2026:00:04:16 +0000] "GET /en/tutorials/getting-started-macos/ HTTP/1.1" 200 29028
   172.21.0.1 - - [30/Jun/2026:00:04:25 +0000] "HEAD /en/tutorials/getting-started-macos/ HTTP/1.1" 200 0
   ```
8. **GitHub:** label `agent:testing` applied on issue #58 at test start.

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md
