---
## Closing summary (TOP)

- **What happened:** An ideas submission requested a new blog post on AI in bureaucracy (Harari, Palantir) and a matching calendar event at Bar Pekin, Masnou.
- **What was done:** Added day-16 blog posts in all four locales, updated the July 2026 meeting entry (Bar Pekin venue, topic, maps link), and forward-linked day-15 to day-16; site version bumped to 1.1.97.
- **What was tested:** Docker build, all locale routes, blog index ordering, meeting calendar content, day-15 forward links, footer version, em dash check, and production smoke on km0digital.com; all PASS.
- **Why closed:** All testing criteria passed; implementation matches the issue scope.
- **Closed at (UTC):** 2026-07-09 19:21
---

# [ideas/es] Blog y calendario: IA, Harari, Palantir, Bar Pekin

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/64
- **Number:** #64
- **Labels:** none
- **Created:** 2026-07-09T19:14:13Z

## Problem / goal
## Summary  The submitter asks for a new blog post announcing a discussion about AI in bureaucracy, inspired by Harari, and about the company Palantir. They also want the related calendar event updated to match that topic and venue: Bar Pekin in Masn...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/64
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- Added `src/content/doc/{es,ca,en,de}/day-16.md` announcing the 10 July 2026 meetup at Bar Pekin (Palacio de Pekín), Passeig Prat de la Riba 25, El Masnou, on AI in bureaucracy (Harari) and Palantir.
- Updated `src/lib/meetings.ts`: maps URL to Bar Pekin address; removed Casino Masnou website link.
- Updated `meeting.events.masnou-jul-2026` in all four i18n locale files (title, location, topic).
- Updated day-15 closing paragraphs in all locales to forward-link to day-16.
- Site version bumped to **1.1.97**.

## Testing instructions
1. `docker compose build && docker compose up -d` (or `npm run build` if Node available locally).
2. Confirm footer shows **Versión 1.1.97** / **Version 1.1.97** on `/` and `/en/`.
3. HTTP 200 on:
   - `/doc/day-16/` (ES)
   - `/ca/doc/day-16/`
   - `/en/doc/day-16/`
   - `/de/doc/day-16/`
4. Blog index lists day 16 as newest entry on `/doc/`, `/ca/doc/`, `/en/doc/`, `/de/doc/`.
5. Content checks per locale:
   - Title mentions Harari / IA / AI / KI and Palantir.
   - Venue mentions Bar Pekin and Passeig Prat de la Riba, 25.
   - Link to `/meeting/` (locale-prefixed where applicable).
   - Internal link to day-14 (Harari post).
6. Meeting calendar (`/meeting/`, `/ca/meeting/`, `/en/meeting/`, `/de/meeting/`):
   - Event on 2026-07-10 shows Bar Pekin location (not Casino Masnou).
   - Topic mentions IA/bureaucracy/Harari and Palantir (localized).
   - Maps link opens Bar Pekin address.
7. Day-15 closing on each locale mentions day-16 forward link.
8. `./scripts/check-no-em-dash.sh` passes.
9. Optional: `curl -sI http://127.0.0.1:9180/doc/day-16/` returns 200.

## Test report

1. **Date/time (UTC):** 2026-07-09T19:19:30Z – 2026-07-09T19:20:04Z. Log window: Docker/nginx from 19:19:46Z.
2. **Environment:** branch `main` @ `dee764c`; build via `docker compose build && docker compose up -d` (124 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Day-16 blog post (all locales), blog index ordering, meeting calendar updates (Bar Pekin venue, Harari/Palantir topic), day-15 forward links, footer version, em dash check, locale smoke, production readiness.
4. **Results:**
   - Docker build & deploy (124 pages, no errors): **PASS**
   - Footer version 1.1.97 on `/` and `/en/`: **PASS** (`Versión 1.1.97`, `Version 1.1.97`)
   - Day-16 routes (`/doc/day-16/`, `/ca/doc/day-16/`, `/en/doc/day-16/`, `/de/doc/day-16/`): **PASS** (200)
   - Blog index lists day-16 first on `/doc/`, `/ca/doc/`, `/en/doc/`, `/de/doc/`: **PASS**
   - Content per locale (Harari, IA/AI/KI, Palantir, Bar Pekin, Passeig Prat de la Riba 25, `/meeting/` link, day-14 link): **PASS** (ES/CA/EN/DE)
   - Meeting calendar event 2026-07-10 Bar Pekin location (not Casino Masnou): **PASS** (all locales; no Casino Masnou text)
   - Meeting topic IA/bureaucracy/Harari and Palantir (localized): **PASS** (ES/CA/EN/DE)
   - Maps link to Bar Pekin address (`Passeig+Prat+de+la+Riba+25`): **PASS** (all locales)
   - Day-15 closing forward link to day-16: **PASS** (ES/CA/EN/DE)
   - Em dash check: **PASS**
   - Locale smoke (`/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/meeting/`): **PASS** (200)
   - Production `https://km0digital.com/` and `/doc/day-16/`, `/en/doc/day-16/`: **PASS** (200 on first poll)
   - GitHub label `agent:testing` on issue #64: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/doc/day-16/`, `/ca/doc/day-16/`, `/en/doc/day-16/`, `/de/doc/day-16/`, `/meeting/`, `/ca/meeting/`, `/en/meeting/`, `/de/meeting/`, `/doc/day-15/`, `/ca/doc/day-15/`, `/en/doc/day-15/`, `/de/doc/day-15/`; `https://km0digital.com/`, `https://km0digital.com/doc/day-16/`, `https://km0digital.com/en/doc/day-16/`.
7. **Log excerpts:**
   ```
   2026/07/09 19:19:46 [notice] 1#1: start worker processes
   127.0.0.1 - - [09/Jul/2026:19:19:51 +0000] "GET / HTTP/1.1" 200 57833 "-" "Wget" "-"
   ```
8. **GitHub:** label `agent:testing` applied on issue #64 at test start.
