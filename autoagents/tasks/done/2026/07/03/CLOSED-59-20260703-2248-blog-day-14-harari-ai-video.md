---
## Closing summary (TOP)

- **What happened:** GitHub issue #59 requested blog day 14 summarizing the Harari AI video discussion and its implications for KM0.
- **What was done:** Added `day-14.md` in es/ca/en/de with YouTube link and KM0 tie-in, updated day-13 forward links in all locales, and bumped site version to 1.1.91.
- **What was tested:** Docker build, footer version, day-14 routes (all locales), blog index ordering, per-locale titles and YouTube link, day-13 series links, em dash check, locale smoke, and production poll: all **PASS**.
- **Why closed:** All testing instructions and acceptance criteria passed.
- **Closed at (UTC):** 2026-07-03 22:53
---

# Blog day 14: Harari AI Video

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/59
- **Number:** #59
- **Labels:** none
- **Created:** 2026-07-03T22:47:33Z

## Problem / goal
Blog día 14.  Hemos visto y discutido un vídeo de harari sobre inteligencia artificial y de cómo entra en nuestro mundo y qué puede acabar haciendo. A continuación el resumen que hemos generado del video para añadirlo al blog:  Link del vídeo https:/...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/59
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- Added `src/content/doc/{es,ca,en,de}/day-14.md` (Harari AI video summary, KM0 tie-in, YouTube link).
- Updated day-13 closing paragraphs in all locales to link forward to day-14.
- Site version bumped to **1.1.91**.

## Testing instructions
1. `docker compose build && docker compose up -d` (or `npm run build` if Node available locally).
2. Confirm footer shows **Versión 1.1.91** / **Version 1.1.91** on `/` and `/en/`.
3. HTTP 200 on:
   - `/doc/day-14/` (ES)
   - `/ca/doc/day-14/`
   - `/en/doc/day-14/`
   - `/de/doc/day-14/`
4. Blog index lists day 14 as newest entry on `/doc/`, `/ca/doc/`, `/en/doc/`, `/de/doc/`.
5. Content checks per locale:
   - Title mentions Harari / IA / AI / KI.
   - YouTube link `https://www.youtube.com/watch?v=hBtVGwuJzpk` present and opens in new tab.
   - Internal links to day-13 and locale-prefixed paths work.
6. Day-13 closing on each locale mentions day-14 forward link.
7. `./scripts/check-no-em-dash.sh` passes.
8. Optional: `curl -sI http://127.0.0.1:9180/doc/day-14/` returns 200.

## Test report

1. **Date/time (UTC):** 2026-07-03T22:52:22Z – 2026-07-03T22:52:52Z. Log window: Docker/nginx from 22:52:39Z.
2. **Environment:** branch `main` @ `7aa31aa` (uncommitted delivery); build via `docker compose build && docker compose up -d` (112 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Day-14 Harari AI blog entry per testing instructions: Docker build/deploy, footer version, day-14 routes (all locales), blog index ordering, per-locale content (titles, YouTube link, day-13 links), day-13 forward links to day-14, em dash check, locale smoke, production readiness.
4. **Results:**
   - Docker build & deploy (112 pages, no errors): **PASS**
   - Footer version 1.1.91 on `/` and `/en/`: **PASS**
   - Day-14 routes (`/doc/day-14/`, `/ca/`, `/en/`, `/de/`): **PASS** (200)
   - Blog index lists day-14 first on `/doc/`, `/ca/doc/`, `/en/doc/`, `/de/doc/`: **PASS**
   - ES title mentions Harari/IA: **PASS** (`Día 14 - Harari, IA y el código de la civilización`)
   - CA title mentions Harari/IA: **PASS** (`Dia 14 - Harari, IA i el codi de la civilització`)
   - EN title mentions Harari/AI: **PASS** (`Day 14 - Harari, AI, and the code of civilization`)
   - DE title mentions Harari/KI: **PASS** (`Tag 14 - Harari, KI und der Code der Zivilisation`)
   - YouTube link present with `target="_blank"` and `rel="noopener noreferrer"` (all locales): **PASS**
   - Locale-prefixed day-13 internal links on day-14 pages: **PASS**
   - Day-13 closing forward link to day-14 (all locales): **PASS** (2 occurrences each)
   - Em dash check: **PASS**
   - Locale smoke (`/`, `/ca/`, `/en/`, `/de/`): **PASS** (200)
   - Production `https://km0digital.com/`: **PASS** (200 on first poll)
   - GitHub label `agent:testing` on issue #59: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/en/`, `/ca/`, `/de/`, `/doc/`, `/doc/day-14/`, `/ca/doc/day-14/`, `/en/doc/day-14/`, `/de/doc/day-14/`, `/ca/doc/`, `/en/doc/`, `/de/doc/`, `/doc/day-13/`, `/ca/doc/day-13/`, `/en/doc/day-13/`, `/de/doc/day-13/`; `https://km0digital.com/`.
7. **Log excerpts:**
   ```
   2026/07/03 22:52:39 [notice] 1#1: start worker processes
   172.21.0.1 - - [03/Jul/2026:22:52:45 +0000] "HEAD /doc/day-14/ HTTP/1.1" 200 0
   172.21.0.1 - - [03/Jul/2026:22:52:45 +0000] "HEAD /ca/doc/day-14/ HTTP/1.1" 200 0
   172.21.0.1 - - [03/Jul/2026:22:52:45 +0000] "HEAD /en/doc/day-14/ HTTP/1.1" 200 0
   172.21.0.1 - - [03/Jul/2026:22:52:45 +0000] "HEAD /de/doc/day-14/ HTTP/1.1" 200 0
   172.21.0.1 - - [03/Jul/2026:22:52:45 +0000] "GET / HTTP/1.1" 200 57479
   ```
8. **GitHub:** label `agent:testing` applied on issue #59 at test start.
