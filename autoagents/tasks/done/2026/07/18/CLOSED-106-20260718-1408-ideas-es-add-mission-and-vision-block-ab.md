---
## Closing summary (TOP)

- **What happened:** Landing lacked a clear mission/vision closer above the footer stating the 10M-by-2030 horizon and local-infrastructure vision.
- **What was done:** Added `Purpose.astro` (`#purpose`) on Landing only with full es/ca/en/de copy; Signal-ruled editorial Mission | Vision split on Paper after Contact.
- **What was tested:** Locales 200; `#purpose` after contact before footer with correct copy; absent off-landing; anti-slop structure PASS; Overall PASS.
- **Why closed:** Acceptance and anti-slop checks passed; skim found no Inter-only, purple gradients, or icon-tile grids.
- **Closed at (UTC):** 2026-07-18 14:18
---

# [ideas/es] Add mission and vision block above the footer

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/106
- **Number:** #106
- **Labels:** agent:wip
- **Created:** 2026-07-18T11:56:15Z

## Problem / goal
Add a mission and vision statement on the landing page only, just above the footer. Mission: connect 10,000,000 humans by 2030. Vision: honest, local infrastructure and personalized support as an alternative to gated big tech that harvests user data. Full i18n (es/ca/en/de). Anti-slop frontend required.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/106
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation notes
- New `src/components/Purpose.astro` (`#purpose`): split editorial Mission | Vision on continuous Paper (after Contact Snow band).
- Wired in `src/views/Landing.astro` only (not pricing/other pages).
- i18n keys under `purpose` in es/ca/en/de + `Messages` type.
- Site version bumped to **1.1.144**.

## Testing instructions

### Smoke
1. `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` → expect **200**.
2. Footer shows **Versión 1.1.144** (or locale equivalent) on home.
3. `docker logs --since 10m km0-web` → no nginx/build errors for these requests.

### Purpose block (landing only)
4. Open `http://127.0.0.1:9180/#purpose` (ES): section `#purpose` appears **after** `#contact` and **before** the footer; heading "Misión y visión"; mission text includes **10.000.000** and **2030**; vision mentions local/honest infrastructure vs gated platforms.
5. Repeat for `/ca/#purpose`, `/en/#purpose`, `/de/#purpose` (localized copy; EN uses `10,000,000`).
6. Confirm **absence** on non-landing pages: `curl -s http://127.0.0.1:9180/pricing/ | grep -c 'id="purpose"'` → **0**.

### Anti-slop visual check
7. Desktop (`lg+`) and mobile: two-column editorial split (stacked on small screens), Signal left rule on heading, no icon-tile cards, no purple/indigo gradients, no fake “10M+” achievement strip, no centered SaaS dual-CTA recipe. Mission reads as a horizon goal, not a current user counter.
8. Distinct from existing `#why` scale bands (`vision` i18n): purpose is a short closer, not a third copy of privacy sermon.

## Test report

1. **Date/time (UTC):** 2026-07-18 14:17:58 start → 14:18:30 end. Log window shares healthy container from 14:15:36Z deploy; purpose checks at 14:18:07Z.
2. **Environment:** branch `main` (uncommitted coder tree); `docker compose` km0-web healthy `127.0.0.1:9180`; version footer **1.1.146** (task note 1.1.144 superseded by later bumps on same tree).
3. **What was tested:** Smoke locales; `#purpose` presence/copy ES/CA/EN/DE; position after `#contact` before footer; absence on non-landing; anti-slop structure vs `#why`.
4. **Results:**
   - Smoke 200: **PASS** - `/` `/ca/` `/en/` `/de/` `/doc/`.
   - Footer version: **PASS** - 1.1.146 (≥ 1.1.144 bump chain).
   - Logs: **PASS** - no error/crit in recent window.
   - ES `#purpose`: **PASS** - H2 `Misión y visión`; mission `Conectar a 10.000.000 de personas en 2030.`; vision local/honest infrastructure vs closed platforms/data. After contact, before footer (`contact_pos < purpose_pos < footer_pos`).
   - CA/EN/DE: **PASS** - CA `10.000.000` / 2030; EN `10,000,000` + gated big tech harvest; DE `10.000.000` / 2030. All after contact before footer.
   - Absence off landing: **PASS** - `id="purpose"` count 0 on `/pricing/`, `/en/pricing/`, `/meeting/`, `/ideas/`. Wired only via `Landing.astro`.
   - Anti-slop: **PASS** - Signal left border on header; `purpose__grid` 2-col at `md+` (stacks default); 0 SVG icons, 0 purple/indigo, 0 card shadows, 0 CTA buttons; mission display type as horizon goal. Distinct from `#why` “Elige tu escala” product scale bands.
5. **Overall: PASS**
6. **URLs:** `http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/#purpose` (section in home HTML); `/pricing/` `/meeting/` `/ideas/` (absence); `https://km0digital.com/` HEAD 200 earlier in session.
7. **Logs:** container healthy; access 200s; no nginx errors.
