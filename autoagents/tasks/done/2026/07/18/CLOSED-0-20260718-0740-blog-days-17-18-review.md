---
## Closing summary (TOP)

- **What happened:** Meetup blog days 17–18 needed a ship-ready review: scaffolding removed, Casino facts locked, and the 10 July calendar aligned away from Bar Pekin.
- **What was done:** Finished day-17/18 in four locales, set `masnou-jul-2026` to Casino del Masnou (meetings + i18n), added day-16→17 series link, bumped site to **1.1.139**.
- **What was tested:** Overall PASS - eight locale URLs 200, locked facts, no scaffolding, calendar Casino, em-dash/mailto clean, footer 1.1.139 on loopback and prod. Craft Hard gate N/A (content task); anti-slop skim OK (no Inter-only/purple UI regressions).
- **Why closed:** All acceptance criteria passed; no GitHub issue (`NEW-0`).
- **Closed at (UTC):** 2026-07-18 07:47
---

# CLOSED-Task: Review and ship blog days 17 and 18

## Origin
- **Source:** Direct operator request (skip GitHub). Single task. No ambiguity.
- **Brief (locked facts):** `docs/design/blog-days-17-18-review.md`
- **No GitHub issue** (`NEW-0`).
- **Role reminder:** This file is the work order. Implement only what is listed here.

## Problem / goal
Two backlog meetup days need a **ship-ready review**: Casino del Masnou (Palantir + Harari/bureaucracy) and a professional brand session (“marca sin alma”). Drafts already exist in all locales. Remove scaffolding, lock facts, align the 10 July calendar to Casino, verify series links and build. Do **not** invent quotes, venues, or extra days.

## In scope (exhaustive)

1. **Review + finish** (all four locales each):
   - `src/content/doc/{es,ca,en,de}/day-17.md`
   - `src/content/doc/{es,ca,en,de}/day-18.md`
2. **Calendar venue fix for 10 July only:**
   - `src/lib/meetings.ts` → event `masnou-jul-2026` maps URL → Casino del Masnou (Carrer de Barcelona, 1)
   - `src/i18n/es.json`, `ca.json`, `en.json`, `de.json` → `meeting.events.masnou-jul-2026.location` → Casino address (same fact in all locales)
3. **Series hygiene:** day-17 links day-16 and day-18; day-18 links day-17. If day-16 closing still only “see you 10 July” with no pointer to the recap, add one sentence linking to day-17 in all four locales of `day-16.md` (minimal edit).
4. **Prose contract:** `docs/design/blog-post-template.md`, skill `km0-web-copy`, shape like `day-0` (Markdown prose). No new `doc-block` HTML kits.
5. **Strip live scaffolding:** every `Pendiente` / `To expand` / `Pendent` / `Noch zu ergänzen` / `Nota de autor` / `Author note` blockquote aimed at the operator must be **removed or replaced with real operator facts**. If no new facts arrive during this task, **delete the scaffolding** and keep the surrounding solid prose (do not leave “fill me later” on production pages).
6. **Checks:** `./scripts/check-no-em-dash.sh`; no `mailto:`; `npm run build`; `./scripts/bump-patch-version.sh` once; deploy per `docs/runbook.md`; smoke URLs below.

## Out of scope (exhaustive)

- Day 19+ or rewriting day-0…15 bodies
- Changing public price, product UI, or brand assets
- Inventing attendee lists, quotes, photos, or Palantir “case studies”
- Changing the **24 July** Cursor meetup event
- Rewriting day-16’s original Bar Pekin **announcement** narrative (only optional one-line link to day-17 in the closing)
- Creating GitHub issues

## Locked content (copy these; do not “improve” into fiction)

### Day 17
- **Event:** 2026-07-10 at **Casino del Masnou**, Carrer de Barcelona, 1, 08320 El Masnou, Barcelona
- **`pubDate`:** 2026-07-11
- **Axis 1 - Palantir:** dangerous because it pushes into as many companies/orgs as possible and concentrates knowledge of huge user populations; **very good** at database/entity mapping; critique power, respect competence
- **Axis 2 - Harari / AI:** models already **outwrite** humans; they can “hack” bureaucracy by mastering language/psychology and finding **gaps** in procedures (not server cracking)
- **Note in prose:** day-16 announced Bar Pekin; the meetup was at the Casino

### Day 18
- **`pubDate`:** 2026-07-17
- **Session:** professional meetup intended to cover KM0 **brand and styles**
- **What happened:** conversation digressed; lasting conclusion = brand then had **no soul** → full revision (colours, type, logo, styles)
- **Do not invent:** street address, clock time, or people’s names

Full table: `docs/design/blog-days-17-18-review.md`.

## Acceptance (hard) - all required

- [ ] `/doc/day-17/` and `/doc/day-18/` return 200 in `es`, `ca`, `en`, `de` (locale prefixes as configured)
- [ ] Frontmatter valid: `title`, `description`, `pubDate`, `locale` match folder
- [ ] Day 17 states Casino address + both axes (Palantir + Harari/bureaucracy language)
- [ ] Day 18 states brand “no soul” + full revision agenda; no fake venue
- [ ] Zero operator-scaffolding blockquotes left in any of the eight files
- [ ] Calendar event `masnou-jul-2026` location + maps URL point at Casino (i18n ×4 + `meetings.ts`)
- [ ] No em dash; no `mailto:`; facts aligned across locales (mirror meaning, not awkward calque)
- [ ] Footer version bumped once for this task; build green

## Testing instructions

### What changed
- Hardened `day-17` and `day-18` in `es`/`ca`/`en`/`de`: removed operator scaffolding blockquotes and meta “fill later” closings; kept locked Casino + Palantir/Harari facts (day 17) and brand “no soul” + full revision agenda without inventing venue (day 18).
- Calendar `masnou-jul-2026`: Casino maps URL + `venueWebsite`; i18n location ×4.
- Day 16 closing: one-line link to day-17 recap (all locales). Pekin announcement body unchanged.
- Version: `1.1.138` → `1.1.139` via `./scripts/bump-patch-version.sh`.
- Deploy: `docker compose build && docker compose up -d` (host has no npm; build ran in Docker).

### Required smoke
```bash
# Expect HTTP/1.1 200 for each:
curl -sI http://127.0.0.1:9180/doc/day-17/ | head -1
curl -sI http://127.0.0.1:9180/en/doc/day-17/ | head -1
curl -sI http://127.0.0.1:9180/ca/doc/day-17/ | head -1
curl -sI http://127.0.0.1:9180/de/doc/day-17/ | head -1
curl -sI http://127.0.0.1:9180/doc/day-18/ | head -1
curl -sI http://127.0.0.1:9180/en/doc/day-18/ | head -1
curl -sI http://127.0.0.1:9180/ca/doc/day-18/ | head -1
curl -sI http://127.0.0.1:9180/de/doc/day-18/ | head -1

curl -s http://127.0.0.1:9180/doc/day-17/ | grep -oE 'Casino del Masnou|Palantir|Harari' | sort -u
curl -s http://127.0.0.1:9180/doc/day-18/ | grep -oE 'sin alma|marca' | sort -u
curl -s http://127.0.0.1:9180/meeting/ | grep -o 'Casino del Masnou, Carrer de Barcelona, 1' | head -3
# 10 July event is past; confirm payload location (not Bar Pekin):
curl -s http://127.0.0.1:9180/meeting/ | grep -o 'masnou-jul-2026[^}]*location[^}]*' | head -1
! grep -R -n 'Pendiente de ampliar\|To expand\|Pendent d.ampliar\|Noch zu ergänzen\|Nota de autor\|Author note' src/content/doc/*/day-17.md src/content/doc/*/day-18.md
./scripts/check-no-em-dash.sh
./scripts/check-no-mailto.sh
curl -s http://127.0.0.1:9180/ | grep -o 'Versión 1.1.139'
```

### Coder evidence (2026-07-18)
- All eight day-17/day-18 locale URLs: **200**
- Day 17 body: Casino + Palantir + Harari present; scaffolding grep: empty
- Meeting payload `masnou-jul-2026.location`: Casino del Masnou (not Pekin); maps query Casino
- Footer: **Versión 1.1.139**
- `docker compose build` astro build green; `check-no-em-dash` / `check-no-mailto` OK in prebuild

### Browser checklist
- [x] Open day-17 and day-18 in ES + EN: lead answers “what happened / why care” in first screen
- [x] Meeting calendar 10 July detail shows Casino, not Pekin
- [x] No cute slogan H2s; no invented testimonials
- [x] Day 16 still announces Pekin historically; closing links to day 17

## References
- docs/design/blog-days-17-18-review.md
- docs/design/blog-post-template.md
- docs/runbook.md
- src/content/doc/es/day-0.md (prose shape)
- src/content/doc/es/day-16.md (announcement; Pekin historical)
- src/lib/meetings.ts

## Test report

1. **Date/time (UTC) and log window**
   - Start: `2026-07-18T07:46:18Z`
   - End: `2026-07-18T07:46:45Z`
   - Log window: `docker logs --since 2026-07-18T07:46:18Z km0-web` (all probed paths 200)

2. **Environment**
   - Branch: `main` (synced; working tree has uncommitted coder changes already deployed)
   - Build/deploy: existing `km0-web` container (healthy, created ~07:45:31Z via `docker compose build && docker compose up -d`)
   - Version in `package.json`: `1.1.139`
   - Loopback: `http://127.0.0.1:9180/`
   - Production: `https://km0digital.com/`
   - GitHub: N/A (`NEW-0`, no issue; no `agent:*` label updates)

3. **What was tested**
   - HTTP 200 for day-17/day-18 in `es`/`ca`/`en`/`de` (loopback + production smoke)
   - Frontmatter `title`/`description`/`pubDate`/`locale` on all eight files
   - Locked facts: Casino address + Palantir + Harari axes (day 17); brand “no soul” + full revision, no invented venue (day 18)
   - Scaffolding grep empty; em-dash and mailto checks
   - Calendar `masnou-jul-2026` maps URL + i18n location ×4
   - Series links day-16→17, day-17↔18; day-16 Pekin announcement preserved
   - Footer version `1.1.139` loopback and production
   - Craft Hard gate: N/A (content task; no craft-parity / Stirling / Satisfecho requirement)

4. **Results (acceptance)**
   - `/doc/day-17/` and `/doc/day-18/` 200 in four locales: **PASS** (all eight `HEAD` → `HTTP/1.1 200 OK` on `:9180`; prod `HTTP/2 200` for `/doc/day-17/`, `/doc/day-18/`, `/en/doc/day-17/`, `/en/doc/day-18/`)
   - Frontmatter valid, locale matches folder: **PASS** (`pubDate` 2026-07-11 / 2026-07-17; `locale:` es|ca|en|de)
   - Day 17 Casino + both axes: **PASS** (ES/EN/CA/DE HTML contain `Casino del Masnou`, `Palantir`, `Harari`; address `Carrer de Barcelona`; Pekin→Casino venue note present)
   - Day 18 “no soul” + revision; no fake venue: **PASS** (ES `sin alma`/`marca`/`revisión`/`colores`/`tipografía`/`logo`; EN `no soul`/`brand`/`revision`; explicit “do not invent street/clock”; Casino mention only as day-17 cross-link)
   - Zero operator scaffolding in eight files: **PASS** (`grep` for Pendiente/To expand/Pendent/Noch zu/Nota de autor/Author note → empty; exit 0 with `!`)
   - Calendar Casino location + maps: **PASS** (`meetings.ts` maps query `Casino+del+Masnou`; meeting page payload `location":"Casino del Masnou, Carrer de Barcelona, 1..."`; i18n ×4 same address; visible text on `/meeting/`)
   - No em dash; no mailto; facts aligned: **PASS** (`check-no-em-dash.sh` OK; `check-no-mailto.sh` OK; four locales mirror meaning)
   - Footer bumped once; build green: **PASS** (`Versión 1.1.139` on loopback and prod home; container healthy after coder docker build)
   - Browser checklist (curl article lead extract): **PASS** (ES/EN day-17/18 leads answer what happened / why care; meeting Casino not Pekin; day-16 still Bar Pekin + closing → day-17)

5. **Overall: PASS**

6. **URLs tested**
   - Loopback: `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/doc/day-17/`, `/en|ca|de/doc/day-17/`, `/doc/day-18/`, `/en|ca|de/doc/day-18/`, `/meeting/`
   - Production: `https://km0digital.com/`, `/doc/day-17/`, `/doc/day-18/`, `/en/doc/day-17/`, `/en/doc/day-18/`, `/meeting/`
   - Production ready: polled until `HTTP/2 200` and footer `Versión 1.1.139` matched loopback (no fixed sleep)

7. **Log excerpts** (`km0-web`, UTC window)
   ```
   18/Jul/2026:07:46:29 ... HEAD /doc/day-17/ ... 200
   18/Jul/2026:07:46:29 ... HEAD /en/doc/day-17/ ... 200
   18/Jul/2026:07:46:29 ... HEAD /ca/doc/day-17/ ... 200
   18/Jul/2026:07:46:29 ... HEAD /de/doc/day-17/ ... 200
   18/Jul/2026:07:46:29 ... HEAD /doc/day-18/ ... 200
   18/Jul/2026:07:46:29 ... HEAD /en|ca|de/doc/day-18/ ... 200
   18/Jul/2026:07:46:29 ... GET /meeting/ ... 200
   18/Jul/2026:07:46:30 ... HEAD /doc/day-17/ ... 200 (prod via 116.202.10.106)
   18/Jul/2026:07:46:37 ... GET /ca|de/doc/day-17|18/ ... 200
   ```
