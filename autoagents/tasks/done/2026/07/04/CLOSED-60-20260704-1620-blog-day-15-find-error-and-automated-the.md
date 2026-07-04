---
## Closing summary (TOP)

- **What happened:** GitHub issue #60 requested a day-15 blog post explaining the register-api Graph token expiry incident and automated fix from the sibling km0-opencloud project (issue #17).
- **What was done:** Added `day-15.md` in ES, CA, EN, and DE under `src/content/doc/`, updated day-14 closing paragraphs with forward links to day-15, and bumped site version to 1.1.92.
- **What was tested:** Tester report PASS: Docker build (116 pages), footer 1.1.92, day-15 routes and blog index in all locales, per-locale content (titles, issue #17, incident date, GRAPH_SERVICE_USER and health-wait fixes), day-14 forward links, em dash check, locale smoke, and production URLs.
- **Why closed:** All testing instructions passed; no failures reported.
- **Closed at (UTC):** 2026-07-04 16:24
---

# Blog day 15, find error and automated the fix

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/60
- **Number:** #60
- **Labels:** none
- **Created:** 2026-07-04T16:19:19Z

## Problem / goal
Añade la explicación de lo hecho en el último issue y el motivo, del proyecto hermano /opt/opencloud/, al día 15 del blog

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/60
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md
- Sibling project: https://github.com/AMVARA-CONSULTING/km0-opencloud/issues/17

## Implementation summary
- Added `src/content/doc/{es,ca,en,de}/day-15.md` documenting the register-api Graph token expiry incident, km0-opencloud issue #17 (rotation + auto-renewal), and post-test fixes (`GRAPH_SERVICE_USER` propagation, health wait before verify).
- Updated day-14 closing paragraphs in all locales to link forward to day-15.
- Site version bumped to **1.1.92**.

## Testing instructions
1. `docker compose build && docker compose up -d` (or `npm run build` if Node available locally).
2. Confirm footer shows **Versión 1.1.92** / **Version 1.1.92** on `/` and `/en/`.
3. HTTP 200 on:
   - `/doc/day-15/` (ES)
   - `/ca/doc/day-15/`
   - `/en/doc/day-15/`
   - `/de/doc/day-15/`
4. Blog index lists day 15 as newest entry on `/doc/`, `/ca/doc/`, `/en/doc/`, `/de/doc/`.
5. Content checks per locale:
   - Title mentions register-api / Graph token / token Graph / Graph-Token.
   - References km0-opencloud issue #17 and the 2026-07-04 registration incident.
   - Sections cover: incident, why token is needed, rotation/auto-renewal, errors found (GRAPH_SERVICE_USER + health wait), safety boundaries.
   - Internal links to day-14 and locale-prefixed paths work.
6. Day-14 closing on each locale mentions day-15 forward link.
7. `./scripts/check-no-em-dash.sh` passes.
8. Optional: `curl -sI http://127.0.0.1:9180/doc/day-15/` returns 200.

## Test report

1. **Date/time (UTC):** 2026-07-04T16:23:39Z – 2026-07-04T16:24:00Z. Log window: Docker/nginx from 16:23:50Z.
2. **Environment:** branch `main` @ `f0f5715` (uncommitted delivery); build via `docker compose build && docker compose up -d` (116 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Day-15 register-api Graph token blog entry per testing instructions: Docker build/deploy, footer version, day-15 routes (all locales), blog index ordering, per-locale content (titles, issue #17, incident date, register-api, GRAPH_SERVICE_USER, TOC sections), day-14 forward links to day-15, em dash check, locale smoke, production readiness.
4. **Results:**
   - Docker build & deploy (116 pages, no errors): **PASS**
   - Footer version 1.1.92 on `/` and `/en/`: **PASS**
   - Day-15 routes (`/doc/day-15/`, `/ca/`, `/en/`, `/de/`): **PASS** (200)
   - Blog index lists day-15 first on `/doc/`, `/ca/doc/`, `/en/doc/`, `/de/doc/`: **PASS**
   - ES title mentions register-api / token Graph: **PASS** (`Día 15 - Registro OpenCloud: token Graph caducado y renovación automática`)
   - CA title mentions register-api / token Graph: **PASS** (`Dia 15 - Registre OpenCloud: token Graph caducat i renovació automàtica`)
   - EN title mentions register-api / Graph token: **PASS** (`Day 15 - OpenCloud registration: expired Graph token and automated renewal`)
   - DE title mentions register-api / Graph-Token: **PASS** (`Tag 15 - OpenCloud-Registrierung: abgelaufenes Graph-Token und Auto-Erneuerung`)
   - km0-opencloud issue #17 referenced (all locales): **PASS**
   - 2026-07-04 registration incident date (all locales): **PASS**
   - Sections: Incident, Why, Implementation, Errors found, Boundaries (TOC + body): **PASS**
   - GRAPH_SERVICE_USER and health-wait fixes documented (all locales): **PASS**
   - Locale-prefixed day-14 internal links on day-15 pages: **PASS**
   - Day-14 closing forward link to day-15 (all locales): **PASS**
   - Em dash check: **PASS**
   - Locale smoke (`/`, `/ca/`, `/en/`, `/de/`): **PASS** (200)
   - Production `https://km0digital.com/` and `/en/doc/day-15/`: **PASS** (200 on first poll; footer shows 1.1.92)
   - GitHub label `agent:testing` on issue #60: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/en/`, `/ca/`, `/de/`, `/doc/`, `/doc/day-15/`, `/ca/doc/day-15/`, `/en/doc/day-15/`, `/de/doc/day-15/`, `/ca/doc/`, `/en/doc/`, `/de/doc/`, `/doc/day-14/`, `/ca/doc/day-14/`, `/en/doc/day-14/`, `/de/doc/day-14/`; `https://km0digital.com/`, `https://km0digital.com/en/doc/day-15/`.
7. **Log excerpts:**
   ```
   2026/07/04 16:23:50 [notice] 1#1: start worker processes
   172.21.0.1 - - [04/Jul/2026:16:23:52 +0000] "GET / HTTP/1.1" 200 57479
   172.21.0.1 - - [04/Jul/2026:16:23:52 +0000] "GET /en/ HTTP/1.1" 200 56921
   172.21.0.1 - - [04/Jul/2026:16:23:53 +0000] "GET /doc/ HTTP/1.1" 200 26159
   172.21.0.1 - - [04/Jul/2026:16:23:53 +0000] "GET /ca/doc/ HTTP/1.1" 200 26241
   172.21.0.1 - - [04/Jul/2026:16:23:53 +0000] "GET /en/doc/ HTTP/1.1" 200 25789
   172.21.0.1 - - [04/Jul/2026:16:23:53 +0000] "GET /de/doc/ HTTP/1.1" 200 26134
   ```
8. **GitHub:** label `agent:testing` applied on issue #60 at test start.
