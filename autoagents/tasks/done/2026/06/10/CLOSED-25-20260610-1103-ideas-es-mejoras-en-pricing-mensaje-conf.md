---
## Closing summary (TOP)

- **What happened:** Issue #25 requested pricing page improvements for cost presentation, market positioning, trust messaging, KM0 differentiation, and an internal economics document.
- **What was done:** Reworked `Pricing.astro` with a 500 GB / €1.99 plan, market-reference table (approx. €/TB/month column), why-pricing and trust sections, and KM0 differentiator chips; updated i18n across ES/CA/EN/DE; added `docs/pricing-economics.md`; site version bumped to 1.1.43.
- **What was tested:** Docker build (80 pages), HTTP 200 on all locale pricing routes, hero copy, comparison table structure, trust and differentiator grids, mailto CTA, locale translations, footer version, economics doc scenarios, em-dash check, and smoke routes; all PASS.
- **Why closed:** All testing criteria passed.
- **Closed at (UTC):** 2026-06-10 11:07
---

# [ideas/es] Mejoras en pricing: mensaje, confianza y doc interno

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/25
- **Number:** #25
- **Labels:** agent:wip
- **Created:** 2026-06-10T10:57:30Z

## Problem / goal
Rework the public pricing page at `/pricing/` to improve cost presentation, market positioning, trust messaging, and KM0 differentiation. Add an internal economics document for margin modelling.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/25
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation notes
- Reworked `src/views/Pricing.astro`: claim banner, market-reference table (approx. €/TB/month column replaces monthly × GB), why-pricing section, trust cards (6 items), differentiator chips, custom CTA retained.
- Updated i18n in `es.json`, `ca.json`, `en.json`, `de.json`: 500 GB / €1.99 plan, 5× space claim, indicative market references, trust and differentiation copy.
- Extended `src/i18n/types.ts` pricing schema for new sections.
- Added internal doc `docs/pricing-economics.md` with four margin scenarios (base, 30% overselling, +19% cost at full and 30% usage).
- Site version bumped to **1.1.43**.

## Testing instructions
1. `docker compose build && docker compose up -d` (build passed during implementation: 80 pages, em-dash check OK).
2. Confirm HTTP 200:
   - `curl -sI http://127.0.0.1:9180/pricing/`
   - `curl -sI http://127.0.0.1:9180/ca/pricing/`
   - `curl -sI http://127.0.0.1:9180/en/pricing/`
   - `curl -sI http://127.0.0.1:9180/de/pricing/`
3. Open `/pricing/` in a browser and verify:
   - Hero shows **500 GB** and **1,99 €** with 5× claim text.
   - Table has 6 rows; KM0 highlighted; fourth column is **Coste aprox. por TB/mes** (localized per locale), not monthly × GB.
   - Disclaimer states indicative market references, not exact equivalence.
   - **¿Por qué nuestro precio es distinto?** section present.
   - **Confianza y operación** grid with 6 trust cards.
   - **Por qué KM0** differentiator chips (6 items).
   - Custom proposal mailto CTA to `hello.yoel@amvara.de`.
4. Switch locale (CA, EN, DE) on `/pricing/` and confirm translated headings and table headers.
5. Footer shows version **1.1.43** on pricing and home pages.
6. Confirm `docs/pricing-economics.md` exists with base, overselling (30%), and +19% cost scenarios.
7. Optional: em-dash check returns zero matches in `src/`.
8. Smoke: `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` all return 200.

## Test report

1. **Date/time (UTC):** 2026-06-10T11:06:16Z start, 2026-06-10T11:06:43Z end. Log window: 2026-06-10T11:06:28Z through 2026-06-10T11:06:43Z.
2. **Environment:** branch `main` (local uncommitted changes); build via `docker compose build && docker compose up -d` (npm unavailable on host; build ran inside Docker: km0-web@1.1.43, 80 pages, em-dash prebuild OK). Loopback `http://127.0.0.1:9180/`; production smoke `https://km0digital.com/` (pre-deploy baseline only; pricing content verified on loopback build).
3. **What was tested:** All eight testing-instruction criteria plus optional em-dash check and production HTTP smoke.
4. **Results:**
   - Docker build and container up: **PASS** (80 pages, `check-no-em-dash: OK`).
   - Pricing HTTP 200 (ES, CA, EN, DE): **PASS** (all four returned 200).
   - Hero 500 GB / 1,99 € and 5× claim: **PASS** (`500 GB`, `1,99 €`, `Hasta 5 veces más espacio` in `/pricing/` HTML).
   - Comparison table 6 rows, KM0 highlighted, fourth column approx. €/TB/month: **PASS** (6 tbody rows; `pricing-table-row-highlight` on KM0; header `Coste aprox. por TB/mes (€)`; no monthly × GB column).
   - Indicative-market disclaimer: **PASS** (`Referencias orientativas de mercado`; intro states not exact equivalence).
   - Why-pricing section: **PASS** (`¿Por qué nuestro precio es distinto?`).
   - Trust grid 6 cards: **PASS** (6 `pricing-trust-card` elements in rendered HTML).
   - Why KM0 differentiators 6 items: **PASS** (6 `pricing-diff-item` elements).
   - Custom mailto CTA: **PASS** (`mailto:hello.yoel@amvara.de`).
   - Locale switch CA/EN/DE headings and table headers: **PASS** (CA: `Cost aprox. per TB`, `Confiança i operació`, `Per què KM0`; EN: `Approx. cost per TB/month`, `Trust and operations`, `Why KM0`; DE: `Ca. Kosten pro TB`, `Vertrauen und Betrieb`, `Warum KM0`).
   - Footer version 1.1.43 on pricing and home: **PASS** (`Versión 1.1.43` on both `/pricing/` and `/`).
   - `docs/pricing-economics.md` scenarios: **PASS** (base, overselling 30%, +19% cost at 100% and 30% usage documented).
   - Em-dash check: **PASS** (`check-no-em-dash: OK`).
   - Smoke HTTP 200 (`/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`): **PASS**.
   - GitHub label `agent:testing` on issue #25: **PASS** (applied at test start).
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/pricing/`, `/ca/pricing/`, `/en/pricing/`, `/de/pricing/`, `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`; production smoke `https://km0digital.com/`, `https://km0digital.com/pricing/` (200; content not yet deployed).
7. **Log excerpts:**
   ```
   2026/06/10 11:06:28 [notice] 1#1: start worker processes
   172.21.0.1 - - [10/Jun/2026:11:06:30 +0000] "HEAD /pricing/ HTTP/1.1" 200 0 "-" "curl/8.14.1" "-"
   172.21.0.1 - - [10/Jun/2026:11:06:30 +0000] "HEAD /ca/pricing/ HTTP/1.1" 200 0 "-" "curl/8.14.1" "-"
   172.21.0.1 - - [10/Jun/2026:11:06:30 +0000] "HEAD /en/pricing/ HTTP/1.1" 200 0 "-" "curl/8.14.1" "-"
   172.21.0.1 - - [10/Jun/2026:11:06:30 +0000] "HEAD /de/pricing/ HTTP/1.1" 200 0 "-" "curl/8.14.1" "-"
   ```
