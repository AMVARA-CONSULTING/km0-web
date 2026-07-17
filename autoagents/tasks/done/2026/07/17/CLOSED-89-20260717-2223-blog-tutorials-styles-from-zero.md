---
## Closing summary (TOP)

- **What happened:** Issue #89 required a from-zero blog/tutorials reading UI after #87 left the hairline-row + bordered-TOC look essentially unchanged.
- **What was done:** Shipped a new `reading-*` system (`reading.css` + rewritten Doc/Tutorial chrome and indexes) with quiet civic book vibe, poster masthead indexes, and whisper TOC; version **1.1.117**.
- **What was tested:** Tester PASS on visual es+en, shared tutorials system, legacy prose compat, anti-slop, a11y, HTTP 200, footer version, em-dash/mailto, nginx logs (loopback + prod smoke).
- **Why closed:** All acceptance criteria and testing instructions passed; anti-slop skim found no Inter-only, purple/indigo, centered SaaS hero, or icon-tile regressions.
- **Closed at (UTC):** 2026-07-17 22:30
---

# FEAT-Task: Blog + tutorials styles FROM ZERO

## GitHub Issue
- **Number:** #89
- **Title:** Blog + tutorials styles FROM ZERO - discard current look
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/89
- **Labels:** agent:wip

## Problem / goal
#87 closed but product owner says blog/tutorials remain essentially unchanged. **Do not polish.** Delete/replace the reading UI and CSS from zero so the result is totally distinct from the current hairline-row + bordered-TOC look. Spec: `docs/design/blog-tutorials-ground-up-v2.md`.

## High-level instructions for coder
1. Read `docs/design/blog-tutorials-ground-up-v2.md` + `docs/design/blog-tutorials-aesthetics.md` + anti-slop + brand tokens.
2. **Greenfield CSS:** add `src/styles/reading.css` (name flexible) imported from the layout/global entry. Move reading styles out of the monolithic `.doc-*` section in `global.css`; remove dead rules after cutover.
3. **Greenfield chrome:** rewrite `DocArticleChrome.astro`, `DocIndex.astro`, `TutorialIndex.astro`, `DocPost.astro`, `TutorialPost.astro` with a new class prefix (prefer `reading-*`). New index pattern and article shell - not a restyle of `.doc-post-row`.
4. **Design commitment (state in Implementation summary before coding):** vibe + layout archetype + type roles for reading surfaces (must differ from current list+box TOC). Examples of allowed directions: asymmetric editorial magazine, typographic poster index, quiet book-like column with floating whisper TOC - pick one and commit.
5. Prose: new `.reading-prose` (or equiv) for Markdown + compatibility layer for legacy `doc-block` kits without resurrecting old card theater as the hero look.
6. Anti-slop audit. No mailto. Prefer #80 zebra rules already killed on home; do not invent zebra inside reading pages.
7. Build; bump; gh #89; UNTESTED with explicit "before/after must look different" tester checklist (es+en).

## Acceptance
- Unmistakably new vs pre-change screenshots/current production
- Shared system for blog + tutorials
- Routes/slugs intact; day-0 looks best
- Build + a11y green

## Design commitment (pre-code)
1. **Vibe:** Quiet civic book - typographic poster indexes, calm longform column on continuous Paper.
2. **Layout archetype:** Magazine masthead with Signal vertical rule + title-led catalog (feature lead oversized; meta trails under titles, not a date|title hairline grid). Article = biased book column with floating whisper TOC on the right (no bordered TOC slab).
3. **Type roles:** Display Bricolage Grotesque / body Source Serif 4 / UI IBM Plex Sans.
4. **Anchor + accent:** Ink on Paper; Signal teal only.
5. **Refuse:** `.doc-post-row` hairline grids, bordered TOC boxes, card grids, purple/indigo, Inter-only, zebra bands inside reading pages.

## Implementation summary
- Added `src/styles/reading.css` (imported from `global.css`); class prefix `reading-*`.
- Rewrote `DocArticleChrome.astro`, `DocIndex.astro`, `TutorialIndex.astro`, `DocPost.astro`, `TutorialPost.astro` onto the new shell.
- Gutted blog/tutorial chrome (`.doc-reading-*`, `.doc-post-row`, `.doc-toc-*`, etc.) from `global.css`. Kept thin shared `.doc-kicker` / `.doc-index-intro` / `.doc-body` for Legal, Security, Pricing, and related pages.
- Legacy `doc-block` kits styled under `.reading-prose` only.
- TOC script targets `[data-reading]` / `[data-reading-toc]`.
- Site version bumped to **1.1.117**.
- `docker compose build && up -d`; HTTP 200 on `/`, locales, `/doc/`, `/doc/day-0/`, `/tutorials/`, EN equivalents. Markup uses `reading-*`; zero `doc-post-row` / `doc-toc-mobile` on reading pages.

## Testing instructions
**Before/after must look different** (fail if pages still read as hairline meta|title rows + left bordered TOC).

### Visual (es + en)
1. Open `http://127.0.0.1:9180/doc/` and `/en/doc/`. Confirm poster masthead with Signal left bar, feature lead as large title-first entry, remaining entries without left meta column grid, short ink ticks between items (not full-width hairline rows).
2. Open `/doc/day-0/` and `/en/doc/day-0/`. Confirm oversized title, quiet uppercase meta, body in `.reading-prose` (~65ch). On desktop width ≥1024px, TOC is a right-side whisper rail (no box border); active link uses Signal. Mobile: disclosure TOC without bordered card chrome.
3. Open `/tutorials/` and `/en/tutorials/` plus one post each (`/tutorials/getting-started-web/`, `/en/tutorials/getting-started-macos/`). Same reading system as blog; platform shown as Signal label, not SaaS chip badge row.
4. Spot-check a legacy kit post (`/doc/day-15/`): sections still readable under new prose compat (no card theater).
5. Anti-slop: no purple gradients, no Inter-only, no zebra section bands, no equal icon-tile cards on these pages.
6. A11y: single H1 on index and article; breadcrumb + TOC nav labels present; focus-visible on entry titles; TOC links keyboard-reachable.

### HTTP / deploy
7. `curl -sI` → 200 for `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/doc/day-0/`, `/tutorials/`, `/en/doc/`, `/en/tutorials/`.
8. Footer shows **1.1.117** (or current bumped patch).
9. `./scripts/check-no-em-dash.sh` and `./scripts/check-no-mailto.sh` OK; no nginx errors in `docker logs --since 10m km0-web`.

## References
- docs/design/blog-tutorials-ground-up-v2.md
- docs/design/blog-tutorials-aesthetics.md
- docs/brand-tokens.md
- Closed insufficient pass: #87

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-17 22:28:22 UTC; end 2026-07-17 22:29:37 UTC. Docker log window ~22:28:44Z-22:29:22Z (`docker logs --since 10m km0-web`).
2. **Environment:** Branch `main` (working tree includes #89 reading remodel; `package.json` 1.1.117). Build via `docker compose build && docker compose up -d` (host has no `npm`). Loopback `http://127.0.0.1:9180/`. Production `https://km0digital.com/` already serving 1.1.117 with `reading-*` markup (confirmed by GET body, not sleep).
3. **What was tested:** Testing instructions 1-9 (visual structure es+en, article TOC, tutorials shared system, day-15 legacy prose, anti-slop, a11y, HTTP, footer version, em-dash/mailto + nginx logs).
4. **Results:**
   - Index poster masthead + feature lead + short ink ticks (es `/doc/`, en `/en/doc/`): **PASS** - `reading-index-masthead` with Signal `::before` 3px bar in `/_astro/index.D6y3E2Fo.css`; first item `reading-entry--feature`; meta under titles; sibling ticks via `.reading-entry+.reading-entry::before` (2.5rem, not full-width hairline). Zero `doc-post-row`.
   - Article day-0 (es+en): **PASS** - `reading-title` / `reading-prose` (`max-width:65ch`, Source Serif 4); desktop TOC `aside.reading-toc-rail` (hidden under 1024px, no box border on `.reading-toc`); active link Signal teal; mobile `details.reading-toc-mobile` disclosure without bordered card chrome.
   - Tutorials index + posts: **PASS** - same `reading-*` shell; platform as `reading-platform` Signal label (web/android/ios/macos), not chip badge row. `/tutorials/getting-started-web/`, `/en/tutorials/getting-started-macos/` both `reading-page` + `reading-prose` + `reading-toc-rail`.
   - Legacy kit `/doc/day-15/`: **PASS** - `reading-prose` present; `doc-block` / `doc-block-title` sections still in body (compat under prose, not card theater hero).
   - Anti-slop: **PASS** - no purple/indigo/violet in reading CSS; fonts Bricolage Grotesque + Source Serif 4 + IBM Plex Sans; no `doc-post-row` / zebra `nth-child` on reading pages; no equal icon-tile reading catalog.
   - A11y: **PASS** - single `<h1>` on indexes and articles checked; breadcrumb `nav.reading-crumb` aria-label Breadcrumb; TOC navs aria-label "En esta página"; `.reading-entry-title a:focus-visible` Signal outline; TOC links are real `<a href="#...">`.
   - HTTP 200: **PASS** - `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/doc/day-0/`, `/tutorials/`, `/en/doc/`, `/en/tutorials/`, `/en/doc/day-0/`, tutorial posts, `/doc/day-15/`. Prod `/`, `/doc/`, `/doc/day-0/` → 200 with `reading-index-masthead` and footer 1.1.117 (ready confirmed by response body + status).
   - Footer version 1.1.117: **PASS** - loopback home "Versión 1.1.117"; prod same.
   - Em dash / mailto / nginx: **PASS** - `./scripts/check-no-em-dash.sh` OK; `./scripts/check-no-mailto.sh` OK; no error/warn/emerg in `docker logs --since 10m km0-web`.
   - GitHub label `agent:testing` on issue #89: **PASS** (applied at test start; removed prior agent labels).
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/` (locales, `/doc/`, `/doc/day-0/`, `/doc/day-15/`, `/tutorials/`, `/tutorials/getting-started-web/`, `/en/doc/`, `/en/doc/day-0/`, `/en/tutorials/`, `/en/tutorials/getting-started-macos/`); `https://km0digital.com/`, `/doc/`, `/doc/day-0/`.
7. **Log excerpts:** nginx start 22:28:44Z; HEAD/GET 200 for all smoke paths 22:28:49Z-22:29:22Z; no nginx error lines in 10m window.
8. **GitHub:** label `agent:testing` applied on issue #89 at test start.

