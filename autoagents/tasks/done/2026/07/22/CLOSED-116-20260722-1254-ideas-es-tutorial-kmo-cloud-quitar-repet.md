---
## Closing summary (TOP)

- **What happened:** Spanish (and Catalan) KM0 Cloud getting-started tutorial intro repeated "desde" / "des de" awkwardly.
- **What was done:** Rewrote ES and CA lead sentences in `getting-started-web.md` to drop the double preposition; left EN/DE unchanged; bumped to 1.2.10.
- **What was tested:** Tester PASS - ES/CA leads match expected wording with no double-preposition phrases; tutorial paths 200; footer ≥1.2.10; no 5xx.
- **Why closed:** All acceptance criteria passed; copy-only with no anti-slop layout regressions.
- **Closed at (UTC):** 2026-07-22 13:04
---

# [ideas/es] Tutorial KMo Cloud: quitar repetición «desde»

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/116
- **Number:** #116
- **Labels:** agent:wip (→ agent:untested after handoff)
- **Created:** 2026-07-22T12:47:24Z

## Problem / goal
Spanish tutorial "Cómo empezar a usar KM0 Cloud en el navegador" intro repeated "desde" ("desde un navegador web, desde cero"). Rewrite for smoother reading. Product scope: public web.

## Implementation summary
- Rewrote ES lead in `src/content/tutorials/es/getting-started-web.md`: dropped double "desde … desde …"; now "cómo acceder a KM0 Cloud en el navegador" (aligns with title wording).
- Mirrored the same fix in CA (`src/content/tutorials/ca/getting-started-web.md`: "des d'…, des de zero" → "al navegador").
- Left EN/DE unchanged (no awkward double preposition).
- Site version: **1.2.9 → 1.2.10** via `./scripts/bump-patch-version.sh`.
- Build/deploy: `docker compose build && docker compose up -d` (host has no local `npm`).
- Pre-emit (copy-only): P4 H4 E5 S4 R5 V3 (lead sentence only; no layout/token churn).

## Testing instructions

### Deploy / smoke
1. Confirm container healthy on `http://127.0.0.1:9180/`.
2. `curl -sI` → **200** for `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/tutorials/getting-started-web/`, `/ca/tutorials/getting-started-web/`.
3. Footer shows **Versión / Version 1.2.10** (or later if stacked bumps).
4. Em-dash / mailto checks green (image `prebuild`).

### Tutorial intro copy
1. Open `/tutorials/getting-started-web/`.
2. Intro lead must **not** contain `desde un navegador web, desde cero`.
3. Expected ES lead: `Esta guía explica cómo acceder a KM0 Cloud en el navegador. No necesitas conocimientos técnicos: solo tu navegador habitual y tus credenciales.`
4. Open `/ca/tutorials/getting-started-web/` and confirm lead uses `al navegador` (no `des d'un navegador web, des de zero`).
5. Optional: `/en/` and `/de/` tutorials still 200; copy may keep prior wording.

### Tester checklist
- [ ] ES intro has no double "desde" in one sentence.
- [ ] CA intro has no double "des" / "des de" in one sentence.
- [ ] Footer version ≥ 1.2.10; locales + `/doc/` HTTP 200.
- [ ] `docker logs --since 10m km0-web` shows no 5xx for tested paths.

## References
- Issue: https://github.com/AMVARA-CONSULTING/km0-web/issues/116
- `src/content/tutorials/es/getting-started-web.md`
- `src/content/tutorials/ca/getting-started-web.md`
- docs/runbook.md

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-22T13:03:06Z; end 2026-07-22T13:03:54Z. Docker access log window ~13:03:18Z–13:03:41Z.
2. **Environment:** Branch `main`. Healthy `km0-web` on `http://127.0.0.1:9180/`. Footer **1.2.10**. Production HEAD `https://km0digital.com/` → **200**, footer **Versión 1.2.10**.
3. **What was tested:** Smoke HTTP; ES/CA tutorial intro lead on `/tutorials/getting-started-web/` and `/ca/tutorials/getting-started-web/`; EN/DE optional 200; footer; docker 5xx; GitHub label.
4. **Results:**
   - HTTP 200 for `/`, locales, `/doc/`, tutorial paths: **PASS** - ES/CA/EN/DE `…/tutorials/getting-started-web/` all 200.
   - Footer ≥ 1.2.10: **PASS** - `Versión 1.2.10`.
   - ES intro no double "desde": **PASS** - live lead: `Esta guía explica cómo acceder a KM0 Cloud en el navegador. No necesitas conocimientos técnicos: solo tu navegador habitual y tus credenciales.` Grep for `desde un navegador web, desde cero` → 0.
   - CA intro no double "des"/"des de": **PASS** - live lead: `Aquesta guia explica com accedir a KM0 Cloud al navegador. …` Grep for `des d'un navegador web, des de zero` → 0.
   - EN/DE tutorials still 200: **PASS** (copy left as prior wording per task).
   - No 5xx: **PASS**.
   - GitHub label `agent:testing` on #116: **PASS**.
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/tutorials/getting-started-web/`, `/ca/tutorials/getting-started-web/`, `/en/tutorials/getting-started-web/`, `/de/tutorials/getting-started-web/`, locales + `/doc/`; production `https://km0digital.com/` (200).
7. **Log excerpts:** `GET /tutorials/getting-started-web/ … 200`, `GET /ca/tutorials/getting-started-web/ … 200` at 13:03:23Z; no 5xx.
8. **GitHub:** label `agent:testing` applied on issue #116 at test start.
