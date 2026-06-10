---
## Closing summary (TOP)

- **What happened:** GitHub issue #27 requested a readability and typography overhaul for text-heavy Blog and Tutorial pages.
- **What was done:** Shared `DocArticleChrome` layout, reading-time/TOC utilities, editorial CSS, and updated doc/tutorial views with i18n; site version bumped to 1.1.59.
- **What was tested:** All ten testing-instruction criteria passed (Docker build, HTTP smoke, layout/typography/a11y checks, footer version, production spot-check).
- **Why closed:** Tester report overall PASS; all acceptance criteria met.
- **Closed at (UTC):** 2026-06-10 21:23
---

# # Improve readability and typography for text-heavy subpages

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/27
- **Number:** #27
- **Labels:** none
- **Created:** 2026-06-10T21:16:59Z

## Problem / goal
# Improve readability and typography for text-heavy subpages  ## Context  Text-heavy subpages such as **Blog** and **Tutorials** currently feel visually weak and difficult to read. The content presentation should be redesigned to provide a more polis...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/27
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- Added shared `DocArticleChrome.astro` reading layout for blog posts and tutorials.
- Added `src/lib/reading.ts` (reading time, TOC extraction) and `src/scripts/doc-reading.ts` (anchor ids, active TOC highlight).
- Redesigned `.doc-*` typography and layout in `src/styles/global.css`: left-aligned prose, editorial card shell, TOC sidebar (desktop) / collapsible TOC (mobile), prev/next navigation, related content, index card metadata.
- Updated `DocPost`, `TutorialPost`, `DocIndex`, `TutorialIndex` views and i18n strings (es/ca/en/de).
- Site version bumped to **1.1.59**.

## Testing instructions
1. Build and run: `docker compose build km0-web && docker compose up -d km0-web`
2. HTTP smoke (expect `200 OK`):
   - `curl -sI http://127.0.0.1:9180/doc/`
   - `curl -sI http://127.0.0.1:9180/en/doc/day-0/`
   - `curl -sI http://127.0.0.1:9180/tutorials/`
   - `curl -sI http://127.0.0.1:9180/ca/tutorials/getting-started-web/`
3. Blog index (`/doc/`, `/en/doc/`): white card container, date + reading time on each post card, hover states, left-aligned intro (not full-width justified).
4. Blog post (`/doc/day-0/`, `/en/doc/day-0/`): surface page background, white article card, date + reading time in header, sticky TOC on desktop (3+ sections), collapsible TOC on mobile, prev/next links, related posts block, back link.
5. Tutorials index (`/tutorials/`, `/de/tutorials/`): platform badge + reading time on cards.
6. Tutorial post (`/tutorials/getting-started-web/`, `/en/tutorials/getting-started-web/`): same reading chrome as blog; prev/next follows tutorial order; related tutorials shown.
7. Typography: comfortable line height, no justified body text, readable link underlines, code/pre/blockquote/table styles render cleanly inside content blocks.
8. Accessibility: semantic `article`, breadcrumb `nav`, TOC `nav` with list, heading order preserved, TOC links receive `aria-current="location"` while scrolling (requires JS enabled).
9. Footer shows version **1.1.59** on home page (all locales optional spot-check).
10. Logs: `docker logs --since 10m km0-web` (no nginx errors).

## Test report

1. **Date/time (UTC):** 2026-06-10T21:21:44Z start, 2026-06-10T21:22:26Z end. Log window: 2026-06-10T21:21:59Z through 2026-06-10T21:22:01Z.
2. **Environment:** branch `main` (local uncommitted changes); build via `docker compose build km0-web && docker compose up -d km0-web` (npm unavailable on host; Docker build km0-web@1.1.59, 80 pages, `check-no-em-dash: OK`). Loopback `http://127.0.0.1:9180/`; production `https://km0digital.com/` (200 on first poll).
3. **What was tested:** All ten testing-instruction criteria plus extended smoke on `/`, `/ca/`, `/en/`, `/de/`, `/en/doc/`, `/en/tutorials/getting-started-web/`.
4. **Results:**
   - Docker build and container up: **PASS** (80 pages, em-dash prebuild OK).
   - HTTP smoke 200 (`/doc/`, `/en/doc/day-0/`, `/tutorials/`, `/ca/tutorials/getting-started-web/`): **PASS**.
   - Blog index (`/doc/`, `/en/doc/`): **PASS** (`doc-index` white card shell, `doc-post-card-meta` with `doc-date` + `doc-reading-time`, `doc-index-intro` max-w-2xl left-aligned, hover classes on cards).
   - Blog post (`/doc/day-0/`, `/en/doc/day-0/`): **PASS** (`doc-reading-page` surface bg, `doc-article-shell`, header meta with reading time, `doc-toc--sticky` + `doc-toc-mobile`, 16 TOC items, `doc-article-nav-link--next`, `doc-related`, `doc-back`).
   - Tutorials index (`/tutorials/`, `/de/tutorials/`): **PASS** (`doc-platform-badge`, `doc-reading-time`, `doc-post-card` on cards).
   - Tutorial post (`/en/tutorials/getting-started-web/`): **PASS** (`doc-article-shell`, `doc-toc`, `doc-article-nav-link`, `doc-related`, `doc-reading-time`).
   - Typography: **PASS** (`.doc-body` uses `leading-[1.8]`/`leading-[1.85]`; no `text-justify` in built CSS; underline styles on links in `global.css`).
   - Accessibility: **PASS** (`<article class="doc-reading">`, breadcrumb `nav`, TOC `nav` with `ol.doc-toc-list`, `h1` then content headings, `data-toc-link` + `doc-reading.ts` IntersectionObserver sets `aria-current`; `aria-current` present in markup).
   - Footer version 1.1.59: **PASS** (`Versión 1.1.59` ES, `Versió 1.1.59` CA, `Version 1.1.59` DE).
   - Docker logs (no nginx errors): **PASS** (only startup notices and 200 HEAD requests).
   - Production verification: **PASS** (`https://km0digital.com/` 200 on attempt 1; `/doc/` and `/doc/day-0/` include `doc-index`, `doc-post-card`, `doc-reading-page`, `doc-article-shell`, `doc-toc--sticky`, version `1.1.59`).
   - GitHub label `agent:testing` on issue #27: **PASS** (applied at test start).
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/`, `/en/doc/day-0/`, `/doc/day-0/`, `/tutorials/`, `/de/tutorials/`, `/ca/tutorials/getting-started-web/`, `/en/tutorials/getting-started-web/`; production `https://km0digital.com/`, `https://km0digital.com/doc/`, `https://km0digital.com/doc/day-0/`.
7. **Log excerpts:**
   ```
   check-no-em-dash: OK (zero U+2014 matches in text files)
   21:21:57 [build] 80 page(s) built in 3.33s
   2026/06/10 21:21:59 [notice] 1#1: start worker processes
   172.21.0.1 - - [10/Jun/2026:21:22:01 +0000] "HEAD /doc/ HTTP/1.1" 200 0 "-" "curl/8.14.1" "-"
   172.21.0.1 - - [10/Jun/2026:21:22:01 +0000] "HEAD /en/doc/day-0/ HTTP/1.1" 200 0 "-" "curl/8.14.1" "-"
   172.21.0.1 - - [10/Jun/2026:21:22:01 +0000] "HEAD /tutorials/ HTTP/1.1" 200 0 "-" "curl/8.14.1" "-"
   172.21.0.1 - - [10/Jun/2026:21:22:01 +0000] "HEAD /ca/tutorials/getting-started-web/ HTTP/1.1" 200 0 "-" "curl/8.14.1" "-"
   ```
