---
## Closing summary (TOP)

- **What happened:** Issue #142 adapted the ideas-widget "get rid of m$" hook into a clean leave-Microsoft-365 hero line without slang or crude trademark abuse.
- **What was done:** Rewrote `hero.tagline` and `purpose.visionBody` in es/ca/en/de; kept product H1; locked Anti-Big Tech voice rules in doctrine and copy skill; bumped site version.
- **What was tested:** Tester PASS: leave-Microsoft-365 taglines on four locales, product H1 retained, vision lock-in line, zero `m$`, HTTP 200, em-dash/mailto OK, production spot-check.
- **Why closed:** All acceptance criteria passed; copy-only change, no anti-slop layout regressions.
- **Closed at (UTC):** 2026-09-12 23:37
---

# [ideas/es] Central hook: get rid of m$

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/142
- **Number:** #142
- **Labels:** agent:wip
- **Created:** 2026-09-06T17:19:42Z

## Problem / goal
Adapt (do not adopt verbatim) the ideas-widget hook "Get rid of m$?". Public hero should state a clear leave-lock-in alternative without slang or crude trademark abuse.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/142
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md
- Doctrine: docs/design/anti-slop-doctrine.md
- Copy skill: .cursor/skills/km0-web-copy/SKILL.md

## Implementation summary
- **Decision:** adapt Maestro direction 1 (leave Microsoft 365 without losing mail + files). Rejected verbatim `m$`.
- **Hero:** kept product H1 (`Private cloud and email` / locale equivalents). Rewrote `hero.tagline` in es/ca/en/de to lead with the leave-Microsoft-365 line, then EU + 150 GB + public price + human support.
- **Purpose:** tightened `purpose.visionBody` in all four locales to name Big Tech lock-in / EU Cloud+Email alternative (no data-harvest sermon replay).
- **Brand voice lock:** added Anti-Big Tech hook rule under Voice in `docs/design/anti-slop-doctrine.md` and `km0-web-copy` skill (no `m$`, no insult-hooks).
- **Version:** `1.3.14` → `1.3.15` via `./scripts/bump-patch-version.sh`.
- **Pre-emit:** P4 H4 E4 S4 R4 V3 (copy-only within existing hero composition; no layout/token change).
- **Deploy evidence:** `docker compose build && docker compose up -d`; footer shows 1.3.15; hero taglines present on `/`, `/ca/`, `/en/`, `/de/`; no `m$` in HTML.

## Testing instructions

1. Confirm footer version is **1.3.15** on `/` and `/en/`.
2. Hero support line must lead with leave-Microsoft-365 (no `m$`):
   - `/` → `Sal de Microsoft 365 sin perder correo ni archivos`
   - `/ca/` → `Surt de Microsoft 365 sense perdre correu ni fitxers`
   - `/en/` → `Leave Microsoft 365 without losing mail and files`
   - `/de/` → `Microsoft 365 verlassen, ohne Mail und Dateien zu verlieren`
3. Hero H1 still names private cloud + email (product), not an insult slogan.
4. Purpose / vision block mentions EU Cloud+Email as alternative to Big Tech lock-in (scan `#vision` / mission-vision section).
5. Grep built HTML / page source: zero matches for `m$`.
6. HTTP smoke: `curl -sI http://127.0.0.1:9180/` (and `/ca/`, `/en/`, `/de/`, `/doc/`) → 200.
7. `./scripts/check-no-em-dash.sh` and `./scripts/check-no-mailto.sh` → OK.
8. Acceptance: visitor understands KM0 as leave-lock-in alternative without slang or crude trademark abuse.

## Test report

1. **Date/time (UTC) and log window:** Start 2026-09-12T23:36:06Z (UNTESTED → TESTING + `agent:testing`). Checks 23:36:18Z–23:36:37Z. Report close 2026-09-12T23:36:45Z. Docker log window 23:36:06Z–23:36:37Z (container already healthy from coder stack deploy).

2. **Environment:** Branch `main` at `eee4840` (local uncommitted ship under test, package `1.3.17` after stacked bumps #142→1.3.15, #146→1.3.16, #147→1.3.17). Method: existing `docker compose` image `km0-web` healthy on `127.0.0.1:9180->80/tcp` (no rebuild; image already serving 1.3.17). Loopback `http://127.0.0.1:9180/`. Production ready when `curl -sI https://km0digital.com/` returned **200** on first poll; EN hero leave-Microsoft-365 line and footer match loopback.

3. **What was tested:** HTTP smoke on locale + `/doc/`; hero taglines (ES/CA/EN/DE) lead with leave-Microsoft-365; product H1 retained; purpose/vision Big Tech lock-in / EU Cloud+Email line; zero `m$` in page HTML; footer version; em-dash/mailto guards; production EN spot-check; docker access logs for 5xx. Hallmark skim: copy-only within existing hero; pre-emit P4 H4 E4 S4 R4 V3 in Implementation summary; no italic display headers / fake chrome / `transition-all` / invented metrics added by this task.

4. **Results:**
   - **Footer version:** **PASS** - `/` `Versión 1.3.17`; `/en/` `Version 1.3.17` (at/after this task's 1.3.15 bump; later stacked tasks #146/#147).
   - **Hero leave-Microsoft-365 lead (no m$):** **PASS** - ES `Sal de Microsoft 365 sin perder correo ni archivos`; CA `Surt de Microsoft 365 sense perdre correu ni fitxers`; EN `Leave Microsoft 365 without losing mail and files`; DE `Microsoft 365 verlassen, ohne Mail und Dateien zu verlieren`.
   - **Product H1:** **PASS** - ES `Nube privada y correo.`; CA `Núvol privat i correu.`; EN `Private cloud and email.`; DE `Private Cloud und E-Mail.` (not an insult slogan).
   - **Purpose / vision:** **PASS** - `#purpose` EN `EU Cloud and Email as an alternative to Big Tech lock-in`; ES `Cloud y Email en la UE como alternativa al candado de las grandes plataformas`.
   - **Zero m$:** **PASS** - `grep -cF 'm$'` on `/`, `/ca/`, `/en/`, `/de/` → 0 each.
   - **HTTP smoke:** **PASS** - `/`, `/ca/`, `/en/`, `/de/`, `/doc/` all **200**.
   - **Em dash / mailto:** **PASS** - `./scripts/check-no-em-dash.sh` OK; `./scripts/check-no-mailto.sh` OK.
   - **Acceptance:** **PASS** - visitor sees clear leave-lock-in alternative without slang or crude trademark abuse.
   - **Production:** **PASS** - `https://km0digital.com/` **200**; `/en/` footer `Version 1.3.17`; leave-Microsoft-365 tagline present.
   - **GitHub label:** **PASS** - `agent:testing` on #142 at start; removed on PASS → CLOSED.

5. **Overall: PASS**

6. **URLs tested:** Loopback: `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`. Production: `https://km0digital.com/`, `https://km0digital.com/en/`.

7. **Log excerpts:**
   ```
   km0-web Up (healthy) 127.0.0.1:9180->80/tcp
   HEAD / /ca/ /en/ /de/ /doc/ → 200
   GET / /ca/ /en/ /de/ → 200 (hero taglines + H1 + vision confirmed)
   GET /en/ Version 1.3.17; zero m$ on four locales
   check-no-em-dash: OK; check-no-mailto: OK
   prod: HTTP 200; Version 1.3.17; Leave Microsoft 365 without losing mail and files
   (no 5xx on tested paths in log window)
   ```

8. **GitHub:** label `agent:testing` on #142 at start; removed on PASS → CLOSED.
