---
## Closing summary (TOP)

- **What happened:** GitHub issue #12 requested a localized Tutorials section for KM0 Cloud onboarding (web, Android, iOS).
- **What was done:** Added tutorials content collection, index/detail views, locale routes, i18n and header nav, Services links, and site version **1.1.20**.
- **What was tested:** Tester report **PASS**: Docker build (48 pages), tutorial HTTP smoke, Services/header/index/detail checks, footer version, locale switcher, production `/tutorials/` **200**.
- **Why closed:** All acceptance criteria and testing instructions passed.
- **Closed at (UTC):** 2026-06-01 14:44
---

# New "Tutorials" section for KM0 Cloud

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/12
- **Number:** #12
- **Labels:** none
- **Created:** 2026-06-01T14:39:39Z

## Problem / goal
Create a new Tutorials section (independent routes like Blog) with phase-1 guides for web, Android, and iOS KM0 Cloud onboarding, localized in es/ca/en/de, linked from the KM0 Cloud block in Services.

## Implementation summary
- Added `tutorials` content collection (`src/content.config.ts`) with 12 markdown entries (3 guides x 4 locales).
- New views: `TutorialIndex.astro`, `TutorialPost.astro`; routes under `/tutorials/` and locale prefixes.
- i18n strings and nav link (`Tutoriales` / `Tutorials`) in all four locale files.
- `Services.astro`: link to web tutorial inside KM0 Cloud card + section-level tutorials CTA.
- Helpers: `src/lib/tutorial.ts`, `tutorialPostHref()` in `paths.ts`.
- Site version bumped to **1.1.20**.

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Testing instructions

1. **Build:** `docker compose build && docker compose up -d` (build passed: 48 pages).
2. **HTTP smoke (expect 200):**
   - `curl -sI http://127.0.0.1:9180/tutorials/`
   - `curl -sI http://127.0.0.1:9180/tutorials/getting-started-web/`
   - `curl -sI http://127.0.0.1:9180/ca/tutorials/`
   - `curl -sI http://127.0.0.1:9180/en/tutorials/getting-started-android/`
   - `curl -sI http://127.0.0.1:9180/de/tutorials/getting-started-ios/`
3. **Homepage Services (#services):** KM0 Cloud card shows "Primeros pasos en el navegador" (or locale equivalent) linking to web tutorial; section footer shows tutorials CTA.
4. **Header nav:** "Tutoriales" / "Tutorials" item links to locale tutorials index.
5. **Tutorial index:** lists 3 guides per locale in order (web, Android, iOS).
6. **Tutorial detail:** step-by-step content, store links on mobile guides, cross-links to web tutorial, common problems section on all three.
7. **Footer version:** `curl -s http://127.0.0.1:9180/ | grep -o 'Versión [0-9.]*'` shows **1.1.20**.
8. **Locale switcher:** on `/en/tutorials/getting-started-web/`, switch to ES and confirm equivalent slug loads.

## Test report

1. **Date/time (UTC):** 2026-06-01T14:43:14Z – 2026-06-01T14:43:41Z. Log window: Docker/nginx from 14:43:27Z through HTTP checks at 14:43:40Z.
2. **Environment:** branch `main` (uncommitted tutorials worktree); build via `docker compose build && docker compose up -d` (48 pages, `km0-web@1.1.20`). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Docker build/deploy, tutorial HTTP smoke (task list + standard locale/doc paths), Services KM0 Cloud links, header nav, tutorial index order, tutorial detail content, footer version, locale switcher slug parity, production poll.
4. **Results:**
   - Docker build/up (48 pages): **PASS** (`[build] 48 page(s) built in 2.33s`)
   - HTTP smoke tutorials paths: **PASS** (all `HTTP/1.1 200 OK`: `/tutorials/`, `/tutorials/getting-started-web/`, `/ca/tutorials/`, `/en/tutorials/getting-started-android/`, `/de/tutorials/getting-started-ios/`)
   - Standard smoke `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`: **PASS** (all `200`)
   - Services #services KM0 Cloud card + CTA: **PASS** (`Primeros pasos en el navegador` → `/tutorials/getting-started-web/`; footer `Consulta los tutoriales de KM0 Cloud` → `/tutorials/`)
   - Header nav Tutoriales/Tutorials: **PASS** (`href="/tutorials/"` on ES homepage)
   - Tutorial index order (web, Android, iOS): **PASS** (href order on `/tutorials/`)
   - Tutorial detail (steps, store links, web cross-link, problems section): **PASS** (EN Android: `play.google.com`, `getting-started-web`, `Common problems`; DE iOS: `apps.apple.com`; ES web: `Problemas frecuentes`; EN web: `Step 1`–`Step 3`)
   - Footer version **1.1.20**: **PASS** (`Versión 1.1.20` on `/`)
   - Locale switcher ES slug: **PASS** (EN page ES switch `href="/tutorials/getting-started-web/"` returns `200`)
   - Production readiness: **PASS** (`https://km0digital.com/tutorials/` returned `200` on first poll; no sleep loop needed)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/tutorials/`, `/tutorials/getting-started-web/`, `/ca/tutorials/`, `/en/tutorials/getting-started-android/`, `/de/tutorials/getting-started-ios/`, `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`; `https://km0digital.com/`, `https://km0digital.com/tutorials/`.
7. **Log excerpts:**
   - `14:43:26 [build] 48 page(s) built in 2.33s`
   - `172.19.0.1 - - [01/Jun/2026:14:43:30 +0000] "HEAD /tutorials/ HTTP/1.1" 200`
   - `172.19.0.1 - - [01/Jun/2026:14:43:30 +0000] "HEAD /en/tutorials/getting-started-android/ HTTP/1.1" 200`
   - `172.19.0.1 - - [01/Jun/2026:14:43:40 +0000] "GET /tutorials/getting-started-web/ HTTP/1.1" 200 14672`
8. **GitHub:** label `agent:testing` applied on issue #12 at test start.
