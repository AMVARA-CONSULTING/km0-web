---
## Closing summary (TOP)

- **What happened:** GitHub issue #42 requested the day-11 blog post covering KM0 Mail in production, skipping the unpublished day-10 entry.
- **What was done:** Added `day-11.md` in ES/EN/CA/DE, updated day-9 closing links to point forward to day-11, and bumped the site version.
- **What was tested:** Docker build (88 pages), blog index and day-11 routes in four locales, day-9 forward link and prev/next navigation, TOC sections, footer version, em dash check, and no secrets in content. Overall **PASS**.
- **Why closed:** All testing criteria passed; production poll returned HTTP 200.
- **Closed at (UTC):** 2026-06-14 13:32
---

# Blog día 11: KM0 Mail en producción (saltamos el día 10)

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/42
- **Number:** #42
- **Labels:** documentation
- **Created:** 2026-06-14T13:17:31Z

## Problem / goal
## Contexto  El [día 9](/doc/day-9/) cubrió precios, legal, registro OpenCloud y conversión. **No publicamos entrada del día 10** (actividad interna / despliegue mail sin artículo). La siguiente entrada de la serie debe ser **día 11**, enlazando desd...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/42
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary

- Added `src/content/doc/{es,en,ca,de}/day-11.md` with KM0 Mail production article (stack, DNS, OpenCloud relay, product decisions, phase 1b roadmap, verification commands, flow diagram).
- Updated closing block in all four `day-9.md` files to link forward to day-11 (skipping day-10).
- Site version bumped: 1.1.77 → 1.1.78.

## Testing instructions

1. **Build:** `docker compose build && docker compose up -d` (88 pages, no errors).
2. **Blog index:** `curl -sI http://127.0.0.1:9180/doc/` → 200; day-11 appears in listing.
3. **Day 11 routes:** verify 200 on `/doc/day-11/`, `/en/doc/day-11/`, `/ca/doc/day-11/`, `/de/doc/day-11/`.
4. **Day 9 link:** open `/doc/day-9/` and confirm closing block links to `/doc/day-11/` (no day-10).
5. **Navigation:** on day-9, "Entrada siguiente" → day-11; on day-11, "Entrada anterior" → day-9.
6. **TOC:** day-11 page shows sections (Introducción, Resumen, KM0 Mail, DNS, OpenCloud, Producto, Roadmap, Verificación, Serie).
7. **Footer:** home page shows version 1.1.78.
8. **Em dash:** `./scripts/check-no-em-dash.sh` → OK.
9. **No secrets:** grep day-11 files for passwords/tokens → none.

## Test report

1. **Date/time (UTC):** 2026-06-14T13:31:10Z – 2026-06-14T13:31:39Z. Log window: Docker/nginx from 13:31:19Z.
2. **Environment:** branch `main` @ `00dcd50` (uncommitted working tree); build via `docker compose build && docker compose up -d` (`km0-web@1.1.79`, 88 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Docker build/deploy, blog index day-11 listing, day-11 routes (4 locales), day-9 forward link (skip day-10), article navigation prev/next, day-11 TOC sections, footer version, em dash check, secrets grep, production poll.
4. **Results:**
   - Docker build & deploy (88 pages): **PASS**
   - Blog index `/doc/` HTTP 200 + day-11 in listing: **PASS**
   - Day 11 routes ES/EN/CA/DE HTTP 200: **PASS**
   - Day 9 closing links to `/doc/day-11/` (0 day-10 refs): **PASS**
   - Navigation day-9 next → day-11, day-11 prev → day-9: **PASS**
   - TOC sections (Introducción, Resumen, KM0 Mail, DNS, OpenCloud, Producto, Roadmap, Verificación, Serie): **PASS**
   - Footer version: **PASS** (`Versión 1.1.79`; cumulative bump from tasks #43/#44, supersedes coder note 1.1.78)
   - Em dash check: **PASS** (`check-no-em-dash: OK`)
   - No secrets in day-11 files: **PASS**
   - Production readiness: **PASS** (`https://km0digital.com/` HTTP 200 on first poll)
   - GitHub label `agent:testing` on issue #42: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/doc/`, `/doc/day-11/`, `/en/doc/day-11/`, `/ca/doc/day-11/`, `/de/doc/day-11/`, `/doc/day-9/`; `https://km0digital.com/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.79 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   13:31:18 [build] 88 page(s) built in 3.32s
   2026/06/14 13:31:19 [notice] 1#1: start worker processes
   172.21.0.1 - - [14/Jun/2026:13:31:22 +0000] "HEAD /doc/day-11/ HTTP/1.1" 200 0
   172.21.0.1 - - [14/Jun/2026:13:31:22 +0000] "HEAD /doc/day-9/ HTTP/1.1" 200 0
   ```
8. **GitHub:** label `agent:testing` applied on issue #42 at test start.
