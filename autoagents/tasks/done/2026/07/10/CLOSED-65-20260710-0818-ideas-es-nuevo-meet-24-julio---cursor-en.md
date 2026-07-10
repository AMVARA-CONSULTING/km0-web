---
## Closing summary (TOP)

- **What happened:** GitHub issue #65 requested a new July 24 MEet event about Cursor at Casino de Masnou, without removing the existing July 10 event.
- **What was done:** Added `cursor-masnou-jul24-2026` in `src/lib/meetings.ts`, localized copy in all four i18n files with Cursor context links, updated `MeetingEventCard.astro` to render topic HTML, and bumped site version to 1.1.98.
- **What was tested:** Docker build/deploy, meeting routes and calendar (days 10 and 24) on all locales, both events unchanged/new content verified, footer version, em dash check, and production URLs; overall **PASS**.
- **Why closed:** All testing criteria passed.
- **Closed at (UTC):** 2026-07-10 08:24
---

# [ideas/es] Nuevo MEet 24 julio - Cursor en Casino de Masnou

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/65
- **Number:** #65
- **Labels:** none
- **Created:** 2026-07-10T08:14:12Z

## Problem / goal
## Summary  The submitter asks to add a new MEet event for July 24 without removing any existing event. The session topic is how Cursor works, with contextual links included. The meeting location is the Casino de Masnou, preferably with a Google Maps...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/65
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- Added `cursor-masnou-jul24-2026` event in `src/lib/meetings.ts` (2026-07-24, 18:30, Casino del Masnou, Google Maps link, casinomasnou.com website).
- Kept existing `masnou-jul-2026` event (10 July, Bar Pekin) unchanged.
- Added localized copy in all four i18n files (`meeting.events.cursor-masnou-jul24-2026`) with Cursor context links (cursor.com, docs.cursor.com, blog).
- Updated `MeetingEventCard.astro` to render topic HTML so contextual links display in upcoming cards (calendar detail already supported HTML).
- Site version bumped to **1.1.98**.

## Testing instructions
1. `docker compose build && docker compose up -d` (or `npm run build` if Node available locally).
2. Confirm footer shows **Versión 1.1.98** / **Version 1.1.98** on `/` and `/en/`.
3. HTTP 200 on `/meeting/`, `/ca/meeting/`, `/en/meeting/`, `/de/meeting/`.
4. Upcoming events list shows **two** events (10 Jul and 24 Jul) on all locales.
5. July 10 event still shows Bar Pekin / Harari / Palantir topic (unchanged).
6. July 24 event checks per locale:
   - Title mentions Cursor (localized).
   - Location: Casino del Masnou, Carrer de Barcelona, 1.
   - Maps link opens Google Maps for Casino del Masnou.
   - Venue website link: casinomasnou.com.
   - Topic includes clickable links to cursor.com, docs.cursor.com, and cursor.com/blog.
7. Calendar: navigate to July 2026; days **10** and **24** are highlighted. Click each day to verify detail panel content.
8. `./scripts/check-no-em-dash.sh` passes.
9. Optional: `curl -sI http://127.0.0.1:9180/meeting/` returns 200.

## Test report

1. **Date/time (UTC):** 2026-07-10T08:22:21Z – 2026-07-10T08:23:15Z. Log window: Docker/nginx from 08:22:49Z.
2. **Environment:** branch `main` @ `5a21f2e`; build via `docker compose build && docker compose up -d` (124 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** New July 24 Cursor MEet event (all locales), existing July 10 event unchanged, meeting calendar (days 10 and 24), footer version, em dash check, locale smoke, production readiness.
4. **Results:**
   - Docker build & deploy (124 pages, no errors): **PASS**
   - Footer version 1.1.98 on `/` and `/en/`: **PASS** (`Versión 1.1.98`, `Version 1.1.98`)
   - Meeting routes (`/meeting/`, `/ca/meeting/`, `/en/meeting/`, `/de/meeting/`): **PASS** (200)
   - Two upcoming events per locale (10 Jul + 24 Jul): **PASS** (2 `data-meeting-event-id` cards each)
   - July 10 event Bar Pekin / Harari / Palantir unchanged (ES/CA/EN/DE): **PASS**
   - July 24 Cursor event per locale (title, Casino del Masnou, Carrer de Barcelona 1, maps, casinomasnou.com, cursor.com/docs/blog links): **PASS** (ES/CA/EN/DE)
   - Calendar payload includes 2026-07-10 and 2026-07-24 with `meeting-calendar-cell-has-event` rendering: **PASS** (verified via embedded JSON payload and JS logic)
   - Em dash check: **PASS**
   - Locale smoke (`/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`): **PASS** (200)
   - Production `https://km0digital.com/`, `/meeting/`, `/en/meeting/`: **PASS** (200 on first poll; footer `Versión 1.1.98`; both event IDs present)
   - GitHub label `agent:testing` on issue #65: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`, `/meeting/`, `/ca/meeting/`, `/en/meeting/`, `/de/meeting/`; `https://km0digital.com/`, `https://km0digital.com/meeting/`, `https://km0digital.com/en/meeting/`.
7. **Log excerpts:**
   ```
   2026/07/10 08:22:49 [notice] 1#1: start worker processes
   127.0.0.1 - - [10/Jul/2026:08:22:49 +0000] "GET / HTTP/1.1" 200 57833 "-" "Wget" "-"
   172.21.0.1 - - [10/Jul/2026:08:22:54 +0000] "GET /meeting/ HTTP/1.1" 200 28056 "-" "curl/8.14.1" "-"
   172.21.0.1 - - [10/Jul/2026:08:22:54 +0000] "GET /en/meeting/ HTTP/1.1" 200 27877 "-" "curl/8.14.1" "-"
   ```
8. **GitHub:** label `agent:testing` applied on issue #65 at test start.
