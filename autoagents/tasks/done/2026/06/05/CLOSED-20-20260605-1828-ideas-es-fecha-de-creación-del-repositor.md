---
## Closing summary (TOP)

- **What happened:** Issue #20 requested showing the GitHub repository creation date in the km0digital.com site footer.
- **What was done:** Added `src/lib/repo-created-at.ts`, updated `Footer.astro` with a localized "repository since" line (all four locales), and bumped the site version to 1.1.38.
- **What was tested:** Tester report **PASS**: Docker build (68 pages), footer repo-since line on ES/EN/CA/DE, GitHub link attributes, HTTP 200 smoke paths, and production poll at km0digital.com.
- **Why closed:** All testing criteria passed; implementation matches the issue goal.
- **Closed at (UTC):** 2026-06-05 18:30
---

# [ideas/es] Fecha de creación del repositorio en el footer

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/20
- **Number:** #20
- **Labels:** none
- **Created:** 2026-06-05T18:24:14Z

## Problem / goal
## Summary  Ralf suggests showing the GitHub repository creation date in the km0digital.com site footer. The goal is to surface when the project repository was first created, alongside existing footer information. Implementation details (static value...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/20
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- Added `src/lib/repo-created-at.ts` with the GitHub repo creation instant (`2026-05-22T13:37:45Z`) and repo URL.
- Updated `src/components/Footer.astro` to show a localized "repository since" line below the version label; the formatted date links to the GitHub repo.
- Added `footer.repoSince` i18n key in `es.json`, `ca.json`, `en.json`, `de.json`, and `src/i18n/types.ts`.
- Reuses `formatDocDate()` from `src/lib/doc.ts` for locale-aware long date formatting.
- Site version bumped to **1.1.38**.

## Testing instructions
1. Rebuild and deploy: `docker compose build && docker compose up -d`
2. **Footer (ES `/`):** Center column shows `Versión 1.1.38`, then `Repositorio desde 22 de mayo de 2026` (date links to `https://github.com/AMVARA-CONSULTING/km0-web`).
3. **Locales:** Spot-check `/en/` (`Repository since 22 May 2026`), `/ca/` (`Repositori des de 22 de maig del 2026`), `/de/` (`Repository seit 22. Mai 2026`).
4. **GitHub link:** Click the formatted date → opens the repo in a new tab; existing **GitHub** nav link on the right still works.
5. **Layout:** Footer keeps 3-column grid on desktop; new line sits below version without breaking alignment.
6. Verify HTTP 200: `curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/de/ http://127.0.0.1:9180/doc/`
7. Footer version shows **1.1.38** on all locales.

## Test report

1. **Date/time (UTC):** 2026-06-05T18:29:37Z – 2026-06-05T18:29:58Z. Log window: nginx access logs from 18:29:56Z through 18:29:58Z.
2. **Environment:** branch `main` @ `a5b7c4a` (uncommitted local WIP for issue #20); build via `docker compose build && docker compose up -d` (`km0-web@1.1.38`, 68 pages). Host has no `npm` on PATH; Docker build is authoritative. URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Docker build/deploy, footer repo-since line all locales (ES/EN/CA/DE), version label, GitHub date link attributes (`target="_blank"`, `rel="noopener noreferrer"`), right-column GitHub nav link, 3-column grid layout class, standard smoke paths, production poll for footer content and version.
4. **Results:**
   - Docker build/up (68 pages, em-dash check OK): **PASS** (`[build] 68 page(s) built in 3.03s`; both containers Up)
   - Footer ES `/`: **PASS** (`Versión 1.1.38`, `Repositorio desde 22 de mayo de 2026`, date links to `https://github.com/AMVARA-CONSULTING/km0-web`)
   - Footer EN `/en/`: **PASS** (`Version 1.1.38`, `Repository since 22 May 2026`)
   - Footer CA `/ca/`: **PASS** (`Versió 1.1.38`, `Repositori des de 22 de maig del 2026`)
   - Footer DE `/de/`: **PASS** (`Version 1.1.38`, `Repository seit 22. Mai 2026`)
   - GitHub date link opens in new tab: **PASS** (`target="_blank" rel="noopener noreferrer"` on date anchor)
   - Right-column GitHub nav link: **PASS** (separate `<nav>` link to same repo URL, label `GitHub`)
   - Footer 3-column grid layout: **PASS** (`md:grid-cols-3` present; repo-since line below version in center column)
   - HTTP 200 smoke paths `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`: **PASS** (all `HTTP/1.1 200 OK`)
   - Footer version **1.1.38** all locales: **PASS** (ES `Versión`, CA `Versió`, EN/DE `Version`)
   - Production readiness: **PASS** (`https://km0digital.com/` returned `200` on first poll; ES footer shows `Versión 1.1.38` and `Repositorio desde 22 de mayo de 2026`; EN shows `Repository since 22 May 2026`)
   - GitHub label `agent:testing` on issue #20: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`; `https://km0digital.com/`, `https://km0digital.com/en/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.38 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   18:29:49 [build] 68 page(s) built in 3.03s
   172.21.0.1 - - [05/Jun/2026:18:29:56 +0000] "HEAD / HTTP/1.1" 200 0
   172.21.0.1 - - [05/Jun/2026:18:29:56 +0000] "HEAD /en/ HTTP/1.1" 200 0
   172.21.0.1 - - [05/Jun/2026:18:29:56 +0000] "GET / HTTP/1.1" 200 43716
   172.21.0.1 - - [05/Jun/2026:18:29:56 +0000] "GET /en/ HTTP/1.1" 200 43349
   ```
8. **GitHub:** label `agent:testing` applied on issue #20 at test start.
