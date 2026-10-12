---
## Closing summary (TOP)

- **What happened:** Legal and security body copy stayed invisible on phones because a tall `[data-reveal]` wrapper never met IntersectionObserver's 18% threshold.
- **What was done:** Reveal moved to each section, observer threshold set to 0 with an on-screen check, and a noscript media query keeps copy visible without JS (footer 1.3.25).
- **What was tested:** Playwright 375x812 on `/en/legal/` (four locales), `/en/security/`, TOC jumps, reduced motion, desktop, HTTP 200. Overall PASS. No physical iOS device.
- **Why closed:** Tester overall PASS; ship diff is a visibility fix with no anti-slop regressions (not a craft-parity Hard gate FEAT).
- **Closed at (UTC):** 2026-10-06 14:05
---

# [ideas/en] Legal notice has no content on phone

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/151
- **Number:** #151
- **Labels:** agent:wip (was agent:planned)
- **Created:** 2026-10-05T18:29:39Z

## Problem / goal
Ralf reports that the legal notice page shows no content when viewed on a phone (iPhone Safari/Brave). Body copy was in the HTML but stayed `opacity: 0` because the whole `.doc-body` was one `[data-reveal]` node taller than the viewport, and IntersectionObserver used `threshold: 0.18` (18% of a tall node can never intersect a phone screen).

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/151
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary

**Pre-flight**
- Vibe: Civic legal reading column; the notice must be readable on a phone without waiting for a tall-element observer.
- Layout archetype: editorial column (existing page-masthead + TOC + sections).
- Type pair: IBM Plex Sans display + body.
- Anchor hue: Paper / Ink + Signal (no new tokens).
- Refuse: one opacity-0 wrapper around the whole essay; purple gradients; icon-tile cards.

**Pre-emit:** P4 H5 E5 S4 R5 V4

**Cause:** `[data-reveal]` starts at `opacity: 0`. IntersectionObserver required 18% of the target in view. The legal (and security) `.doc-body` is far taller than a phone viewport, so `intersectionRatio` never reached 0.18 and the notice stayed invisible. Desktop viewports were often just tall enough for the same node, which matches "works on computer, empty on phone."

**Fix**
- `src/scripts/scroll-reveal.ts`: `threshold: 0`, rootMargin `-8%` bottom, plus an immediate on-screen check so first-viewport nodes get `.is-visible` without waiting.
- `src/views/Legal.astro` and `src/views/Security.astro`: `data-reveal` on each `section`, not on the wrapping `.doc-body`.
- `src/styles/global.css`: `@media (scripting: none)` so copy stays visible if JS does not run.
- Site version: **1.3.23 → 1.3.24**.

No copy rewrite, no new tokens, no `transition-all` / `scale-105`.

## Testing instructions

Tester: treat this as a **mobile visibility** bug, not a class-list check.

1. **Phone / narrow viewport (decisive):** Open `/en/legal/` at **~375×812** (iPhone-class). Confirm within ~1s:
   - H1 "Legal notice and privacy" is visible.
   - TOC links (Legal notice, Privacy policy, Cookies, KM0 Cloud, KM0 Email) are visible.
   - Section **Legal notice** body is visible without scrolling (AMVARA CONSULTING S.L., NIF, Barcelona address, `legal@amvara.de`). Content is **not** a blank Paper canvas under the masthead.
2. Scroll through **Privacy**, **Cookies**, **KM0 Cloud**, **KM0 Email**. Each section title and body must become readable as it enters the viewport (not stay invisible).
3. Tap TOC **Legal notice** (`#notice`) and **Privacy** (`#privacy`). After jump, the target heading and following paragraphs must be visible (not opacity 0 behind the masthead).
4. Repeat at **~375px** on `/legal/` (es), `/ca/legal/`, `/de/legal/`. Same: first section body visible.
5. Repeat `/en/security/` at **~375px**. Security sections must not stay blank (same reveal wrapper bug).
6. **Desktop (~1280px)** `/en/legal/`: content still visible; masthead compact on scroll still works on home if you spot-check `/en/`.
7. **Reduced motion:** emulate `prefers-reduced-motion: reduce` on `/en/legal/` at 375px; all legal sections visible immediately.
8. **HTTP (not sufficient alone):**
   - `curl -sI http://127.0.0.1:9180/en/legal/` → 200
   - `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` → 200
   - HTML contains `<div class="doc-body">` **without** `data-reveal` on that wrapper, and `<section id="notice" ... data-reveal>`
   - Footer **Version 1.3.24**
9. **Fail if:** first viewport of `/en/legal/` at 375px shows heading/TOC but empty body, or a section never appears after it is on screen.
10. **User-Agent note:** Issue mentioned iPhone Safari/Brave. If a real iOS device is available, confirm `/en/legal/` there; otherwise DevTools iPhone viewport is the gate.

Coder evidence: `docker compose build && up -d`; curl 200 on `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/legal/`, `/legal/`, `/en/security/`; HTML has per-section `data-reveal` and AMVARA body copy; nginx started cleanly; no browser MCP in this session (no live paint pass).

## Test report

1. **Date/time (UTC) and log window:** start 2026-10-06 13:58:52 UTC, end 2026-10-06 14:04:12 UTC. Docker log window `2026-10-06T13:58:00Z` through `14:04Z`.
2. **Environment:** branch `main` (synced with `origin/main`). Build: `docker compose build && docker compose up -d` (image `km0-km0-web`, container `km0-web`, `127.0.0.1:9180`). Paint: Playwright Chromium 375x812 iPhone UA and 1280x800 (no Cursor browser MCP; no physical iOS device). Production is this same host: `https://km0digital.com/en/legal/` returned HTTP/2 200 without a wait loop.
3. **What was tested:** mobile legal/security visibility (opacity/reveal), TOC jumps, four locales, desktop legal + home masthead compact, reduced motion, HTTP/HTML/footer, hallmark skim on the ship diff. Not a Stirling/Satisfecho hard-parity FEAT.
4. **Results:**
   - **1 Phone 375x812 `/en/legal/`:** PASS. Within 1s H1 "Legal notice and privacy" opacity 1; TOC lists Legal notice, Privacy policy, Cookies, KM0 Cloud, KM0 Email at opacity 1. First viewport is heading + TOC, not a blank canvas (TOC bottom ~11px from viewport). `#notice` starts at ~909px so AMVARA/NIF/Barcelona/`legal@amvara.de` sit below the TOC; after scroll/TOC jump they are readable (screenshot `en-legal-375-toc-notice-fresh.png` / `en-legal-375-notice.png`). Fail gate 9 is heading/TOC with empty body: not observed.
   - **2 Scroll Privacy / Cookies / Cloud / Mail:** PASS. Each section reached `is-visible` and opacity ~1 with real body copy (privacy contact `legal@amvara.de`, cookies, KM0 Cloud, KM0 Email).
   - **3 TOC `#notice` and `#privacy`:** PASS. Fresh-load clicks: Legal notice heading top ~178px, AMVARA + Barcelona visible, section opacity ~1. Privacy heading top ~277px, Data controller / `legal@amvara.de` readable in screenshot (not stuck opacity 0 behind the masthead). Mid-transition section opacity at 600ms is the 820ms reveal, not the old tall-wrapper bug.
   - **4 Locales 375px:** PASS. `/legal/` (es), `/ca/legal/`, `/de/legal/`: `#notice` opacity ~1 with AMVARA / Barcelona body (ES screenshot readable).
   - **5 `/en/security/` 375px:** PASS. `.doc-body` has no `data-reveal`; `#practices` body visible (AMVARA, Encryption, Mail). `#iso27001` and `#disclosure` readable after scroll.
   - **6 Desktop 1280px:** PASS. After bringing `#notice` into view, AMVARA/NIF/Barcelona/`legal@amvara.de` opacity 1. Home `/en/`: masthead not compact at top; after `scrollY=400`, `masthead--compact` and `data-masthead=compact`.
   - **7 Reduced motion:** PASS. All five legal sections opacity 1 and `is-visible` immediately; notice body includes AMVARA.
   - **8 HTTP / HTML / footer:** PASS. Loopback 200 on `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/legal/`, `/legal/`, `/en/security/`. Markup: `<div class="doc-body">` without `data-reveal`; `<section id="notice" class="doc-block scroll-mt-28" data-reveal>`. Built CSS includes `@media (scripting: none)`. Footer/semver served is **1.3.25** (matches `package.json` and production). Task text said 1.3.24; that note is stale, not a visibility fail.
   - **9 Fail gate:** PASS. First viewport is not empty body; on-screen sections become readable.
   - **10 iOS device:** N/A (none available). Gate used Playwright iPhone 375x812 + iPhone Safari UA. Logs show those GETs as 200.
   - **Hallmark skim:** PASS. Pre-emit P4 H5 E5 S4 R5 V4 in implementation summary. Ship diff has no new italic display headers, fake chrome, metric strips, `transition-all`, or `scale-105`.
5. **Overall: PASS**
6. **URLs:** `http://127.0.0.1:9180/en/legal/`, `/legal/`, `/ca/legal/`, `/de/legal/`, `/en/security/`, `/en/`; `https://km0digital.com/` and `https://km0digital.com/en/legal/` (200, same structure, Version 1.3.25). Ready because HEAD/GET 200 on this host (no deploy wait).
7. **Log excerpts:** nginx start `2026/10/06 13:59:15 [notice] ... nginx/1.31.6`; `GET /en/legal/ HTTP/1.1" 200` (iPhone UA 14:01:07 and 14:02:52); `GET /legal/`, `/ca/legal/`, `/de/legal/`, `/en/security/` 200; health `GET /` 200 wget; no nginx errors in the window.
