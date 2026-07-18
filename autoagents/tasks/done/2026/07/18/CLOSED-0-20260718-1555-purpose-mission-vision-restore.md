---
## Closing summary (TOP)

- **What happened:** Boss mandate restored Mission and Vision (`#purpose`) on the home page after the conversion FEAT had removed it.
- **What was done:** Wired `Purpose.astro` into `Landing.astro` after Contact; reframed `purpose.missionBody` in es/ca/en/de as Goal/Objetivo/Objectiu/Ziel (kept 10M/2030); updated `ia-map` Purpose policy.
- **What was tested:** Tester PASS with full Hard gate (reference, KM0 URLs, decisive viewport, 3 parity + 3 anti-slop claims); locales 200; section order; gather funnel preserved; no KPI count-up; version 1.2.1.
- **Why closed:** All acceptance criteria passed; Hard gate evidence is not soft/class-only; no anti-slop regressions in Purpose restore.
- **Closed at (UTC):** 2026-07-18 16:04
---

# CLOSED-Task: Restore Mission and Vision block (boss mandate)

## Origin
- **Source:** Direct operator request (skip GitHub). Boss strictly requires the Mission and Vision block back on the home page.
- **Brief:** `docs/design/purpose-mission-vision-restore.md`
- **No GitHub issue** (`NEW-0`).
- **Skills:** `km0-anti-slop-design`, `km0-web-copy`; Hallmark honest framing (goal ≠ fake KPI).
- **Supersedes home rule in** CLOSED `landing-conversion-gather` / `ia-map` “Purpose off home” for this stakeholder exception.

## Problem / goal
Conversion FEAT removed `#purpose` from the landing. Stakeholder (boss) **requires** Mission and Vision visible again. Reimplement the block with civic craft: keep the ambition line, do not ship it as a vanity metric strip, and do not undo Community/WhatsApp/Ideas/Register gather work.

## Locked decisions
1. **Restore** Mission + Vision on home via `Purpose.astro` (recreate from git if missing).
2. **Wire** in `Landing.astro` **after Contact**, before Footer.
3. **Keep** `id="purpose"` and `purpose.*` i18n keys (es/ca/en/de).
4. **Mission number (10.000.000 / 2030):** keep; rewrite slightly if needed so it reads as a **goal** (“Goal: …” / “Objetivo: …” / etc.), not “we already connected 10M.”
5. **Do not remove** Community secondaries (Meetings / WhatsApp / Ideas) or hero Register link.
6. Update `docs/design/ia-map.md`: Purpose is back on home as closer after Contact; note boss mandate; still ban fake KPI animation.

## Scope
1. `src/components/Purpose.astro` (restore + craft polish under tokens)
2. `src/views/Landing.astro` (import + place after Contact)
3. `src/i18n/{es,ca,en,de}.json` → `purpose.*` goal framing if copy needs the honesty tweak
4. `docs/design/ia-map.md` + brief `docs/design/purpose-mission-vision-restore.md`
5. Build; bump; Hard gate Testing instructions; `UNTESTED-`

## Out of scope
- Removing Community/FAQ order from the conversion FEAT
- Turning Mission into a live counter or progress bar to 10M
- Full landing remodel; purple/glow; Inter-only
- Changing Cloud primary CTA canon

## Acceptance (hard)
- [x] `/` and `/en/` (and ca/de) show `#purpose` with Mission and Vision
- [x] Block sits after Contact, before Footer
- [x] 2030 / 10M line present and framed as goal/ambition
- [x] No fake KPI strip / count-up to 10M
- [x] Community gather links + Register secondary still present
- [x] No em dash; no mailto; version bumped; build green

## Testing instructions

Coder completed **2026-07-18**. Site version **1.2.1**. Deployed via `docker compose build && docker compose up -d` on `127.0.0.1:9180`.

### What changed
1. Wired existing `Purpose.astro` into `Landing.astro` after `Contact`, before `Footer`.
2. Reframed `purpose.missionBody` in es/ca/en/de as Goal / Objetivo / Objectiu / Ziel (kept 10.000.000 / 2030).
3. Updated `docs/design/ia-map.md` (Purpose back on home; ban fake KPI) and brief status.

### Hard gate
| Item | Value |
|------|-------|
| Reference | Pre-removal Purpose layout (editorial two-col Mission \| Vision, Signal rail, display + serif) + current gather funnel (Community Meetings / WhatsApp / Ideas; hero Register) |
| KM0 URL | http://127.0.0.1:9180/en/ , `/`, `/ca/`, `/de/` |
| Decisive viewport | Scroll past Contact → `#purpose` Mission and Vision |

**3 parity claims:**
1. Boss can see Mission + Vision on home (`#purpose` after Contact; EN “Mission” / “Vision” / “Goal: connect 10,000,000 people by 2030.”).
2. Funnel gather paths still work: `#community` before FAQ/Contact; Meetings / WhatsApp / Ideas links unchanged; hero Register → `auth.km0digital.com/register`.
3. Civic editorial craft: biased two-column Purpose (display mission + serif vision), Signal rail header; not equal icon tiles.

**3 anti-slop claims:**
1. No 10M animated vanity counter / count-up (static goal copy only).
2. No purple / indigo brand gradient on home HTML.
3. Purpose has no CTA; Cloud remains primary CTA in Hero / Offer.

### Smoke (coder evidence)
```bash
# HTTP 200 on /, /en/, /ca/, /de/
# HTML order on /en/: community < faq < contact < purpose
# Goal framing: Objetivo / Goal / Objectiu / Ziel + 2030 + 10M
# Footer: Version 1.2.1
./scripts/check-no-em-dash.sh   # OK
./scripts/check-no-mailto.sh    # OK
docker compose build            # Astro build Complete (km0-web@1.2.1)
```

### Tester checklist
- [x] Open `/` and `/en/`; scroll past Contact; confirm Mission + Vision readable
- [x] Confirm section order: Community → FAQ → Contact → Purpose → Footer
- [x] Confirm 10M/2030 reads as Goal (not “we already have 10M”)
- [x] Confirm Community Meetings / WhatsApp / Ideas + hero Register still present
- [x] Hard gate parity + anti-slop claims verified (no soft class-only pass)
- [x] Footer shows **1.2.1** (or later if stacked bumps)

## References
- docs/design/purpose-mission-vision-restore.md
- docs/design/landing-conversion-gather.md (funnel to preserve)
- docs/design/ia-map.md
- docs/design/anti-slop-doctrine.md
- .cursor/skills/km0-anti-slop-design/SKILL.md
- .cursor/skills/km0-web-copy/SKILL.md
- git history: Purpose.astro before conversion drop

## Test report

**Overall: PASS**

1. **Date/time (UTC) and log window**
   - Start: 2026-07-18 16:03:27 UTC (TESTING rename)
   - Build/deploy: 2026-07-18 16:03:29–16:03:40 UTC
   - Checks: 2026-07-18 16:03:45–16:04:06 UTC
   - Log window: `docker logs km0-web` from nginx start `16:03:40` through tester GETs `16:03:52`

2. **Environment**
   - Branch: `main` (synced via `./scripts/git-sync-main.sh`)
   - Build: `docker compose build && docker compose up -d` (Astro `km0-web@1.2.1`, build Complete)
   - Container: `km0-web` healthy on `127.0.0.1:9180`
   - Site version: **1.2.1**
   - GitHub: N/A (`NEW-0`, no issue)

3. **What was tested**
   - HTTP smoke on loopback locales + doc paths; production HEAD/GET readiness
   - `#purpose` Mission + Vision presence and copy framing (es/ca/en/de)
   - DOM section order Community → FAQ → Contact → Purpose → Footer
   - Gather funnel preserved (Community Meetings / WhatsApp / Ideas; hero Register)
   - Hard gate: parity + anti-slop claims with decisive viewport evidence (not class-only)
   - Em dash / mailto checks; footer version

4. **Results (criteria)**

| Criterion | Result | Evidence |
|-----------|--------|----------|
| `/`, `/en/`, `/ca/`, `/de/` show `#purpose` Mission + Vision | **PASS** | All four return HTTP 200; each has `id="purpose"`; EN shows “Mission” / “Vision” / “Mission and vision” heading |
| Block after Contact, before Footer | **PASS** | Positions on `/en/`: community 27658, faq 28547, contact 34494, purpose 36357 (ascending); purpose before main end; Footer follows |
| 10M/2030 framed as goal | **PASS** | ES `Objetivo: … 10.000.000 … 2030`; EN `Goal: connect 10,000,000 people by 2030.`; CA `Objectiu:…`; DE `Ziel: bis 2030 10.000.000…` |
| No fake KPI / count-up | **PASS** | Purpose section: no `count-up` / `data-count` / odometer; static goal sentence only |
| Community gather + Register preserved | **PASS** | `#community`: Meetings → `/en/meeting/`, WhatsApp → chat.whatsapp.com/…, Ideas → `/en/ideas/`; hero Register → `https://auth.km0digital.com/register?service=cloud` |
| No em dash; no mailto; version; build green | **PASS** | `check-no-em-dash` OK; `check-no-mailto` OK; footer Versión/Version/Versió **1.2.1**; docker Astro build Complete |

5. **Hard gate protocol**

| Field | Value |
|-------|-------|
| Reference | Pre-removal Purpose layout (editorial two-col Mission \| Vision, Signal rail, display + serif) + gather funnel (Community Meetings / WhatsApp / Ideas; hero Register). Task does not name Stirling/Satisfecho; reference = prior KM0 Purpose + conversion gather brief. |
| KM0 URL(s) | http://127.0.0.1:9180/ , `/en/`, `/ca/`, `/de/` (also confirmed `id="purpose"` on https://km0digital.com/en/ after production 200) |
| Decisive viewport | Scroll past Contact → `#purpose`: Mission + Vision readable; EN “Goal: connect 10,000,000 people by 2030.” |

**3 parity claims (non-dev notice):**
1. **PASS** - Mission + Vision back on home after Contact (`#purpose`; EN “Mission” / “Vision” / Goal line with 10M and 2030).
2. **PASS** - Gather paths intact: `#community` Meetings / WhatsApp / Ideas links; hero Register still opens auth register.
3. **PASS** - Civic editorial craft, not icon tiles: Signal rail header (`border-left: 3px solid var(--color-signal)`), biased two-col grid `1fr / 1.15fr`, Mission body **Bricolage Grotesque** (display), Vision body **ui-serif/Georgia** (from `/_astro/index.DFyBLex2.css`).

**3 anti-slop claims:**
1. **PASS** - No 10M animated vanity counter (static goal copy; zero counter patterns in `#purpose`).
2. **PASS** - Zero `purple` / `indigo` / `violet` matches in `/` and `/en/` HTML.
3. **PASS** - Purpose has **0** anchors (no CTA); Cloud primary still present (`cloud.km0digital.com` on page; hero Cloud path intact).

6. **Overall: PASS**

7. **URLs tested**
   - http://127.0.0.1:9180/ → 200
   - http://127.0.0.1:9180/ca/ → 200
   - http://127.0.0.1:9180/en/ → 200
   - http://127.0.0.1:9180/de/ → 200
   - http://127.0.0.1:9180/doc/ → 200
   - http://127.0.0.1:9180/en/doc/day-0/ → 200
   - https://km0digital.com/ → 200 (poll: immediate 200; `/en/` also contains `id="purpose"`)
   - Ready signal: `docker compose ps` health → `healthy`, then curl 200 (no fixed sleep)

8. **Log excerpts** (`docker logs km0-web`)
```text
2026/07/18 16:03:40 [notice] 1#1: nginx/1.31.3
2026/07/18 16:03:40 [notice] 1#1: start worker processes
127.0.0.1 - - [18/Jul/2026:16:03:45 +0000] "GET / HTTP/1.1" 200 ...
172.21.0.1 - - [18/Jul/2026:16:03:51 +0000] "HEAD /en/ HTTP/1.1" 200 ...
172.21.0.1 - - [18/Jul/2026:16:03:51 +0000] "GET /en/ HTTP/1.1" 200 44423 ...
172.21.0.1 - - [18/Jul/2026:16:03:51 +0000] "GET / HTTP/1.1" 200 44608 ...
```
