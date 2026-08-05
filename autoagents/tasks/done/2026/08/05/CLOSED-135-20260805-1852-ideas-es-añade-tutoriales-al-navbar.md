---
## Closing summary (TOP)

- **What happened:** Issue #135 asked to put Tutorials back in the primary navbar so `/tutorials/` is reachable from desktop and mobile header, not only the footer.
- **What was done:** Added Tutorials to `headerNavLinks` after Blog (7 items), updated `ia-map.md`, bumped site version to 1.2.25; footer Explore unchanged.
- **What was tested:** Tester PASS on all locales for masthead + mobile nav, order ≤7, route 200s, footer Explore + version 1.2.25, em-dash/mailto, anti-slop skim. Craft Hard gate N/A (nav-only).
- **Why closed:** All acceptance criteria passed; ship diff is one nav link + IA doc + version (no anti-slop regressions).
- **Closed at (UTC):** 2026-08-05 18:56
---

# [ideas/es] Añade Tutoriales al Navbar

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/135
- **Number:** #135
- **Labels:** agent:wip
- **Created:** 2026-08-05T18:49:18Z

## Problem / goal
Surface Tutoriales in the primary site navbar so visitors can reach `/tutorials/` from the header (desktop + mobile), not only from the footer.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/135
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md
- Prior nav swap (Ideas in, Tutorials out): `autoagents/tasks/done/2026/07/18/CLOSED-0-20260718-1348-ideas-in-header-nav.md`
- Ideas route removed later (#121 chat widget); header had a free slot (6 items)

## Implementation summary

### Diagnosis
- `/tutorials/` routes and `m.nav.tutorials` already exist in all locales.
- Tutorials lived only in the footer Explore column after the Ideas header swap.
- Ideas page/nav was later removed (#121); primary header had 6 items (under the ≤7 cap).

### Changes
1. `src/lib/site-nav.ts` → `headerNavLinks`: insert Tutorials after Blog (order: home, services, pricing, blog, tutorials, meeting, contact). Still 7 items.
2. `docs/design/ia-map.md`: primary/secondary lists updated (Ideas stale entry replaced; Tutorials primary; Guides noted in secondary).
3. Footer Explore still lists Tutorials (unchanged).
4. Labels reuse existing i18n: es Tutoriales; ca/en/de Tutorials.
5. Version bump: **1.2.24 → 1.2.25**.

### Pre-emit (nav-only IA restore)
- Vibe: civic masthead link restore, no new chrome.
- Layout: existing masthead link row + mobile drawer.
- Type/hue: unchanged tokens.
- Refuse: new pill CTA, extra sticky gadget, invented metrics.
- Pre-emit: P5 H5 E5 S5 R5 V4

### Out of scope
- Redesigning tutorial pages or Offer tutorial links
- Changing footer column structure beyond verifying Tutorials remains

## Testing instructions

### What changed
- Primary header (desktop `masthead__links` + mobile `#mobile-nav`) now includes Tutorials → `/tutorials/` (locale-prefixed).
- Order: Inicio / Servicios / Precios / Blog / **Tutoriales** / Encuentros / Contacto (ES).
- Footer still links Tutorials under Explore.
- Site version **1.2.25**.

### Deploy
```bash
docker compose build && docker compose up -d
```

### Acceptance checks
1. **Desktop header** on `/`, `/ca/`, `/en/`, `/de/`: Tutorials link present with localized label; href `/tutorials/` or `/en|ca|de/tutorials/`.
2. **Mobile nav** (`#mobile-nav`): same Tutorials item.
3. **≤7 primary items**; order Blog → Tutorials → Meeting → Contact.
4. **Routes 200:** `/tutorials/`, `/en/tutorials/`, `/ca/tutorials/`, `/de/tutorials/`, plus `/`, `/ca/`, `/en/`, `/de/`, `/doc/`.
5. **Footer** still has Tutorials under Explore.
6. **Footer version** shows 1.2.25.
7. No em-dash / mailto regressions (`./scripts/check-no-em-dash.sh`, `./scripts/check-no-mailto.sh`).

### Coder evidence (already run)
```text
200 / /ca/ /en/ /de/ /doc/ /tutorials/ /en/tutorials/ /ca/tutorials/ /de/tutorials/
ES header: Inicio Servicios Precios Blog Tutoriales Encuentros Contacto
masthead__link + mobile-nav-link Tutoriales|/Tutorials on all locales
Versión 1.2.25
docker build: 168 page(s) built
```

### URLs
- `http://127.0.0.1:9180/`, `/en/`, `/ca/`, `/de/`
- `http://127.0.0.1:9180/tutorials/`, `/en/tutorials/`, `/ca/tutorials/`, `/de/tutorials/`

## Test report

1. **Date/time (UTC) and log window:** Start 2026-08-05T18:54:50Z; end 2026-08-05T18:55:37Z. Docker log window ~18:55:01–18:55:26Z (container recreate + HTTP probes).
2. **Environment:** Branch `main` (local uncommitted product diff: `src/lib/site-nav.ts`, `docs/design/ia-map.md`, `package.json` 1.2.25). Build: `docker compose build && docker compose up -d`. Loopback `http://127.0.0.1:9180/`; production `https://km0digital.com/` reachability only (change not yet committed/deployed to prod).
3. **What was tested:** Acceptance checks from Testing instructions (desktop + mobile header Tutorials, ≤7 order, route 200s, footer Explore, footer version, em-dash/mailto, Hallmark/anti-slop skim of ship diff). Craft Hard gate N/A (nav-only IA restore, no Stirling/Satisfecho parity FEAT).
4. **Results:**
   - **Desktop header Tutorials (4 locales)** - **PASS.** `/`: Tutoriales → `/tutorials/`; `/ca/`: Tutorials → `/ca/tutorials/`; `/en/`: Tutorials → `/en/tutorials/`; `/de/`: Tutorials → `/de/tutorials/`. All via `class="masthead__link"`.
   - **Mobile nav `#mobile-nav`** - **PASS.** Same labels/hrefs as desktop on all four locales (`data-mobile-nav-link` + `masthead__mobile-link`).
   - **≤7 items + Blog → Tutorials → Meeting → Contact** - **PASS.** Exactly 7 primary items. ES: `Inicio Servicios Precios Blog Tutoriales Encuentros Contacto`. Order around tutorials: Blog → Tutorials → Meeting → Contact (localized) on all locales.
   - **Routes 200** - **PASS.** `/` `/ca/` `/en/` `/de/` `/doc/` `/tutorials/` `/en/tutorials/` `/ca/tutorials/` `/de/tutorials/` all HTTP 200. Container `healthy` after poll (first GET `/` already 200). Docker build: `168 page(s) built`, version `km0-web@1.2.25`.
   - **Footer Explore still has Tutorials** - **PASS.** Explore column includes Tutoriales/Tutorials with correct locale href (ES `/tutorials/`, CA `/ca/tutorials/`, EN `/en/tutorials/`, DE `/de/tutorials/`).
   - **Footer version 1.2.25** - **PASS.** ES `Versión 1.2.25`; CA `Versió 1.2.25`; EN/DE `Version 1.2.25`.
   - **No em-dash / mailto** - **PASS.** Host scripts OK; image prebuild also OK.
   - **Hallmark / anti-slop skim** - **PASS.** Ship diff is one nav link + ia-map + version bump. No italic display headers, fake chrome, metric strips, `transition-all`, or universal `scale-105`. Coder pre-emit P5 H5 E5 S5 R5 V4 present.
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` `/tutorials/` `/en/tutorials/` `/ca/tutorials/` `/de/tutorials/`; `https://km0digital.com/` HEAD 200 (reachability; prod not yet shipping this uncommitted change).
7. **Log excerpts:**
```text
Container km0-web Started; STATUS Up (healthy) 127.0.0.1:9180->80/tcp
[build] 168 page(s) built in 3.98s
127.0.0.1 - - [05/Aug/2026:18:55:12 +0000] "GET / HTTP/1.1" 200
... GET /ca/ /en/ /de/ /doc/ /tutorials/ /en/tutorials/ /ca/tutorials/ /de/tutorials/ ... 200
nginx start worker processes @ 18:55:01; no 5xx in window
```
