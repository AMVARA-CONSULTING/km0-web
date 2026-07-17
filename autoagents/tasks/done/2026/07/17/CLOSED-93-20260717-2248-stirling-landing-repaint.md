---
## Closing summary (TOP)

- **What happened:** Landing sections needed Stirling argument energy under KM0 brand (surfaces, CTAs, hierarchy).
- **What was done:** Repainted Hero/Offer/Why/Community/FAQ/Contact; moved cloud user proof to Ink band; Cloud primary CTA hierarchy; no i18n string changes; version bumped.
- **What was tested:** Tester PASS - section order and classes on four locales, sacred counter on Ink band, CTA hierarchy, motion hooks retained, anti-slop/HTTP OK.
- **Why closed:** All acceptance criteria passed.
- **Closed at (UTC):** 2026-07-17 23:09
---

# FEAT-Task: Landing restyle - Stirling argument energy

## GitHub Issue
- **Number:** #93
- **Title:** Landing restyle - Stirling argument energy
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/93
- **Labels:** agent:wip → agent:untested

## Problem / goal
Fresh paint on landing sections with Stirling argument energy (bands, CTAs, calm professional hierarchy) under KM0 brand.

## Depends on
#91 and #92 preferred first.

## High-level instructions for coder
1. Repaint Hero, Services/Offer, Why, Community, FAQ, Contact using new surfaces + motion.
2. User counter stays sacred inside offer/proof.
3. Primary CTA = Cloud; no icon-tile grids; no zebra; no purple.
4. i18n only if structure needs new strings.
5. Build; bump; gh #93.

## Acceptance
- Home clearly repainted and professional
- Four locales OK
- Build green

## What was done
- Hero: section space tokens for padding; quieter product proof (no offset shadow).
- Offer: row index meta (01/02); Signal slogan; sticky pin CTA retained (`offer__pin`); removed nested slot.
- Cloud user proof: moved to sibling full-bleed **Ink** band (`surface-ink` / `.cloud-proof`) with sacred counter + Cloud CTA repeat.
- Why: Cloud band uses `btn-primary`; other bands stay text CTAs; Snow emphasis band uses surface tokens.
- Community: Signal rail; Meeting CTA demoted to quiet text link (Cloud stays primary language).
- FAQ: wider calm measure (`max-w-4xl`); refined trigger type.
- Contact: `surface-snow surface-band` + biased two-column closer (email / WhatsApp QR).
- No i18n string changes. Version **1.1.121**.

## Testing instructions

1. **Build / deploy:** `docker compose build && docker compose up -d` already green (Astro build Complete; container `km0-web` up).
2. **HTTP smoke:** `curl -sI http://127.0.0.1:9180/` and `/ca/`, `/en/`, `/de/`, `/doc/` → `200`. Footer shows **1.1.121**.
3. **Landing flow (visual / HTML):** On `/` and `/en/`, confirm section order: Hero → Offer (`#services` + `offer__pin`) → Ink proof (`#cloud-users` + `cloud-proof` + `surface-ink` + Cloud CTA) → Why (`why-band--emphasis` Snow middle) → Community (Signal rail, text Meeting link not `btn-primary`) → FAQ → Contact (`surface-snow surface-band`).
4. **Sacred counter:** `#cloud-users` shows live count (or unavailable copy) on Ink band; Cloud CTA present beside/after it. Not removed, not a fake Fortune-500 strip.
5. **CTA hierarchy:** Primary Cloud CTAs on Hero, Offer pin, Cloud row, Why person band, and Ink proof. Community Meeting is underline text only. Secondary Pricing remains text links.
6. **Motion:** `data-reveal` still on section blocks; Offer sticky pin still works on `lg+` (from #92). Reduced-motion safe.
7. **Anti-slop:** No zebra (`nth-child` odd/even banding), no icon-tile grids, no purple gradients, no Inter-only, no `mailto:`. Ink/Paper/Signal only.
8. **Locales:** Spot-check `/`, `/ca/`, `/en/`, `/de/` headings and Cloud CTAs render (no English-only chrome leaked into Community).
9. **Logs:** `docker logs --since 10m km0-web` - nginx 200s on smoke paths, no 5xx.

## References
- docs/design/stirling-paint-phase.md
- https://stirling.com/
- docs/design/anti-slop-doctrine.md
- docs/brand-tokens.md
- Runbook: docs/runbook.md

## Test report

1. **Date/time (UTC):** start 2026-07-17T23:06:59Z; evidence ~23:06:59Z–23:07:00Z; end 2026-07-17T23:07:21Z.
2. **Environment:** branch `main`; Docker `km0-web` loopback; footer **1.1.122** (≥ 1.1.121).
3. **What was tested:** Landing section order/classes on four locales; sacred counter Ink band; CTA hierarchy; motion hooks; anti-slop; HTTP smoke.
4. **Results:**
   - HTTP + footer → **PASS** (200 `/` `/ca/` `/en/` `/de/` `/doc/`; 1.1.122).
   - Landing flow → **PASS** on all locales: Hero → Offer (`#services` + `offer__pin`) → Ink proof (`#cloud-users` `cloud-proof` `surface-ink`) → Why (`why-band--emphasis`) → Community → FAQ → Contact (`surface-snow surface-band`).
   - Sacred counter → **PASS** (`#cloud-users` / `cloud-proof__stat` present with Cloud CTA on Ink band).
   - CTA hierarchy → **PASS** (Hero/Offer pin/Ink proof/Why person band use `btn-primary` → Cloud; Community Meeting is `community__cta` text only, 0 `btn-primary` in community; Pricing secondary text).
   - Motion → **PASS** (24 `data-reveal`; offer pin retained from #92).
   - Locales → **PASS** (CA community heading "Trobades"; structure identical; no mailto).
   - Anti-slop → **PASS** (no purple, no icon-tile grid, no nth-child zebra, no mailto).
5. **Overall: PASS**
6. **URLs:** `/`, `/ca/`, `/en/`, `/de/`, `/doc/`.
7. **Logs:** nginx 200s on smoke; no 5xx.
