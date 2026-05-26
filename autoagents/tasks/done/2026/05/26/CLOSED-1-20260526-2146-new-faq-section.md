---
## Closing summary (TOP)

- **What happened:** GitHub issue #1 requested a multilingual FAQ section on the landing page, seeded with a hosting-location Q&A.
- **What was done:** Added `Faq.astro`, wired FAQ i18n in ca/en/de/es, and linked the section from `Landing.astro` and `Header.astro` nav (`#faq`).
- **What was tested:** Tester verified Docker build, locale HTTP smoke (200), FAQ content and accordion in all four locales, section placement, and grep checks — all passed.
- **Why closed:** All acceptance and testing criteria passed.
- **Closed at (UTC):** 2026-05-26 21:49
---

# New FAQ section

## GitHub Issue
- **Number:** #1
- **Title:** New FAQ section
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/1
- **Labels:** (none)

## Problem / goal
Add a new FAQ section to the landing page that matches the existing clean visual style. Content must be available in all four site locales (ca, en, de, es). Seed the section with one Q&A about where the service is hosted (Falkenstein, Germany — Hetzner); polish the answer copy beyond the raw issue text.

## High-level instructions for coder
- Read full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/1
- Add a new FAQ component (e.g. `src/components/Faq.astro`) following patterns used by existing sections (`Values`, `Services`, `Contact`): `section-pad`, `heading-section`, `data-reveal`, existing tokens from `src/styles/`.
- Wire FAQ strings into all four locale files under `src/i18n/` (`ca.json`, `en.json`, `de.json`, `es.json`); extend `Messages` types in `src/i18n/types.ts` as needed.
- Include the section on the landing page in `src/views/Landing.astro` (sensible placement — e.g. before Contact).
- Optional: add a nav anchor in `nav` i18n keys and `Header.astro` if it fits existing nav patterns.
- First FAQ entry:
  - **Q:** Where is the service hosted?
  - **A:** Hosted in Falkenstein, Germany (Hetzner). Write a clear, professional answer; link to https://www.hetzner.com where appropriate.
- Run `npm run build` before renaming to UNTESTED-.
- Deploy verification: `docs/runbook.md` (docker compose, curl locale paths on 9180 / km0digital.com).

## Testing instructions

1. **Build:** `docker compose build` (or `npm run build` if Node is available). Expect Astro build to complete with no errors.
2. **Deploy locally:** `docker compose up -d`
3. **HTTP smoke:** All should return `200`:
   - `curl -sI http://127.0.0.1:9180/`
   - `curl -sI http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/de/`
4. **FAQ section (all locales):** On each landing page, scroll to `#faq` (or use header nav “FAQ”):
   - **es** `/`: section id `faq`, question “¿Dónde está alojado el servicio?”, answer mentions Falkenstein and links to `hetzner.com`
   - **ca** `/ca/`: “On està allotjat el servei?”
   - **en** `/en/`: “Where is the service hosted?”
   - **de** `/de/`: “Wo wird der Service gehostet?”
5. **Accordion:** First item opens by default; click summary toggles expand/collapse; chevron rotates.
6. **Placement:** FAQ appears after Merch showcase and before Contact.
7. **Quick grep:** `curl -s http://127.0.0.1:9180/en/ | grep -E 'id="faq"|hetzner.com'`
8. **Optional production:** `curl -sI https://km0digital.com/en/` after deploy to production host.

## Implementation notes (coder)

- Added `src/components/Faq.astro` (`<details>` accordion, `bg-surface`, before Contact).
- i18n: `faq` block + `nav.faq` in `es.json`, `ca.json`, `en.json`, `de.json`; types in `src/i18n/types.ts`.
- Wired in `Landing.astro` and `Header.astro` nav anchor `#faq`.

## References
- Runbook: docs/runbook.md
- Site: https://km0digital.com

---

## Test report

**Date/time (UTC):** 2026-05-26T21:48:08Z – 2026-05-26T21:48:59Z  
**Log window:** Docker logs from container start at 2026/05/26 21:48:23 UTC

### Environment
- **Branch:** `main`
- **Build method:** `docker compose build && docker compose up -d` (npm not on host; Astro build ran inside Docker — 20 pages, no errors)
- **URLs:** `http://127.0.0.1:9180/` (local loopback)

### What was tested
All criteria from **Testing instructions** §1–7; optional production (§8) attempted.

### Results

| # | Criterion | Result | Evidence |
|---|-----------|--------|----------|
| 1 | Docker build completes without errors | **PASS** | Astro build: `20 page(s) built in 2.13s`, `[build] Complete!` |
| 2 | Local deploy (`docker compose up -d`) | **PASS** | Container `km0-web` Up, port `127.0.0.1:9180->80/tcp` |
| 3 | HTTP smoke — all locales 200 | **PASS** | `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/` → `HTTP/1.1 200 OK` |
| 4 | FAQ section all locales | **PASS** | `id="faq"` present; questions: ES “¿Dónde está alojado el servicio?”, CA “On està allotjat el servei?”, EN “Where is the service hosted?”, DE “Wo wird der Service gehostet?”; all mention Falkenstein + `hetzner.com` link |
| 5 | Accordion behavior | **PASS** | `<details … open>` on first item; chevron SVG has `group-open:rotate-180`; native `<details>` toggle on summary click (browser-default) |
| 6 | Placement after Merch, before Contact | **PASS** | HTML order: merch (“Identity on…”) pos 14761 < faq pos 16612 < contact pos 18116 |
| 7 | Grep `id="faq"` and `hetzner.com` on `/en/` | **PASS** | Both strings found in `/en/` body |
| 8 | Production (optional) | **N/A** | `curl -sI https://km0digital.com/en/` returned HTTP 000 (no outbound connectivity from test host); not required for pass |

**Header nav:** FAQ link present (`href="/en/#faq"`) on English page; locale switcher hreflang links intact.

### Overall
**PASS**

### URLs tested
- `http://127.0.0.1:9180/`
- `http://127.0.0.1:9180/ca/`
- `http://127.0.0.1:9180/en/`
- `http://127.0.0.1:9180/de/`
- `http://127.0.0.1:9180/doc/`
- `http://127.0.0.1:9180/en/doc/day-0/`
- `https://km0digital.com/en/` (attempted, N/A)

### Log excerpts
```
2026/05/26 21:48:23 [notice] 1#1: nginx/1.31.1
2026/05/26 21:48:23 [notice] 1#1: start worker processes
/docker-entrypoint.sh: Configuration complete; ready for start up
```

### GitHub labels
Attempted `agent:testing` on issue #1 — failed (403: token lacks label write permission; labels `agent:testing` / `agent:untested` not present in repo).
