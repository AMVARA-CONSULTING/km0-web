---
## Closing summary (TOP)

- **What happened:** Hero right plane changed from logo shrine to a Cloud/Email product-proof panel.
- **What was done:** Remodeled `Hero.astro` with chrome, plan meter, file rows, Email strip; i18n `hero.proof` in four locales; CTA canon kept (Cloud primary, Pricing text link).
- **What was tested:** Tester PASS - product panel not logo shrine; locale strings; single primary + text link; no orbs/glow/purple; mobile max-width OK.
- **Why closed:** All acceptance criteria and test report PASS; anti-slop hero ban list clean.
- **Closed at (UTC):** 2026-07-17 20:57
---
# FEAT-Task: Hero product-proof 2.0

## GitHub Issue
- **Number:** #82
- **Title:** Hero product-proof 2.0
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/82
- **Labels:** agent:wip → agent:untested

## Problem / goal
Hero split is good; right plane still logo-shrine. Satisfecho proves product in-view; Stirling sells outcome.

## Depends on
Prefer #81 mark landed first (or use interim product UI without relying on old pin as hero centrepiece).

## High-level instructions for coder
1. Remodel `Hero.astro` proof pane into unmistakable Cloud/Email product proof (board, UI crop, live-feeling panel).
2. Keep CTA canon: primary Cloud, secondary Pricing text link.
3. No orbs/glow/dual pills. Mobile-safe.
4. i18n: only if new strings needed.
5. Build; bump; gh #82.

## Acceptance
- First viewport: brand + proof of product, not only logo
- Ban list clean

## Implementation notes (coder)
- Replaced logo-shrine proof with a Cloud UI crop: chrome bar (small origin stamp + app name + UE status), 500 GB plan + price + meter, file/folder rows, Email strip (`@km0digital.com`).
- i18n `hero.proof` in es/ca/en/de; types updated. Mark stays chrome-sized only.
- CTA unchanged: primary Cloud, secondary Pricing text link. Site version **1.1.111**.

## Testing instructions
1. **Docker:** `docker compose ps` shows `km0-web` up; footer on `/` shows **Versión 1.1.111**.
2. **Locales HTTP 200:** `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/`.
3. **Hero proof (es):** open `/` - right plane is a product panel (not a large centered logo). Expect chrome “KM0 Cloud”, status “UE · activo”, “Plan 500 GB”, Hetzner meta, file rows, and KM0 Email `@km0digital.com`.
4. **Locales:** `/en/` shows “500 GB plan” / “EU · online”; `/ca/` “Pla 500 GB”; `/de/` “500-GB-Plan”. Stamp in chrome is small (`hero__proof-stamp`), not the dominant visual.
5. **CTA:** primary “Abrir KM0 Cloud” → `cloud.km0digital.com`; secondary text link → `/pricing/` (locale-prefixed on ca/en/de).
6. **Anti-slop:** no dual pill CTAs, no orbs/glow, no purple gradient, no Inter-only; brand wordmark still hero-level left.
7. **Mobile:** narrow viewport - proof sits below copy without crushing headline/CTA; panel max-width ~28rem centered on small screens.
8. **Logs:** `docker logs --since 10m km0-web` - no nginx errors on home GETs.

## References
- Runbook: docs/runbook.md
- Study: docs/design/reference-study-stirling-satisfecho-nous.md
- Doctrine: docs/design/anti-slop-doctrine.md
- Tokens: docs/brand-tokens.md
- Site: https://km0digital.com

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-17 20:56:17 UTC; end ~20:57:00 UTC. Home locale GETs in docker logs during this window.
2. **Environment:** Branch `main`. `km0-web` healthy at `http://127.0.0.1:9180/`. Production already serving matching build (Versión 1.1.113, HTTP 200).
3. **What was tested:** Testing instructions 1-8 for hero product-proof 2.0 (#82).
4. **Results:**
   - Docker + footer: **PASS** - healthy; **Versión 1.1.113** (>= task 1.1.111).
   - Locales HTTP: **PASS** - `/` `/ca/` `/en/` `/de/` `/doc/` → 200.
   - Hero proof (es): **PASS** - `hero__proof` panel with KM0 Cloud chrome, `UE · activo`, `Plan 500 GB`, Hetzner meta, file rows, `@km0digital.com`; stamp img 28×28 (`hero__proof-stamp`), not logo shrine.
   - Locales: **PASS** - en `500 GB plan` / `EU · online`; ca `Pla 500 GB`; de `500-GB-Plan`; small stamp on all.
   - CTA: **PASS** - one `btn-primary` → `cloud.km0digital.com`; secondary `hero__link` → `/pricing/` (locale-prefixed on ca/en/de).
   - Anti-slop: **PASS** - no orb/glow/purple; single primary + text link (not dual pills); brand/heading present in hero; stamp CSS 1.5rem.
   - Mobile layout CSS: **PASS** - `.hero__proof` `max-width: 28rem` in built CSS; source Hero.astro confirms.
   - Logs: **PASS** - home GETs 200; no 5xx in window for smoke.
   - GitHub label `agent:testing` on issue #82: **PASS**.
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`.
7. **Log excerpts:** home locale GET 200 lines in `docker logs --since 15m km0-web` (see prior smoke window).
8. **GitHub:** label `agent:testing` applied on issue #82 at test start.

