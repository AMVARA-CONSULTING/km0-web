---
## Closing summary (TOP)

- **What happened:** The 24 July Casino meetup calendar copy had a `MEet` typo and still described a Cursor product session.
- **What was done:** Updated `title` and `topic` for `cursor-masnou-jul24-2026` in es/ca/en/de to locked Meet copy (style, services outlook, integrated AI); left schedule/id unchanged; bumped site to 1.1.140.
- **What was tested:** Tester PASS: no `MEet`, locked copy live on loopback and production `/meeting/` all locales, no Cursor topic links, July 10 intact, footer 1.1.140, em-dash/mailto clean.
- **Why closed:** All acceptance criteria passed; copy-only change with no anti-slop UI regressions; no GitHub issue (`NEW-0`).
- **Closed at (UTC):** 2026-07-18 07:57
---

# CLOSED-Task: Fix 24 July meetup title and topic

## Origin
- **Source:** Direct operator request (skip GitHub).
- **No GitHub issue** (`NEW-0`).
- **Event id (keep):** `cursor-masnou-jul24-2026` in `src/lib/meetings.ts` (do **not** rename the id; only change i18n copy).

## Problem / goal
The **24 July 2026** Casino meetup is wrong in the calendar:

1. Title typo: **`MEet` → `Meet`** (ES/CA).
2. Topic is still “how Cursor works” with Cursor links. Replace with the real agenda: **new style**, **future outlook for services**, and **how an AI integrated into a system works**.

Date, time, venue, maps, and audience stay unchanged.

## Locked schedule (do not change)

| Field | Value |
|-------|--------|
| Event id | `cursor-masnou-jul24-2026` |
| Date | `2026-07-24` |
| Time | `18:30` |
| Venue | Casino del Masnou, Carrer de Barcelona, 1, El Masnou, Barcelona |
| `meetings.ts` maps / website | leave as-is |

## Locked copy (all four locales)

Replace `meeting.events.cursor-masnou-jul24-2026` `title` + `topic` only. Keep `location` and `audience` unless they still say something false (they are fine today).

### Spanish (`es.json`)
- **title:** `Meet KM0: Nuevo estilo, servicios y IA integrada`
- **topic:** `Nuevo estilo de marca; previsión de futuro de los servicios KM0; cómo funciona una IA integrada en un sistema.`

### Catalan (`ca.json`)
- **title:** `Meet KM0: Nou estil, serveis i IA integrada`
- **topic:** `Nou estil de marca; previsió de futur dels serveis KM0; com funciona una IA integrada en un sistema.`

### English (`en.json`)
- **title:** `KM0 Meet: New style, services outlook, and integrated AI`
- **topic:** `New brand style; future outlook for KM0 services; how an AI integrated into a system works.`

### German (`de.json`)
- **title:** `KM0-Meet: Neuer Stil, Service-Ausblick und integrierte KI`
- **topic:** `Neuer Markenstil; Ausblick auf die KM0-Dienste; wie eine in ein System integrierte KI funktioniert.`

## Explicit bans
- Do **not** keep Cursor product links as the topic body (remove `cursor.com` / docs / blog anchors from this event’s `topic`).
- Do **not** invent a second 24 July event or delete the July 10 event.
- Do **not** rename the TypeScript event id (breaks nothing useful; copy is enough).
- No em dash; no `mailto:`.

## In scope
1. `src/i18n/es.json`, `ca.json`, `en.json`, `de.json` → keys under `meeting.events.cursor-masnou-jul24-2026`
2. Grep the repo for remaining `MEet` in meeting/marketing copy and fix if any other live string remains
3. `./scripts/bump-patch-version.sh` once; `npm run build`; runbook deploy smoke

## Out of scope
- Blog day posts about this meetup
- Changing brand tokens / logo for “nuevo estilo” (calendar copy only)
- Auth/Cloud product UI

## Acceptance (hard)
- [x] No `MEet` substring in `src/i18n/*.json` meeting titles
- [x] 24 July event topic states the three axes (style, services future, integrated AI) in es/ca/en/de
- [x] Topic no longer points at Cursor as the session subject
- [x] `/meeting/` (all locales) shows Meet + new topic; date still 24 July, Casino
- [x] July 10 event unchanged by this task
- [x] Build green; version bumped

## What was done
- Updated `title` + `topic` for `meeting.events.cursor-masnou-jul24-2026` in es/ca/en/de.
- Confirmed zero `MEet` in `src/`; event id and schedule left unchanged in `meetings.ts`.
- Bumped site version **1.1.139 → 1.1.140**.
- `docker compose build && docker compose up -d` (host has no npm; build ran in image).

## Testing instructions

Coder smoke (2026-07-18):

```bash
# No typo left
grep -n 'MEet' src/i18n/*.json && exit 1 || echo OK_no_MEet

# Locked copy present
grep -n 'cursor-masnou-jul24-2026' -A5 src/i18n/es.json src/i18n/en.json src/i18n/ca.json src/i18n/de.json

# HTTP 200 all locales
curl -sI http://127.0.0.1:9180/meeting/ http://127.0.0.1:9180/en/meeting/ \
  http://127.0.0.1:9180/ca/meeting/ http://127.0.0.1:9180/de/meeting/ | grep HTTP

# Live ES card
curl -s http://127.0.0.1:9180/meeting/ | grep -oE 'Meet KM0: Nuevo estilo[^<]*|Nuevo estilo de marca[^<]*'

# Old Cursor topic must be gone
curl -s http://127.0.0.1:9180/meeting/ | grep -E 'Funcionamiento de Cursor|cursor.com' && exit 1 || echo OK_no_cursor_topic

# July 10 still in calendar payload
curl -s http://127.0.0.1:9180/meeting/ | grep -o 'masnou-jul-2026\|2026-07-10\|Palantir' | sort -u

# Footer version
curl -s http://127.0.0.1:9180/ | grep -o 'Versión 1.1.140'
```

### Coder evidence
- `MEet`: none in `src/i18n/*.json`
- Meeting pages: HTTP 200 for `/meeting/`, `/en/`, `/ca/`, `/de/`
- ES live title: `Meet KM0: Nuevo estilo, servicios y IA integrada`
- ES topic: style + services outlook + integrated AI (no `cursor.com`)
- July 10 `masnou-jul-2026` / Palantir / Harari still in calendar `data-payload`
- Footer: **Versión 1.1.140**
- Docker build: Astro build Complete (132 pages)

### Browser (tester)
- [x] Open meeting calendar, select 24 July: title uses **Meet**, topic lists style + services outlook + integrated AI
- [x] 10 July still Palantir/Harari event
- [x] Check CA / EN / DE titles match locked copy

## References
- src/lib/meetings.ts (`cursor-masnou-jul24-2026`)
- src/i18n/{es,ca,en,de}.json → `meeting.events.cursor-masnou-jul24-2026`
- docs/runbook.md

## Test report

1. **Date/time (UTC) and log window:** 2026-07-18 07:55:45 UTC start; ended 07:56:08 UTC. Docker log window ~07:54:55–07:55:57 UTC (container restart after coder deploy).
2. **Environment:** branch `main` (synced via `./scripts/git-sync-main.sh`); local `http://127.0.0.1:9180/` via `docker compose` (image `km0-km0-web`, healthy); production `https://km0digital.com/`. Site version **1.1.140**. No craft-parity gate (copy-only task). No GitHub issue (`NEW-0`); labels N/A.
3. **What was tested:** Locked i18n title/topic for `cursor-masnou-jul24-2026` (es/ca/en/de); no `MEet` in `src/`; schedule id/date/time unchanged in `meetings.ts`; July 10 event intact; meeting pages HTTP 200 all locales; live HTML/calendar payload on loopback and production; footer version; em-dash and mailto checks; docker logs for the window.
4. **Results:**
   - No `MEet` in `src/i18n/*.json` or `src/`: **PASS** (zero matches)
   - Locked title+topic es/ca/en/de match task copy: **PASS** (grep -A5 on all four JSON files)
   - Topic three axes (style, services future, integrated AI); no Cursor session subject / `cursor.com`: **PASS** (loopback + prod `/meeting/` grep; `OK_no_cursor_topic`)
   - `/meeting/` all locales HTTP 200; live titles match locked copy: **PASS** (ES/EN/CA/DE curl body evidence)
   - Date still 24 July, Casino; event id `cursor-masnou-jul24-2026` unchanged: **PASS** (`meetings.ts` + calendar payload)
   - July 10 unchanged (Palantir/Harari, `masnou-jul-2026`, `2026-07-10`): **PASS**
   - Build/deploy green; version 1.1.140: **PASS** (footer local + prod; container healthy; nginx 200s)
   - Em dash / mailto: **PASS** (`check-no-em-dash.sh`, `check-no-mailto.sh`)
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/meeting/`, `/en/meeting/`, `/ca/meeting/`, `/de/meeting/`, `/ca/`, `/en/`, `/de/`; `https://km0digital.com/`, `/meeting/`, `/en/meeting/`, `/ca/meeting/`, `/de/meeting/` (all 200; ready confirmed by HEAD/GET 200 with new copy in body, no fixed sleep).
7. **Log excerpts:**
   ```
   2026/07/18 07:54:55 [notice] 1#1: start worker processes
   172.21.0.1 - - [18/Jul/2026:07:55:52 +0000] "HEAD /meeting/ HTTP/1.1" 200
   172.21.0.1 - - [18/Jul/2026:07:55:57 +0000] "GET /en/meeting/ HTTP/1.1" 200
   172.21.0.1 - - [18/Jul/2026:07:55:57 +0000] "GET /ca/meeting/ HTTP/1.1" 200
   172.21.0.1 - - [18/Jul/2026:07:55:57 +0000] "GET /de/meeting/ HTTP/1.1" 200
   172.21.0.1 - - [18/Jul/2026:07:55:57 +0000] "HEAD /meeting/ HTTP/1.1" 200 ... "116.202.10.106"
   ```
