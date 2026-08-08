---
## Closing summary (TOP)

- **What happened:** KM0 Email marketing price was opaque ("with the stack") instead of showing 6.99 €/month.
- **What was done:** Locale i18n now publishes 6,99 € / €6.99 on services and pricing paths; Services.astro shows `priceFrom` for Email as well as Cloud; site version 1.2.26.
- **What was tested:** Tester PASS on deploy/HTTP/footer, `#km0-email` and pricing path prices in ES/CA/EN/DE, Cloud unchanged, no leftover stack strings, em-dash/mailto checks, docker logs, production spot-check.
- **Why closed:** All testing criteria passed; not craft-parity (Hard gate N/A); anti-slop skim clean (copy-only, no layout/token churn).
- **Closed at (UTC):** 2026-08-08 19:07
---

# [ideas/es] KM0 Email debe mostrar 6.99 € / mes

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/136
- **Number:** #136
- **Labels:** agent:wip
- **Created:** 2026-08-08T18:58:46Z

## Problem / goal
Show the KM0 Email product price as **6.99 € / month** on the marketing site. Scope is web pricing/product surfaces only. No other product or copy changes requested.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/136
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- Replaced opaque "with the stack" Email path prices with public **6,99 € / mes** (locale-aware: ES/CA `6,99 €`, EN `€6.99`, DE `6,99 €/Monat`) in `src/i18n/{es,ca,en,de}.json` under `pricing.paths` (email) and `services.items` (email `priceFrom` + `priceAriaLabel`).
- `Services.astro`: show `priceFrom` for any product that has it (Email now mirrors Cloud's price line under `#km0-email`).
- Cloud hero/plan **1,99 €** unchanged. Site version bumped **1.2.25 → 1.2.26**.
- Pre-emit: P4 H4 E4 S4 R5 V4 (copy-only price honesty; no layout/token churn).

## Testing instructions

1. **Build / deploy**
   - `docker compose build && docker compose up -d`
   - Confirm container serves: `curl -sI http://127.0.0.1:9180/` → **200**
   - Locales: `curl -sI` for `/ca/`, `/en/`, `/de/`, `/doc/` → **200**
   - Footer shows **Versión 1.2.26** (or locale Version equivalent)

2. **Landing services (`#km0-email`)**
   - ES `/`: under KM0 Email, visible price **6,99 €/mes** (not "Con el stack")
   - CA `/ca/`: **6,99 €/mes**
   - EN `/en/`: **€6.99/month**
   - DE `/de/`: **6,99 €/Monat**
   - Cloud still shows **1,99** / From €1.99 (unchanged)

3. **Pricing paths**
   - ES `/pricing/`: Email path price value **6,99 €**, note **/mes · @km0digital.com**
   - CA `/ca/pricing/`: same **6,99 €** + **/mes · @km0digital.com**
   - EN `/en/pricing/`: **€6.99** + **/month · @km0digital.com**
   - DE `/de/pricing/`: **6,99 €** + **/Monat · @km0digital.com**
   - Confirm HTML has no leftover strings: `Con el stack`, `With the stack`, `Im Stack`, `Amb l'stack`

4. **Checks**
   - `./scripts/check-no-em-dash.sh` → OK
   - `./scripts/check-no-mailto.sh` → OK
   - `docker logs --since 10m km0-web` → no nginx/startup errors related to this change

## Test report

1. **Date/time (UTC) and log window:** Start 2026-08-08T19:05:57Z (sync); UNTESTED → TESTING + `agent:testing` at 19:06:01Z; docker rebuild/up 19:06:08Z; checks 19:06:13Z–19:06:31Z; report close 19:06:33Z. Docker log window from container start 19:06:08Z through pricing GETs 19:06:25Z.
2. **Environment:** Branch `main` (local ship: `package.json`, `Services.astro`, `src/i18n/{es,ca,en,de}.json` uncommitted vs `origin/main` @ `d510038`). Build: `docker compose build && docker compose up -d` (Astro `km0-web@1.2.26`, prebuild em-dash/mailto OK). Loopback `http://127.0.0.1:9180/`. Production `https://km0digital.com/` polled HEAD **200** on first attempt (ready via immediate 200). Craft Hard gate: **N/A** (copy/price honesty; not craft-parity FEAT). GitHub #136.
3. **What was tested:** Testing instructions 1–4: deploy/HTTP/footer 1.2.26; landing `#km0-email` prices ES/CA/EN/DE; Cloud unchanged; pricing path Email prices + leftover stack-string absence; em-dash/mailto scripts; docker logs; production spot-check.
4. **Results:**
   - Build / deploy / HTTP: **PASS** - container Up on `127.0.0.1:9180`; HEAD `/` `/ca/` `/en/` `/de/` `/doc/` `/en/doc/day-0/` `/pricing/` `/ca/pricing/` `/en/pricing/` `/de/pricing/` all **200**.
   - Footer version 1.2.26: **PASS** - ES `Versión 1.2.26`, EN/DE `Version 1.2.26`, CA `Versió 1.2.26`.
   - Landing `#km0-email` prices: **PASS** - ES/CA `6,99 €/mes`; EN `€6.99/month`; DE `6,99 €/Monat`. No "Con el stack" / "With the stack" / "Im Stack" / "Amb l'stack".
   - Cloud prices unchanged: **PASS** - ES/CA `1,99 €/mes`; EN `From €1.99/month`; DE `1,99 €/Monat`.
   - Pricing paths Email: **PASS** - ES/CA `6,99 €` + `/mes · @km0digital.com`; EN `€6.99` + `/month · @km0digital.com`; DE `6,99 €` + `/Monat · @km0digital.com`. Leftover stack strings absent on all four `/pricing/` locales.
   - Checks: **PASS** - `check-no-em-dash` OK; `check-no-mailto` OK.
   - Docker logs: **PASS** - nginx start clean; tested paths **200**; no 5xx in window.
   - Production spot-check: **PASS** - `https://km0digital.com/` **200**, footer `Versión 1.2.26`, `#km0-email` shows `6,99 €/mes` (ready via first-poll 200).
   - GitHub label: **PASS** - `agent:testing` applied at start; removed on PASS → CLOSED.
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` `/en/doc/day-0/` `/pricing/` `/ca/pricing/` `/en/pricing/` `/de/pricing/`; `https://km0digital.com/`.
7. **Log excerpts:**
   ```
   2026/08/08 19:06:08 [notice] 1#1: nginx/1.31.3
   2026/08/08 19:06:08 [notice] 1#1: start worker processes
   172.21.0.1 - - [08/Aug/2026:19:06:14 +0000] "HEAD / HTTP/1.1" 200
   172.21.0.1 - - [08/Aug/2026:19:06:14 +0000] "HEAD /ca/ HTTP/1.1" 200
   172.21.0.1 - - [08/Aug/2026:19:06:14 +0000] "HEAD /en/ HTTP/1.1" 200
   172.21.0.1 - - [08/Aug/2026:19:06:14 +0000] "HEAD /de/ HTTP/1.1" 200
   172.21.0.1 - - [08/Aug/2026:19:06:14 +0000] "HEAD /doc/ HTTP/1.1" 200
   172.21.0.1 - - [08/Aug/2026:19:06:25 +0000] "GET /pricing/ HTTP/1.1" 200
   172.21.0.1 - - [08/Aug/2026:19:06:25 +0000] "GET /en/pricing/ HTTP/1.1" 200
   ```
8. **GitHub:** label `agent:testing` on #136 at start; removed on PASS → CLOSED.
