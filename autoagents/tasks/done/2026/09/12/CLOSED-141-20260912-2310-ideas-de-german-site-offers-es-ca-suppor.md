---
## Closing summary (TOP)

- **What happened:** German locale pages advertised only Spanish and Catalan support, so DE visitors did not see German listed.
- **What was done:** Updated pricing trust, FAQ (`support-languages`), and contact copy in all four locales to list Spanish, Catalan, English, and German; site version bumped for the ship.
- **What was tested:** Tester PASS on loopback and production: HTTP 200, DE/ES/CA/EN four-language strings, DE FAQ + contact, footer version, em-dash/mailto checks.
- **Why closed:** All testing criteria passed; copy-only change with no anti-slop layout regressions.
- **Closed at (UTC):** 2026-09-12 23:29
---

# [ideas/de] German site offers ES/CA support but not German

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/141
- **Number:** #141
- **Labels:** none
- **Created:** 2026-09-06T17:19:41Z

## Problem / goal
## Summary  The submitter notes that the German locale pages advertise Spanish and Catalan support, and asks why German support is not offered the same way. This is a product/copy and i18n consistency request for the DE experience on km0digital.com....

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/141
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- Root cause: `pricing.trust.items[2].desc` listed only Spanish and Catalan on every locale, including `/de/`, so German visitors saw ES/CA support and no Deutsch.
- Updated the same trust line in `src/i18n/{es,ca,en,de}.json` to the shared list: Spanish, Catalan, English, and German (locale-native wording).
- Added FAQ item `support-languages` on all four locales with the same language list.
- Updated `contact.body` on all four locales so the contact band states the reply languages.
- Site version bumped `1.3.13` → `1.3.14` via `./scripts/bump-patch-version.sh`.
- Pre-emit (copy-only, no layout change): P4 H4 E4 S5 R5 V4 - factual language list, no hero noise, no invented metrics.

## Testing instructions

1. **HTTP smoke**
   ```bash
   curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/de/ http://127.0.0.1:9180/doc/
   ```
   Expect `200` on each.

2. **DE pricing trust card lists German**
   ```bash
   curl -s http://127.0.0.1:9180/de/pricing/ | grep -F 'Spanisch, Katalanisch, Englisch und Deutsch'
   ```
   Must match. Must **not** still say only `Spanisch und Katalanisch`.

3. **Shared list on ES / CA / EN pricing**
   ```bash
   curl -s http://127.0.0.1:9180/pricing/ | grep -F 'Castellano, catalán, inglés y alemán'
   curl -s http://127.0.0.1:9180/ca/pricing/ | grep -F 'Castellà, català, anglès i alemany'
   curl -s http://127.0.0.1:9180/en/pricing/ | grep -F 'Spanish, Catalan, English, and German'
   ```

4. **DE FAQ + contact**
   ```bash
   curl -s http://127.0.0.1:9180/de/ | grep -F 'In welchen Sprachen antwortet der Support?'
   curl -s http://127.0.0.1:9180/de/ | grep -F 'Wir antworten auf Spanisch, Katalanisch, Englisch und Deutsch'
   ```

5. **Footer version**
   ```bash
   curl -s http://127.0.0.1:9180/de/ | grep -oE 'Version [0-9.]+'
   ```
   Expect `Version 1.3.14` (or the patch after this task's bump).

6. **Em dash / mailto**
   ```bash
   ./scripts/check-no-em-dash.sh
   ./scripts/check-no-mailto.sh
   ```

Coder evidence (2026-09-12): steps 1-5 PASS locally after `docker compose build && docker compose up -d`; footer `Version 1.3.14` on `/de/`.

## Test report

1. **Date/time (UTC) and log window:** Start 2026-09-12T23:27:00Z (UNTESTED → TESTING + `agent:testing`). Checks 23:27:28Z–23:27:29Z. Report close 2026-09-12T23:27:41Z. Docker log window 23:27:00Z–23:27:29Z (container already healthy from coder stack deploy).

2. **Environment:** Branch `main` at `eee4840` (local uncommitted ship under test, package `1.3.17` after stacked bumps #141→1.3.14 … #147→1.3.17). Method: existing `docker compose` image `km0-web` healthy on `127.0.0.1:9180->80/tcp` (no rebuild; image already serving 1.3.17). Loopback `http://127.0.0.1:9180/`. Production ready when `curl -sI https://km0digital.com/` returned **200** on first poll; footer and DE pricing strings match loopback.

3. **What was tested:** HTTP smoke on locale + `/doc/`; DE pricing trust line includes German; ES/CA/EN pricing shared four-language list; DE FAQ question + support/contact reply languages; footer version; em-dash/mailto guards; production DE pricing spot-check; docker access logs for 5xx.

4. **Results:**
   - **HTTP smoke:** **PASS** - `/`, `/ca/`, `/en/`, `/de/`, `/doc/` all **200**.
   - **DE pricing trust lists German:** **PASS** - `/de/pricing/` contains `Spanisch, Katalanisch, Englisch und Deutsch`; no ES/CA-only trust line remains.
   - **Shared list ES/CA/EN:** **PASS** - ES `Castellano, catalán, inglés y alemán`; CA `Castellà, català, anglès i alemany`; EN `Spanish, Catalan, English, and German`.
   - **DE FAQ + contact:** **PASS** - FAQ `In welchen Sprachen antwortet der Support?`; contact/answer includes `Wir antworten auf Spanisch, Katalanisch, Englisch und Deutsch`.
   - **Footer version:** **PASS** - `Version 1.3.17` on `/de/` (at/after this task's 1.3.14 bump).
   - **Em dash / mailto:** **PASS** - `./scripts/check-no-em-dash.sh` OK; `./scripts/check-no-mailto.sh` OK.
   - **Production:** **PASS** - `https://km0digital.com/` **200**; `/de/` footer `Version 1.3.17`; `/de/pricing/` contains the four-language DE string.
   - **GitHub label:** **PASS** - `agent:testing` on #141 at start; removed on PASS → CLOSED.

5. **Overall: PASS**

6. **URLs tested:** Loopback: `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/ca/pricing/`, `/en/pricing/`, `/de/pricing/`. Production: `https://km0digital.com/`, `https://km0digital.com/de/`, `https://km0digital.com/de/pricing/`.

7. **Log excerpts:**
   ```
   km0-web Up (healthy) 127.0.0.1:9180->80/tcp
   HEAD / /ca/ /en/ /de/ /doc/ → 200
   GET /de/pricing/ 200; GET /pricing/ 200; GET /ca/pricing/ 200; GET /en/pricing/ 200
   GET /de/ 200 (Version 1.3.17)
   check-no-em-dash: OK; check-no-mailto: OK
   prod: HTTP 200; Version 1.3.17; DE four-language trust line present
   (no 5xx on tested paths in log window)
   ```

8. **GitHub:** label `agent:testing` on #141 at start; removed on PASS → CLOSED.
