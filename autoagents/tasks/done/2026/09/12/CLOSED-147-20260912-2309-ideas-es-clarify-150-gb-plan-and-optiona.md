---
## Closing summary (TOP)

- **What happened:** Issue #147 (twin #148) asked to clarify the public 150 GB / €1.99 plan and that 1 TB+ / multi-TB is available on request with the same EU servers and support.
- **What was done:** Updated hero tagline, pricing intro/meta/paths/custom closer, and masthead secondary CTA “Request capacity” → contact across locales; no public multi-TB SKU list; internal quote checklist in `docs/pricing-economics.md`; version 1.3.17.
- **What was tested:** Tester PASS: footer 1.3.17; hero and pricing copy all locales; contact-hash secondary CTA; no €/TB list price; HTTP 200; em-dash/mailto; no 5xx.
- **Why closed:** All testing criteria passed; anti-slop skim OK (copy on existing chrome, no purple/centered SaaS/icon-tile regressions). Twin #148 same change set.
- **Closed at (UTC):** 2026-09-12 23:45
---

# [ideas/es] Clarify 150 GB plan and optional TB upgrades

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/147
- **Number:** #147
- **Labels:** none
- **Created:** 2026-09-12T06:34:46Z

## Problem / goal
Ralf wants clearer pricing copy for the public 1.99 € / 150 GB plan so optional larger capacity (TBs) is visible in the pitch. Keep self-serve at 150 GB; state that 1 TB+ / multi-TB is available on request with the same EU servers and support. Twin of #148 (same change set).

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/147
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md
- Twin: #148 (do not re-implement; close as duplicate after this ships)

## Implementation summary
- Shared public pitch (es/ca/en/de): **150 GB self-serve · 1 TB+ / multi-TB on request · same EU servers · same support**
- Updated `hero.tagline`, `pricing.metaDescription`, `pricing.intro`, `pricing.pathsIntro`, custom path card, and `pricing.custom` closer band
- Added `pricing.heroSecondaryCta` ("Request capacity" / locale equivalents) on pricing masthead → `#contact`; primary remains Open Cloud
- Custom path CTA labels aligned to "Request capacity"; no public per-TB list price (SKU unchanged at 1.99 € / 150 GB)
- Internal quote checklist added to `docs/pricing-economics.md` (price/TB, Falkenstein/Hetzner, backup/retention, exit)
- Site version bumped **1.3.16 → 1.3.17**
- Pre-emit: P4 H4 E4 S5 R4 V3 (copy clarity; existing pricing chrome; no invented €/TB matrix)
- Twin #148 covered by this change set

## Testing instructions

1. Sync and confirm footer **1.3.17** (or later if stacked bumps) on `http://127.0.0.1:9180/` and `/en/`.
2. Homepage hero (`/`, `/ca/`, `/en/`, `/de/`): tagline states **150 GB self-serve** and **1 TB+ / multi-TB on request** with same EU servers / same support. Primary CTA still Open Cloud; secondary still pricing.
3. `/pricing/` (all locales): intro repeats the split; masthead has **Open Cloud** + **Request capacity** (contact hash); custom path titled more capacity / 1 TB+ · multi-TB; closer "Need more than 150 GB?" explains quoted terms without a public multi-TB price matrix.
4. Confirm no new published €/TB SKU list for larger plans (comparison table cost-per-TB for market refs may remain).
5. HTTP 200: `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/en/pricing/`. Em dash / mailto checks clean. `docker logs --since 10m km0-web` no 5xx for those paths.
6. After PASS on #147: close or mark duplicate **#148** (same wording).

## Test report

1. **Date/time (UTC):** 2026-09-12T23:43:52Z start → 2026-09-12T23:45:00Z end. Log window: `docker logs --since 2026-09-12T23:43:52Z km0-web` and `--since 10m`.
2. **Environment:** branch `main` (synced). Build: `docker compose build && docker compose up -d`. Loopback `http://127.0.0.1:9180`. Footer **1.3.17**.
3. **What was tested:** Footer version; homepage hero tagline on es/ca/en/de; pricing intro + masthead CTAs + closer band all locales; absence of public multi-TB SKU list; HTTP 200 on required paths; em dash / mailto; docker logs for 5xx; production HEAD readiness poll.
4. **Results:**
   - Footer 1.3.17 on `/` and `/en/`: **PASS**.
   - Homepage hero (all locales): **PASS**. Visible pitch includes 150 GB self-serve / autoservicio / autoservei / Self-Serve and 1 TB+ / multi-TB on request (locale wording); same EU servers / same support. Primary remains Open Cloud; secondary Pricing still present on EN sample.
   - `/pricing/` all locales: **PASS**. Intro repeats split; masthead secondary CTA → contact hash (`Request capacity` → `/en/#contact`, `Pedir capacidad` → `/#contact`, CA `Demanar capacitat`, DE `Kapazität anfragen`); closer “Need more than 150 GB?” / locale equivalents present; quotes language (`Written quote: €/TB…`) without a public larger-plan SKU matrix.
   - No new published €/TB SKU list: **PASS**. Only quote-checklist wording and existing market comparison table (MEGA/etc.); no KM0 multi-TB list price.
   - HTTP 200 `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/en/pricing/` (+ ca/de pricing): **PASS**. Em dash / mailto: **PASS**. Docker logs: **PASS** (0 five-hundreds in 10m window).
   - Production ready: **PASS** for availability (`https://km0digital.com/` HEAD **200** after poll; no fixed sleep). Note: production HTML may still be prior deploy until committer ships; loopback verified the change set.
5. **Overall: PASS**
6. **URLs tested:** loopback homes + pricing locales; `https://km0digital.com/` HEAD 200.
7. **Log excerpts:** `HEAD /pricing/ 200`, `GET /en/pricing/ 200`; no 5xx in window. Twin #148: mark duplicate after this PASS (same wording).
