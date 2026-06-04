---
## Closing summary (TOP)

- **What happened:** Issue #18 reported that the `/ideas/` page was unreachable from desktop header and mobile navigation.
- **What was done:** Added an `ideas` nav item to `Header.astro` with locale labels in all four i18n files; links use `localeHref` for `/ideas/` paths. Site version bumped to 1.1.26.
- **What was tested:** Docker build/deploy, footer version, desktop and mobile Ideas links on all locale homes and on `/ideas/`, HTTP 200 on ideas pages, production spot-check. All criteria **PASS**.
- **Why closed:** All testing instructions passed; navigation restored for desktop and mobile across ES, CA, EN, and DE.
- **Closed at (UTC):** 2026-06-04 17:47
---

# [ideas/es] /ideas/ no visible en header ni menú móvil

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/18
- **Number:** #18
- **Labels:** none
- **Created:** 2026-06-04T17:39:37Z

## Problem / goal
## Summary  The submitter appreciates the new `/ideas/` page but cannot reach it from site navigation. The link is missing from the desktop header or navbar and from the mobile hamburger menu. They ask the team to add or restore navigation so the pub...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/18
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation notes
- Added `ideas` nav item to `Header.astro` (desktop `<ul>` and mobile `#mobile-nav` share the same `nav` array).
- Locale labels: `nav.ideas` in `es.json`, `ca.json`, `en.json`, `de.json`; type in `src/i18n/types.ts`.
- Links use `localeHref(locale, '/ideas/')` (`/ideas/`, `/ca/ideas/`, etc.).
- Site version bumped: **1.1.26**.

## Testing instructions
1. `docker compose build && docker compose up -d` (or `npm run build` if Node available locally).
2. Confirm footer shows **1.1.26** on `/`.
3. For each locale home (`/`, `/ca/`, `/en/`, `/de/`):
   - Desktop (viewport ≥ md): header shows Ideas / Idees / Ideen link between Blog and FAQ.
   - Link `href` is `/ideas/`, `/ca/ideas/`, `/en/ideas/`, or `/de/ideas/` respectively; returns **200**.
4. Mobile (viewport &lt; md): open hamburger menu; same Ideas link appears in the panel; tap navigates to the locale ideas page and closes the menu.
5. On `/ideas/`, open mobile menu and confirm Ideas link is present (active page still listed).
6. Optional: `curl -s http://127.0.0.1:9180/ | grep -c '/ideas/'` should be ≥ 2 (desktop + mobile).

## Test report

**Date/time (UTC):** 2026-06-04T17:45:55Z – 2026-06-04T17:46:16Z  
**Log window:** nginx access/error logs from container start (17:46:07Z) through test curls (17:46:15Z)

### Environment

- **Branch:** `main`
- **Build:** `docker compose build && docker compose up -d` (Astro 1.1.26 inside Docker; local `npm` unavailable)
- **URLs:** loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`

### What was tested

Per **Testing instructions** above: Docker build/deploy, footer version, desktop/mobile nav Ideas link on all four locale homes, ideas page HTTP status, nav order (Blog → Ideas → FAQ), mobile nav presence on `/ideas/`, standard doc paths, production spot-check.

### Results

| Criterion | Result | Evidence |
|-----------|--------|----------|
| Docker build + up | **PASS** | Image built (52 pages); container `km0-web` Up on 127.0.0.1:9180 |
| Footer version 1.1.26 on `/` | **PASS** | `curl -s … \| grep` → `Versión 1.1.26` |
| ES desktop nav: Ideas between Blog and FAQ | **PASS** | HTML order: Blog → Ideas → FAQ; `href="/ideas/"` |
| CA desktop nav: Idees | **PASS** | `href="/ca/ideas/"` → Idees; HTTP 200 |
| EN desktop nav: Ideas | **PASS** | `href="/en/ideas/"` → Ideas; HTTP 200 |
| DE desktop nav: Ideen | **PASS** | `href="/de/ideas/"` → Ideen; HTTP 200 |
| Ideas pages return 200 | **PASS** | `/ideas/`, `/ca/ideas/`, `/en/ideas/`, `/de/ideas/` all HTTP 200 |
| Mobile nav: Ideas link present (all locales) | **PASS** | `data-mobile-nav-link` + correct locale href on each home page |
| Mobile nav on `/ideas/` page | **PASS** | Ideas link present in `#mobile-nav` panel |
| Mobile menu close on link click | **PASS** | Client script binds `click` on `[data-mobile-nav-link]` → `setOpen(false)` |
| Optional: `/ideas/` occurrence count ≥ 2 | **PASS** | `grep -o '/ideas/' \| wc -l` → 2 on ES home |
| Standard paths (/, /ca/, /en/, /de/, /doc/, /en/doc/day-0/) | **PASS** | All HTTP 200 |
| Production nav spot-check | **PASS** | `https://km0digital.com/` HTTP 200; desktop + mobile Ideas links present |

### Overall

**PASS**

### URLs tested

- http://127.0.0.1:9180/
- http://127.0.0.1:9180/ca/
- http://127.0.0.1:9180/en/
- http://127.0.0.1:9180/de/
- http://127.0.0.1:9180/ideas/
- http://127.0.0.1:9180/ca/ideas/
- http://127.0.0.1:9180/en/ideas/
- http://127.0.0.1:9180/de/ideas/
- http://127.0.0.1:9180/doc/
- http://127.0.0.1:9180/en/doc/day-0/
- https://km0digital.com/

### Log excerpts

```
2026/06/04 17:46:07 [notice] 1#1: start worker processes
172.21.0.1 - - [04/Jun/2026:17:46:11 +0000] "GET / HTTP/1.1" 200 43944
172.21.0.1 - - [04/Jun/2026:17:46:11 +0000] "GET /ca/ HTTP/1.1" 200 43970
172.21.0.1 - - [04/Jun/2026:17:46:11 +0000] "GET /en/ HTTP/1.1" 200 43602
172.21.0.1 - - [04/Jun/2026:17:46:12 +0000] "GET /de/ HTTP/1.1" 200 44268
172.21.0.1 - - [04/Jun/2026:17:46:12 +0000] "GET /ideas/ HTTP/1.1" 200 14710
172.21.0.1 - - [04/Jun/2026:17:46:15 +0000] "HEAD /doc/ HTTP/1.1" 200 0
172.21.0.1 - - [04/Jun/2026:17:46:15 +0000] "HEAD /en/doc/day-0/ HTTP/1.1" 200 0
```
