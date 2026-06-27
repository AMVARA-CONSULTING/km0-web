---
## Closing summary (TOP)

- **What happened:** Issue #55 requested the pricing page hero to show storage capacity above price, with capacity emphasized visually.
- **What was done:** Swapped hero stat order in `Pricing.astro` so capacity (e.g. 500 GB) renders above price with gradient typography; price appears smaller and muted below.
- **What was tested:** Docker build, HTTP smoke on `/pricing/` for all locales, DOM order and CSS classes, aria-label, comparison table regression, footer version 1.1.87, and production layout; overall **PASS**.
- **Why closed:** All testing criteria passed; capacity-above-price hierarchy verified on loopback and production.
- **Closed at (UTC):** 2026-06-27 13:21
---

# [ideas/es] Invertir precio y capacidad en la página /pricing/

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/55
- **Number:** #55
- **Labels:** none
- **Created:** 2026-06-27T13:01:09Z

## Problem / goal
## Summary  On the pricing page (`/pricing/`), the submitter wants the storage capacity (e.g. 500 GB) shown above the price (e.g. 1,99 €/month), with the capacity emphasized: larger, colored, and more prominent. The price should appear below and in s...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/55
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation
- **`src/views/Pricing.astro`**: Swapped hero stat order so storage capacity (`heroPrice.meta`, e.g. 500 GB) renders above price (`heroPrice.amount` + `heroPrice.period`). Renamed CSS classes for clarity: capacity uses large gradient typography; price uses smaller muted text below.
- **Site version:** 1.1.84 → 1.1.85 (`package.json`).

## Testing instructions

1. **Build:** `docker compose build && docker compose up -d` (or `npm run build` when Node is available).
2. **HTTP smoke:** `curl -sI http://127.0.0.1:9180/pricing/` → expect `200`.
3. **Hero hierarchy (ES):** Open `/pricing/` and confirm:
   - **500 GB** appears **above** **1,99 € /mes**.
   - Capacity is large with orange/pink gradient; price is smaller and muted gray.
4. **Locales:** Repeat visual check on `/ca/pricing/`, `/en/pricing/`, `/de/pricing/` (same order, localized period text).
5. **Accessibility:** Hero stat `aria-label` still describes price and capacity (unchanged i18n).
6. **Regression:** Comparison table and remaining sections unchanged; footer shows version **1.1.85**.

## Test report

1. **Date/time (UTC):** 2026-06-27T13:17:41Z – 2026-06-27T13:19:57Z. Log window: Docker/nginx from 13:18:48Z.
2. **Environment:** branch `main` @ `87d8d56` (uncommitted: `Pricing.astro`, `package.json` 1.1.87); build via `docker compose build && docker compose up -d`. URLs: loopback `http://127.0.0.1:9180/pricing/`, production `https://km0digital.com/pricing/`.
3. **What was tested:** Pricing hero capacity-above-price layout per testing instructions: HTTP smoke, DOM order, CSS classes, aria-label, all locales, comparison table regression, footer version, production readiness.
4. **Results:**
   - Docker build & deploy: **PASS**
   - HTTP smoke (`/pricing/`, `/ca/pricing/`, `/en/pricing/`, `/de/pricing/`): **PASS** (200 OK)
   - ES hero: **500 GB** above **1,99 € /mes** in DOM (`pricing-hero-capacity` before `pricing-hero-price`): **PASS**
   - Capacity uses `pricing-hero-capacity-gradient`; price uses `pricing-hero-price` (muted): **PASS**
   - Hero `aria-label="Precio: 1,99 euros al mes por 500 GB de almacenamiento"`: **PASS**
   - Locales CA/EN/DE same capacity-before-price order: **PASS**
   - Comparison table section (`pricing-table`) unchanged: **PASS**
   - Footer version **1.1.87** (combined delivery; task noted 1.1.85): **PASS**
   - Production `https://km0digital.com/pricing/` has `pricing-hero-capacity` before price: **PASS**
   - GitHub label `agent:testing` on issue #55: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/pricing/`, `/ca/pricing/`, `/en/pricing/`, `/de/pricing/`; `https://km0digital.com/pricing/`.
7. **Log excerpts:**
   ```
   172.21.0.1 - - [27/Jun/2026:13:18:59 +0000] "HEAD /pricing/ HTTP/1.1" 200 0
   172.21.0.1 - - [27/Jun/2026:13:19:46 +0000] "GET /pricing/ HTTP/1.1" 200 25281
   172.21.0.1 - - [27/Jun/2026:13:19:46 +0000] "GET /ca/pricing/ HTTP/1.1" 200 25279
   172.21.0.1 - - [27/Jun/2026:13:19:46 +0000] "GET /en/pricing/ HTTP/1.1" 200 24963
   172.21.0.1 - - [27/Jun/2026:13:19:46 +0000] "GET /de/pricing/ HTTP/1.1" 200 25198
   ```
8. **GitHub:** label `agent:testing` applied on issue #55 at test start.
