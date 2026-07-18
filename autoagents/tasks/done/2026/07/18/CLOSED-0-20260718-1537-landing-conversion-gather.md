---
## Closing summary (TOP)

- **What happened:** Landing funnel leaked users (Purpose/manifesto after Contact, FAQ before Community, weak gather paths).
- **What was done:** Dropped Purpose from home; reordered Community before FAQ; added Register secondaries and Community WhatsApp/Ideas text links; quieted TrustSignals; aligned IA map; shipped at 1.1.147.
- **What was tested:** Hard gate PASS (Stirling/Satisfecho side-by-side): product join, community join, manifesto gone; smoke HTTP/locales/version/em-dash/mailto all green.
- **Why closed:** All acceptance criteria and Hard gate protocol passed; no anti-slop regressions in ship diff; no GitHub issue (`NEW-0`).
- **Closed at (UTC):** 2026-07-18 15:47
---

# CLOSED-Task: Landing styles + funnel to gather users

## Origin
- **Source:** Direct operator request (skip GitHub). Review the live site with KM0 + Hallmark anti-slop skills; improve styles/structure so the landing gathers users better.
- **Brief:** `docs/design/landing-conversion-gather.md`
- **No GitHub issue** (`NEW-0`).
- **Skills:** `km0-anti-slop-design`, `km0-web-copy`; Hallmark disciplines (honest proof, no invented metrics, one primary action, structural clarity).

## Problem / goal
The remodel looks civic, but the home **funnel leaks**: Purpose/mission still sits after Contact with a vanity “10M by 2030” line; FAQ blocks Community; WhatsApp/Ideas gather paths are easy to miss; register is not obvious next to “Open KM0 Cloud.” Fix IA + craft so a visitor can **join the product and the community** without manifesto noise or SaaS slop.

## Locked decisions
1. Remove **Purpose** from `Landing.astro` (home). If mission/vision must survive, move to `/presentation/` only, and **do not** keep the naked “10,000,000 people by 2030” claim unless the operator supplies a sourced metric (Hallmark: no invented metrics). Prefer dropping that sentence.
2. Section order on home becomes:  
   `Hero → TrustSignals → Services → WhyKm0 → CloudUserStats → Community → Faq → Contact`  
   (Community **before** FAQ; no Purpose.)
3. Primary CTA language stays **Open KM0 Cloud**. Secondary gather actions are **text links**, not equal pills.
4. Community section gains two quiet secondaries besides Meetings: **WhatsApp** (reuse Contact group URL) and **Ideas** (`localeHref(..., '/ideas/')`).
5. Add a clear **Register / Create account** secondary near hero live strip and/or Cloud users CTA (link to existing auth register, e.g. `https://auth.km0digital.com/register` or Cloud register if that is the canonical door - match what Contact/Cloud already use; do not invent a third signup URL).

## Scope
1. `src/views/Landing.astro` order + drop Purpose import/usage.
2. `src/components/Community.astro` (+ i18n `community.*` for new link labels in es/ca/en/de).
3. Hero and/or `CloudUserStats.astro`: register secondary affordance + any alignment/hierarchy polish needed for the gather moment.
4. Optional: quiet TrustSignals spacing so it does not compete with Offer.
5. Update `docs/design/ia-map.md` if Purpose/order notes still disagree after this ship.
6. Brief already at `docs/design/landing-conversion-gather.md`.
7. Build; bump; Hard gate Testing instructions; `UNTESTED-`.

## Out of scope
- Full visual remodel of every section; new brand tokens; purple experiments
- Fake testimonials, fake user counts, countdown urgency
- Changing Cloud/Mail backend or WhatsApp invite URL value (reuse existing)
- Rewriting all FAQ answers

## Acceptance (hard)
- [x] Home has **no** `#purpose` / Purpose block
- [x] Community appears **before** FAQ in the DOM
- [x] Within Offer→Community→Contact, a visitor can reach: Cloud (open), Register (secondary), Meetings, WhatsApp, Ideas
- [x] Still one primary button language (Cloud); no dual equal pill clusters
- [x] No invented metrics; no em dash; no mailto; four locales updated for new strings
- [ ] Hard gate eye-test narrates the three join actions; soft class-only = fail

## What shipped
- Dropped `Purpose` from home; DOM order: home → trust → services → why → cloud-users → community → faq → contact.
- Community: Meetings + WhatsApp (same Contact invite) + Ideas as text links (no pills).
- Register secondary: `https://auth.km0digital.com/register?service=cloud` under hero live strip and Cloud users band.
- TrustSignals spacing/type quieter under hero.
- `docs/design/ia-map.md` aligned; version **1.1.147**.

## Testing instructions

### Hard gate protocol
| Item | Value |
|------|-------|
| Reference | Prior home (Purpose after Contact, FAQ before Community) + Stirling/Satisfecho one-confident-CTA energy |
| KM0 URL | http://127.0.0.1:9180/en/ and http://127.0.0.1:9180/ |
| Decisive viewport | First scroll past hero through Community (lg+ preferred) |

**3 parity claims (coder self-check; tester must re-verify visually):**
1. **Product join clear:** Hero keeps one `btn-primary` “Open KM0 Cloud”; live strip + Cloud users band add quieter “Create account” → auth register (200). Not a second equal pill.
2. **Community join clear:** `#community` shows Meetings + WhatsApp + Ideas as text links before FAQ; WhatsApp URL matches Contact.
3. **Manifesto dilution gone:** No `#purpose`, no “10,000,000 … 2030” on home; funnel ends Contact → footer.

**3 anti-slop claims:**
1. No Purpose vanity goal / invented metric on home.
2. No equal multi-CTA pill cluster in hero or Community (`community` has 0 `btn-primary`).
3. No fake stats; live Cloud user counter remains the only count band.

### Smoke (coder evidence 2026-07-18)
```bash
# DOM order on /en/: home, trust, services, why, cloud-users, community, faq, contact
# purpose absent; 10,000,000 absent; 2× auth register links; Version 1.1.147
curl -sI http://127.0.0.1:9180/en/          # 200
curl -sI http://127.0.0.1:9180/en/ideas/    # 200
curl -sI http://127.0.0.1:9180/en/meeting/  # 200
curl -sI 'https://auth.km0digital.com/register?service=cloud'  # 200
docker compose build && docker compose up -d  # build OK, km0-web up
./scripts/check-no-em-dash.sh && ./scripts/check-no-mailto.sh  # OK
```

### Tester focus
- Side-by-side eye-test: name three join actions (Cloud open/register, Meetings or WhatsApp, Ideas) without scrolling into a manifesto.
- Confirm es/ca/en/de Community + register strings; footer **1.1.147**.
- Soft class-only / curl-200 alone = **FAIL**.

## References
- docs/design/landing-conversion-gather.md
- docs/design/ia-map.md
- docs/design/lessons-from-pos.md
- docs/design/anti-slop-doctrine.md
- docs/brand-tokens.md
- .cursor/skills/km0-anti-slop-design/SKILL.md
- .cursor/skills/km0-web-copy/SKILL.md
- src/views/Landing.astro

## Test report

1. **Date/time (UTC) and log window:** Start `2026-07-18T15:45:52Z`; end `2026-07-18T15:47:11Z`. Docker/nginx log window `2026-07-18T15:45:00Z`–`15:47:11Z` (`docker logs --since`).

2. **Environment:** Branch `main` (local uncommitted ship under test). Build: `docker compose build && docker compose up -d` (Astro `1.1.147`, em-dash/mailto prebuild OK). Loopback `http://127.0.0.1:9180/`. Production HEAD polled to `200` on `https://km0digital.com/` (ready when status `200`). GitHub issue: **N/A** (`NEW-0`; no `agent:testing` label).

3. **What was tested:** Hard gate protocol (Stirling + Satisfecho + KM0 side-by-side), section/landmark order, Purpose/10M absence, Community join links, Register secondaries, CTA hierarchy, four-locale strings, footer version, smoke HTTP, em-dash/mailto scripts.

4. **Results (criterion → PASS/FAIL + evidence):**

### Hard gate protocol
| Field | Evidence |
|-------|----------|
| Reference URL(s) | https://stirling.com/ (one confident primary “Try Stirling free” + quieter “Explore docs”); https://satisfecho.de/ (one live product path / QR demo energy). Prior KM0 leak: Purpose after Contact, FAQ before Community. |
| KM0 URL(s) | http://127.0.0.1:9180/en/ , http://127.0.0.1:9180/ (also ca/de) |
| Decisive viewport | First scroll past hero through `#cloud-users` into `#community` (before FAQ): product join + community join readable without manifesto. |

**3 parity claims (re-verified):**
1. **Product join clear - PASS.** Hero has exactly one `btn-primary` “Open KM0 Cloud”; pricing is `hero__link` text. “Create account” via `hero__proof-register` and `cloud-proof__register` → `https://auth.km0digital.com/register?service=cloud` (2 hrefs/locale; auth HEAD `200`). Not a second equal pill.
2. **Community join clear - PASS.** `#community` before `#faq`; visible Meetings + WhatsApp + Ideas as underline text (`community__cta` / `community__link`); `btn-primary` count in community = `0`. WhatsApp URL matches Contact: `https://chat.whatsapp.com/DtU6nBk2KxXJhmZbW94nFs` (2 occurrences).
3. **Manifesto dilution gone - PASS.** No `id="purpose"` on home (es/ca/en/de). No `10,000,000` on home. Landmarks end `… → community → faq → contact`. Funnel does not reopen Purpose.

**3 anti-slop claims:**
1. **No Purpose vanity / invented metric on home - PASS.** 10M string absent from home HTML; Purpose component not mounted in `Landing.astro`.
2. **No equal multi-CTA pill cluster - PASS.** Hero CTA: 1× `btn-primary` + 1× text `hero__link`. Community: 0× `btn-primary`, no `rounded-full`. Cloud band: 1× `btn-primary` + quiet register text link.
3. **No fake stats; live Cloud counter only - PASS.** `#cloud-users` `aside` between `#why` and `#community`; live `data-target="29"` (not unavailable). No other invented metric strips on home.

### Acceptance / smoke
| Criterion | Result | Evidence |
|-----------|--------|----------|
| No `#purpose` on home | PASS | All four locales |
| Community before FAQ | PASS | Landmark order `… community, faq, contact` |
| Reach Cloud / Register / Meetings / WhatsApp / Ideas | PASS | As above; `/en/ideas/` and `/en/meeting/` HEAD `200` |
| One primary Cloud language | PASS | “Open KM0 Cloud” only primary button language in hero |
| No invented metrics; no em dash; no mailto; 4 locales | PASS | Scripts OK; register/community strings es/ca/en/de |
| Footer **1.1.147** | PASS | EN/DE “Version 1.1.147”; ES “Versión”; CA “Versió” |
| HTTP locales + doc | PASS | `/` `/ca/` `/en/` `/de/` `/doc/` `/en/doc/day-0/` all `200` |
| Soft class-only alone | N/A (avoided) | Hard gate filled with join-path narrative + reference sites |

Landmark order (section+aside): `home → trust → services → why → cloud-users → community → faq → contact` - **PASS**.

5. **Overall: PASS**

6. **URLs tested:**  
   http://127.0.0.1:9180/ , `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`, `/en/ideas/`, `/en/meeting/`, `/en/presentation/`  
   https://auth.km0digital.com/register?service=cloud  
   https://km0digital.com/ , https://km0digital.com/en/  
   References: https://stirling.com/ , https://satisfecho.de/

7. **Log excerpts (`km0-web`):**
```
2026/07/18 15:46:08 [notice] 1#1: nginx/1.31.3
2026/07/18 15:46:08 [notice] 1#1: start worker processes
172.21.0.1 - - [18/Jul/2026:15:46:22 +0000] "GET /en/ HTTP/1.1" 200 43424
172.21.0.1 - - [18/Jul/2026:15:46:22 +0000] "HEAD /en/ideas/ HTTP/1.1" 200 0
172.21.0.1 - - [18/Jul/2026:15:46:22 +0000] "HEAD /en/meeting/ HTTP/1.1" 200 0
Container km0-web: Up (healthy) 127.0.0.1:9180->80/tcp
```
Production readiness: polled `curl -sI https://km0digital.com/` until `200` (same window; footer also reports Version 1.1.147).
