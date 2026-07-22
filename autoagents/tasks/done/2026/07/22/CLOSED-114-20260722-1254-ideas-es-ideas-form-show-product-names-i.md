---
## Closing summary (TOP)

- **What happened:** Ideas form product-scope dropdown showed domain-like strings instead of friendly product names.
- **What was done:** Updated `ideas.scopeOptions` and `ideas.scopeHint` in all four locale i18n files to **KM0 Web / KM0 Cloud / KM0 Email**; kept option values `web`|`cloud`|`mail`; bumped site version through the stack to 1.2.10.
- **What was tested:** Tester PASS - labels and values on all locale `/ideas/` pages, hint defaults to KM0 Web, smoke HTTP 200, footer ≥1.2.8, no 5xx.
- **Why closed:** All acceptance criteria passed; copy-only change with no anti-slop layout regressions.
- **Closed at (UTC):** 2026-07-22 13:04
---

# [ideas/es] Ideas form: show product names instead of domains

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/114
- **Number:** #114
- **Labels:** agent:wip (→ agent:untested after handoff)
- **Created:** 2026-07-22T12:34:16Z

## Problem / goal
The product-scope dropdown on the public ideas form showed domain-like strings (`km0digital`, `cloud.km0digital`, `mail.km0digital`). Show friendly product names instead: **KM0 Web**, **KM0 Cloud**, **KM0 Email**. Keep submitted values `web` / `cloud` / `mail`.

## Implementation summary
- Updated `ideas.scopeOptions` and `ideas.scopeHint` in `src/i18n/es.json`, `ca.json`, `en.json`, `de.json`.
- Labels: web → `KM0 Web`, cloud → `KM0 Cloud`, mail → `KM0 Email` (aligned with brand canon #115; product names identical across locales; hint localized).
- No change to `IdeasForm.astro` option `value`s or `ideas-form.ts` payload (`scope` still `web`|`cloud`|`mail`).
- Site version: **1.2.7 → 1.2.8** via `./scripts/bump-patch-version.sh`.
- Build/deploy: `docker compose build && docker compose up -d` (host has no local `npm`).
- Pre-emit (copy-only): P4 H4 E5 S4 R5 V3 (labels only; no layout/token churn).

## Testing instructions

### Deploy / smoke
1. Confirm container healthy on `http://127.0.0.1:9180/`.
2. `curl -sI` → **200** for `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/ideas/`, `/en/ideas/`, `/ca/ideas/`, `/de/ideas/`.
3. Footer shows **Versión / Version 1.2.8** (or later if stacked bumps).
4. Em-dash / mailto checks green (image `prebuild`).

### Ideas form dropdown
1. Open `/ideas/` (and `/en/ideas/`, `/ca/ideas/`, `/de/ideas/`).
2. `#ideas-scope` options must show visible labels **KM0 Web**, **KM0 Cloud**, **KM0 Email** (not `km0digital`, `cloud.km0digital`, `mail.km0digital`, `KM0 Mail`, or full domains).
3. Confirm `option` values remain `web`, `cloud`, `mail` (inspect HTML or DevTools).
4. Hint under the select mentions **KM0 Web** as the default when unsure (localized wording).
5. Optional: submit a dry-run only if the ideas hook is available; payload `scope` must still be one of `web`|`cloud`|`mail`.

### Tester checklist
- [ ] All four locale ideas pages show product-name labels, not domains.
- [ ] Option values unchanged (`web` / `cloud` / `mail`).
- [ ] Footer version ≥ 1.2.8; locales + `/doc/` HTTP 200.
- [ ] `docker logs --since 10m km0-web` shows no 5xx for tested paths.

## References
- Issue: https://github.com/AMVARA-CONSULTING/km0-web/issues/114
- `src/i18n/{es,ca,en,de}.json` (`ideas.scopeOptions`, `ideas.scopeHint`)
- `src/components/IdeasForm.astro`
- docs/runbook.md

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-22T13:03:06Z; end 2026-07-22T13:03:54Z. Docker access log window ~13:03:18Z–13:03:41Z (`docker logs --since 10m km0-web`).
2. **Environment:** Branch `main`. Site already deployed via coder `docker compose build && docker compose up -d` (image includes prebuild em-dash/mailto checks). Container `km0-web` healthy on `http://127.0.0.1:9180/`. `package.json` version **1.2.10** (stacked after #115/#116; satisfies ≥1.2.8). Production `https://km0digital.com/` polled HEAD → **200** on first attempt; footer **Versión 1.2.10** (same deploy label).
3. **What was tested:** Deploy/smoke HTTP; footer version; `#ideas-scope` labels + values + hint on `/ideas/`, `/en/ideas/`, `/ca/ideas/`, `/de/ideas/`; docker 5xx skim; GitHub `agent:testing`.
4. **Results:**
   - Container healthy + locales/`/doc/`/`/ideas/` HTTP 200: **PASS** - all listed paths returned 200.
   - Footer ≥ 1.2.8: **PASS** - loopback ES `Versión 1.2.10`, EN `Version 1.2.10`.
   - Product-name labels (not domains): **PASS** - all four locales show `KM0 Web` / `KM0 Cloud` / `KM0 Email` as option text. No `km0digital` / `cloud.km0digital` / `mail.km0digital` as option labels. (`mail.km0digital.com` appears only as allowed service hrefs in chrome.)
   - Option values unchanged: **PASS** - `value="web"|"cloud"|"mail"`.
   - Scope hint defaults to KM0 Web: **PASS** - ES `Si no estás seguro, elige KM0 Web.`; EN `If unsure, choose KM0 Web.`; CA `…tria KM0 Web.`; DE `Bei Unsicherheit KM0 Web wählen.`
   - No 5xx in log window: **PASS** - `docker logs --since 10m` had no 5xx; ideas GETs 200.
   - GitHub label `agent:testing` on #114: **PASS**.
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/ideas/`, `/en/ideas/`, `/ca/ideas/`, `/de/ideas/`; production `https://km0digital.com/` (200, ready via immediate HEAD 200 + footer 1.2.10).
7. **Log excerpts:** `km0-web` Up (healthy); e.g. `GET /ideas/ … 200`, `GET /en/ideas/ … 200` at 13:03:29Z; no 5xx.
8. **GitHub:** label `agent:testing` applied on issue #114 at test start.
