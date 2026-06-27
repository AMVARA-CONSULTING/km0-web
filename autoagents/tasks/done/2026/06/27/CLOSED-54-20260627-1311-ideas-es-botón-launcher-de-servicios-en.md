---
## Closing summary (TOP)

- **What happened:** Issue #54 requested a Google-style 3x3 services launcher in the navbar for quick access to KM0 Cloud and Mail.
- **What was done:** Added `ServicesLauncher.astro`, integrated it in `Header.astro` right of the language switcher, and added i18n keys for open/close labels in all four locales.
- **What was tested:** Docker build, HTTP smoke, launcher visibility, panel content and links, accessibility attributes, close behavior, mobile nav regression, footer version 1.1.87, and production markup; overall **PASS**.
- **Why closed:** All testing criteria passed; launcher works across locales on loopback and production.
- **Closed at (UTC):** 2026-06-27 13:21
---

# [ideas/es] Botón launcher de servicios en navbar (estilo Google)

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/54
- **Number:** #54
- **Labels:** none
- **Created:** 2026-06-26T18:06:45Z

## Problem / goal
## Summary  The submitter asks for a Google Chrome-style app launcher button (the familiar 3x3 grid icon) on the right side of the navbar. Clicking it should open access to Kilometer 0 Digital services, similar to Google's services menu in Chrome. Fo...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/54
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary

- Added `src/components/ServicesLauncher.astro`: 3x3 grid toggle button, dropdown panel with Cloud and Mail links sourced from `services.items` (scales as more services are added).
- Integrated launcher in `src/components/Header.astro` to the right of the language switcher (visible on desktop and mobile).
- i18n keys `nav.servicesLauncherOpen`, `nav.servicesLauncherClose`, `nav.servicesLauncherTitle` in es/ca/en/de; types updated in `src/i18n/types.ts`.
- Site version bumped to **1.1.87**.

## Testing instructions

1. **Build:** `docker compose build && docker compose up -d` (or `npm run build` locally).
2. **HTTP smoke:** `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` expect **200**.
3. **Launcher visible:** Open `/` (and `/en/`, `/ca/`, `/de/`). In the navbar, right of the language pills, confirm a round **9-dot grid** button appears (before the mobile hamburger on narrow viewports).
4. **Panel opens:** Click the grid button. A panel titled "Servicios KM0" (or locale equivalent) shows **KM0 Cloud** and **KM0 Email** with icons.
5. **Links work:** Cloud opens `https://cloud.km0digital.com`, Mail opens `https://mail.km0digital.com` (new tab).
6. **Close behavior:** Panel closes on outside click, Escape key, or after choosing a service.
7. **Accessibility:** Toggle has `aria-expanded`; panel has `role="menu"` and localized `aria-label`.
8. **Footer version:** Footer shows **1.1.87** on all locales.
9. **Regression:** Mobile nav hamburger still works; language switcher unchanged.

## Test report

1. **Date/time (UTC):** 2026-06-27T13:17:41Z – 2026-06-27T13:19:57Z. Log window: Docker/nginx from 13:18:48Z.
2. **Environment:** branch `main` @ `87d8d56` (uncommitted: `ServicesLauncher.astro`, `Header.astro`, i18n, `package.json` 1.1.87); build via `docker compose build && docker compose up -d`. URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Google-style services launcher in navbar per testing instructions: visibility, panel markup, service links, accessibility attributes, close-behavior script, mobile nav regression, footer version, production readiness.
4. **Results:**
   - Docker build & deploy: **PASS** (96 pages, em-dash check OK)
   - HTTP smoke (`/`, `/ca/`, `/en/`, `/de/`): **PASS** (200 OK)
   - 9-dot grid button present (right of language pills, 9 SVG circles): **PASS**
   - Panel title **Servicios KM0** with **KM0 Cloud** and **KM0 Email**: **PASS**
   - Cloud link `https://cloud.km0digital.com` with `target="_blank"`: **PASS**
   - Mail link `https://mail.km0digital.com` with `target="_blank"`: **PASS**
   - Toggle `aria-expanded="false"`, panel `role="menu"`, localized `aria-label`: **PASS**
   - Close behavior (outside click, Escape, link click handlers in bundled script): **PASS** (verified in HTML/JS)
   - EN locale panel `aria-label="Open KM0 services"`: **PASS**
   - Mobile hamburger (`data-mobile-menu-toggle`) still present: **PASS**
   - Footer version **1.1.87** (ES/CA/EN/DE): **PASS**
   - Production: launcher markup on `https://km0digital.com/`: **PASS**
   - GitHub label `agent:testing` on issue #54: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/en/`, `/ca/`, `/de/`; `https://km0digital.com/`.
7. **Log excerpts:**
   ```
   13:18:47 [build] 96 page(s) built in 3.42s
   172.21.0.1 - - [27/Jun/2026:13:19:27 +0000] "GET / HTTP/1.1" 200 53896
   172.21.0.1 - - [27/Jun/2026:13:19:27 +0000] "GET /en/ HTTP/1.1" 200 53441
   172.21.0.1 - - [27/Jun/2026:13:19:27 +0000] "GET /ca/ HTTP/1.1" 200 53907
   172.21.0.1 - - [27/Jun/2026:13:19:27 +0000] "GET /de/ HTTP/1.1" 200 54162
   ```
8. **GitHub:** label `agent:testing` applied on issue #54 at test start.
