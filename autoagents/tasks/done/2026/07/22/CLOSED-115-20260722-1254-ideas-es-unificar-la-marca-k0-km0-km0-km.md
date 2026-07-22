---
## Closing summary (TOP)

- **What happened:** Site copy mixed brand spellings (K0, KM0, km0, Kmo) and product aliases (KM0 Mail vs KM0 Email).
- **What was done:** Locked brand string canon in `docs/brand-tokens.md`; unified user-facing **KM0 Email** across i18n and blog posts; clarified K0 as lettermark; ideas/privacy copy uses product names / KM0 Digital.
- **What was tested:** Tester PASS - zero KM0 Mail/Kmo on tested pages, ideas dropdown+meta, legal privacy opener, day-11/18 copy, brand-tokens table, smoke HTTP, no 5xx.
- **Why closed:** All acceptance criteria passed; naming/copy-only with no anti-slop layout regressions.
- **Closed at (UTC):** 2026-07-22 13:04
---

# [ideas/es] Unificar la marca (K0, KM0, km0, Kmo)

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/115
- **Number:** #115
- **Labels:** agent:wip (→ agent:untested after handoff)
- **Created:** 2026-07-22T12:46:13Z

## Problem / goal
Site copy mixed brand spellings (K0, KM0, km0, Kmo) and product aliases (**KM0 Email** vs **KM0 Mail**, bare `km0digital` as a product nickname). Pick one canonical short form and align user-facing copy.

## Implementation summary
- Locked brand string canon in `docs/brand-tokens.md`: prose short brand **KM0**; full localized name; products **KM0 Cloud / KM0 Email / KM0 Web**; **K0** = lettermark only; lowercase `km0*` for domains/tech only.
- Unified user-facing **KM0 Mail → KM0 Email** across `src/i18n/{es,ca,en,de}.json` and related blog posts under `src/content/doc/` (repos/domains like `km0-mail`, `mail.km0digital.com` unchanged).
- Ideas meta + privacy opener: no bare `km0digital` product nickname; privacy-first line says **KM0 Digital**.
- Day 18: “marca K0” clarified as **lettermark K0 de KM0** (EN: KM0 K0 lettermark).
- Aligned UNTESTED-114 ideas labels to **KM0 Email** so both tasks share one product name.
- Site version: **1.2.8 → 1.2.9** via `./scripts/bump-patch-version.sh`.
- Build/deploy: `docker compose build && docker compose up -d`.
- Pre-emit (copy/docs): P4 H4 E5 S5 R5 V3 (naming lock only; no layout/token churn).

## Testing instructions

### Deploy / smoke
1. Confirm container healthy on `http://127.0.0.1:9180/`.
2. `curl -sI` → **200** for `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/ideas/`, `/legal/`, `/doc/day-11/`.
3. Footer shows **Versión / Version 1.2.9** (or later if stacked bumps).
4. Em-dash / mailto checks green (image `prebuild`).

### Brand string canon
1. Visible HTML on `/`, `/ideas/`, `/legal/`, `/doc/day-11/` must contain **zero** `KM0 Mail` and **zero** `\bKmo\b`.
2. Product/service copy uses **KM0 Email** (landing Offer/FAQ, legal sections, day-11 title).
3. Ideas `#ideas-scope` options: **KM0 Web**, **KM0 Cloud**, **KM0 Email** (not domains, not Mail).
4. Ideas meta description names those three products (no bare `km0digital, Cloud o Mail`).
5. `/legal/` privacy opener refers to **KM0 Digital** (not lowercase `km0digital está/is/ist/està` as the brand subject). Domains like `km0digital.com` remain lowercase.
6. `/doc/day-18/` mentions lettermark K0 **of KM0**, not “marca K0” alone as the brand string.
7. Optional: `docs/brand-tokens.md` “Brand string canon (#115)” table present.

### Tester checklist
- [ ] No `KM0 Mail` / `Kmo` in tested pages; Email product name consistent.
- [ ] Ideas dropdown + meta use KM0 product names.
- [ ] Footer ≥ 1.2.9; locales + `/doc/` HTTP 200.
- [ ] `docker logs --since 10m km0-web` shows no 5xx for tested paths.

## References
- Issue: https://github.com/AMVARA-CONSULTING/km0-web/issues/115
- `docs/brand-tokens.md` (Brand string canon)
- `src/i18n/{es,ca,en,de}.json`
- `src/content/doc/**` (Mail→Email + day-18)
- docs/runbook.md

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-22T13:03:06Z; end 2026-07-22T13:03:54Z. Docker access log window ~13:03:18Z–13:03:41Z.
2. **Environment:** Branch `main`. Healthy `km0-web` on `http://127.0.0.1:9180/` (docker compose image). Footer **1.2.10** (≥1.2.9). Production HEAD `https://km0digital.com/` → **200**, footer **Versión 1.2.10**.
3. **What was tested:** Smoke HTTP; brand string canon on `/`, `/ideas/`, `/legal/`, `/doc/day-11/`, `/doc/day-18/` (four locales); ideas meta + dropdown; privacy opener; `docs/brand-tokens.md` table; docker 5xx; GitHub label.
4. **Results:**
   - HTTP 200 smoke (locales, `/doc/`, `/ideas/`, `/legal/`, `/doc/day-11/`): **PASS**.
   - Footer ≥ 1.2.9: **PASS** - `Versión 1.2.10` / `Version 1.2.10`.
   - Zero `KM0 Mail` / `\bKmo\b` on tested pages: **PASS** - counts 0 across `/`, `/ideas/`, `/legal/`, `/doc/day-11/` × 4 locales; `KM0 Email` present (landing, ideas, legal, day-11).
   - Ideas dropdown + meta product names: **PASS** - options KM0 Web/Cloud/Email; meta e.g. ES `…KM0 Web, KM0 Cloud o KM0 Email.` (no bare `km0digital, Cloud o Mail`).
   - Legal privacy opener uses **KM0 Digital**: **PASS** - ES `KM0 Digital está diseñado…`; EN `KM0 Digital is built…`; CA `KM0 Digital està…`; DE `KM0 Digital ist…` (not lowercase `km0digital` as brand subject). Domains remain lowercase.
   - Day-18 lettermark of KM0: **PASS** - ES/CA `lettermark K0 de KM0`; EN `KM0 K0 lettermark`; DE `K0-Lettermark von KM0`.
   - Day-11 title Email product: **PASS** - `Día 11 - KM0 Email en producción` / EN equivalent.
   - `docs/brand-tokens.md` Brand string canon (#115) table: **PASS** - section present with KM0 / products / K0 lettermark rules.
   - No 5xx: **PASS**.
   - GitHub label `agent:testing` on #115: **PASS**.
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/` (+ `/ca/`, `/en/`, `/de/`), `/ideas/`, `/legal/`, `/doc/day-11/`, `/doc/day-18/` and locale variants; production `https://km0digital.com/` (200).
7. **Log excerpts:** `GET /legal/ … 200`, `GET /doc/day-11/ … 200`, `GET /doc/day-18/ … 200` at 13:03:41Z; no 5xx in `--since 10m`.
8. **GitHub:** label `agent:testing` applied on issue #115 at test start.
