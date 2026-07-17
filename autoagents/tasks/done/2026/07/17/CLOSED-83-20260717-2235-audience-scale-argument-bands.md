---
## Closing summary (TOP)

- **What happened:** Why section became three editorial person/community/organisation scale bands instead of compare lists or icon grids.
- **What was done:** Reshaped `WhyKm0.astro` with mono meta rails, intentional middle Snow band, four-locale `vision.bands`; Cloud user counter left under Offer.
- **What was tested:** Tester PASS - three bands all locales; middle Snow strip; CTAs correct; `#cloud-users` present; em-dash check OK.
- **Why closed:** All acceptance criteria and test report PASS; no icon-tile or purple regressions.
- **Closed at (UTC):** 2026-07-17 20:57
---
# FEAT-Task: Audience/scale argument bands

## GitHub Issue
- **Number:** #83
- **Title:** Audience/scale argument bands
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/83
- **Labels:** agent:wip → agent:untested

## Problem / goal
Stirling-style audience/scale argument beats icon grids. KM0 needs person / community / org clarity without resurrecting Vision/Mission spam.

## Depends on
#80 zebra kill recommended first so new bands are intentional surfaces.

## High-level instructions for coder
1. Design 2–3 editorial bands (or reshape Why/Offer) for audiences - factual, local/EU.
2. Copy via `km0-web-copy`; es source then ca/en/de.
3. Optional restrained mono meta labels (Nous energy) - do not go dark-lab full page.
4. User counter remains the sacred live stat.
5. Build; bump; gh #83.

## Acceptance
- Scannable audience argument; no equal icon-tile grid
- Four locales

## What was done
- Reshaped `#why` (`WhyKm0.astro`) from usual-vs-KM0 lists into three editorial scale bands: person / community / organisation.
- Mono meta labels (`01 · PERSONA` etc.), factual body + fact line, one CTA each (Cloud / #community / pricing).
- Middle band is an intentional full-bleed Snow surface (not zebra).
- i18n: `vision.bands` in es/ca/en/de; types updated; removed `usual`/`km0` compare keys.
- Cloud user counter left under Offer (`CloudUserStats`).
- Site version bumped to **1.1.113**.

### Pre-flight (anti-slop)
1. **Vibe:** Cool civic editorial - who KM0 serves by scale, factual EU/local.
2. **Layout:** Stacked editorial argument bands (Stirling), left meta rail, not centered cards.
3. **Type:** Bricolage display + Source Serif body; restrained mono meta.
4. **Hue:** Ink + Signal on Paper; one intentional Snow band.
5. **Refuse:** Icon-tile grids, fake stats, Vision/Mission walls, dark-lab full page.

## Testing instructions
1. `docker compose up -d` (image already rebuilt) or rebuild if needed.
2. `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` → expect **200**.
3. Open `/#why` (and `/en/#why`, `/ca/#why`, `/de/#why`):
   - Three scale bands with mono meta labels; no icon-tile grid; no usual-vs-KM0 columns.
   - Middle band (community) is a full-bleed Snow strip; outer canvas stays Paper + Origin motif.
   - CTAs: Cloud (external), #community, /pricing/ (locale-prefixed).
4. Confirm `#cloud-users` still appears under Offer with live count (or unavailable copy).
5. Footer shows version **1.1.113**.
6. Visual anti-slop: no purple gradients, no equal icon cards, no em dashes (`./scripts/check-no-em-dash.sh`).
7. Optional: `docker logs --since 10m km0-web` for 200s on smoke curls.

### Coder smoke evidence (2026-07-17)
- Build: `docker compose build` Astro build Complete (124 pages), version 1.1.113.
- HEAD 200: `/` `/ca/` `/en/` `/de/` `/doc/`.
- ES HTML contains `01 · PERSONA`, `02 · COMUNIDAD`, `03 · ORGANIZACIÓN`, `why-band`, `cloud-users`.
- EN/CA/DE meta labels present in HTML.

## References
- Runbook: docs/runbook.md
- Study: docs/design/reference-study-stirling-satisfecho-nous.md
- Doctrine: docs/design/anti-slop-doctrine.md
- Tokens: docs/brand-tokens.md
- Site: https://km0digital.com

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-17 20:57:06 UTC; end ~20:57:25 UTC. Smoke GETs logged at 20:57:17 UTC.
2. **Environment:** Branch `main`. `km0-web` healthy at `http://127.0.0.1:9180/`. Production `https://km0digital.com/` HTTP 200 (immediate).
3. **What was tested:** Testing instructions 1-7 for audience/scale argument bands (#83).
4. **Results:**
   - HTTP locales: **PASS** - `/` `/ca/` `/en/` `/de/` `/doc/` → 200.
   - Why bands (4 locales): **PASS** - three `why-band` articles with mono metas: ES `01 · PERSONA` / `02 · COMUNIDAD` / `03 · ORGANIZACIÓN`; EN PERSON/COMMUNITY/ORGANISATION; CA PERSONA/COMUNITAT/ORGANITZACIÓ; DE PERSON/GEMEINSCHAFT/ORGANISATION. No usual-vs-KM0 / icon-tile smell.
   - Middle Snow strip: **PASS** - middle band has `why-band--emphasis` with CSS `background-color: var(--color-snow)` + full-bleed margins (intentional, not zebra).
   - CTAs: **PASS** - Cloud → `https://cloud.km0digital.com`; community hash locale-aware; pricing locale-prefixed (`/pricing/`, `/en/pricing/`, etc.).
   - Cloud user counter: **PASS** - `#cloud-users` under Offer with count `28`.
   - Footer version: **PASS** - **Versión 1.1.113**.
   - Anti-slop + em dash: **PASS** - no purple in why HTML; `./scripts/check-no-em-dash.sh` OK.
   - Logs: **PASS** - smoke GETs 200 at 20:57:17.
   - GitHub label `agent:testing` on issue #83: **PASS**.
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`; `https://km0digital.com/`.
7. **Log excerpts:**
   ```
   172.21.0.1 - - [17/Jul/2026:20:57:17 +0000] "GET / HTTP/1.1" 200
   172.21.0.1 - - [17/Jul/2026:20:57:17 +0000] "GET /en/ HTTP/1.1" 200
   172.21.0.1 - - [17/Jul/2026:20:57:17 +0000] "GET /ca/ HTTP/1.1" 200
   172.21.0.1 - - [17/Jul/2026:20:57:17 +0000] "GET /de/ HTTP/1.1" 200
   172.21.0.1 - - [17/Jul/2026:20:57:17 +0000] "GET /doc/ HTTP/1.1" 200
   ```
8. **GitHub:** label `agent:testing` applied on issue #83 at test start.

