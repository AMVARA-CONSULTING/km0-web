---
## Closing summary (TOP)

- **What happened:** Blog and tutorials felt uninviting; reading system needed civic-editorial measure, type, and space.
- **What was done:** Magazine mastheads and title-led lists on indices; typography-first reading pages with ~65ch prose, whisper TOC, legacy `doc-block` compat; version 1.1.115+.
- **What was tested:** Tester PASS on es/en indices and posts, tutorials, locales, anti-slop (Bricolage/IBM Plex/Source Serif; no purple/Inter/cards/glow/zebra).
- **Why closed:** All criteria passed; anti-slop skim found no archive blockers.
- **Closed at (UTC):** 2026-07-17 21:58
---

# FEAT-Task: Blog + tutorials aesthetics  -  beautiful reading experience

## GitHub Issue
- **Number:** #87
- **Title:** Remodel: blog + tutorials aesthetics  -  beautiful reading experience
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/87
- **Labels:** agent:wip

## Problem / goal
Blog (`/doc/`) and tutorials (`/tutorials/`) still feel ugly and uninviting. Rebuild their shared reading system so any user finds them calm, distinctive, and easy to finish  -  using proven longform practice (measure, type scale, space) and KM0 civic-editorial tokens. Research: `docs/design/blog-tutorials-aesthetics.md`.

## High-level instructions for coder
1. Read `docs/design/blog-tutorials-aesthetics.md`, anti-slop skill, `docs/brand-tokens.md`, `docs/design/blog-post-template.md`.
2. **Index (`DocIndex` / `TutorialIndex`):**
   - Magazine-style masthead (kicker + display title + short intro).
   - Title-led editorial list (Nous energy): generous row spacing, quiet date/reading time, Signal hover  -  **no** card grid/shadows.
   - Optional: first/latest item slightly larger hierarchy.
   - Refine tutorial platform badge (typographic, not pill-slop).
3. **Article (`DocArticleChrome` / posts):**
   - Typography-first: display title, quiet meta, body ~18-21px, leading ~1.65, measure ~65ch.
   - TOC as whisper (sticky desktop, light mobile)  -  kill heavy bordered Snow box if it still reads as a card.
   - Polish `.doc-body` / prose: H2 rhythm (more space above than below), lists, blockquote, tables, `pre/code` as editorial craft.
   - Drop marketing `section-pad` heaviness if it fights reading; keep header clearance.
4. **Legacy content:** CSS compatibility for old `doc-block` kits so day-1…N do not break; do **not** batch-rewrite all posts (day-0 Markdown should look best).
5. Anti-slop audit before done (no purple, Inter-only, icon cards, glow, zebra inside articles).
6. Build / docker per runbook; bump patch; gh #87; `agent:wip` → UNTESTED with testing steps for es+en indices and posts.

## Acceptance
- Blog + tutorials indices and articles feel inviting on phone and desktop
- Research targets met (measure/type/space)
- Four locales render; a11y preserved
- Build green

## What was implemented
- Magazine masthead + lead row (`doc-post-row--lead`) on `DocIndex` / `TutorialIndex`
- Reading pages drop marketing `section-pad`; use dedicated `.doc-reading-page` padding
- Shared prose system in `global.css`: ~65ch, ~18-19px / 1.65 leading, stronger H2 space-above, editorial tables/code/blockquote
- Mobile TOC no longer a bordered Snow card; desktop TOC stays whisper/sticky
- Legacy `doc-block` kits kept compatible; platform badge stays typographic
- Site version bumped to **1.1.115**

## Testing instructions
1. **Deploy check:** footer shows `1.1.115` (or later) on `/`.
2. **Blog index (es):** open `http://127.0.0.1:9180/doc/`
   - Masthead: kicker + large display title + short intro
   - First/latest row uses larger title (`doc-post-row--lead`)
   - Rows are hairline list (no cards/shadows); title hover shows Signal underline
   - Quiet date + reading time in meta column
3. **Blog index (en):** `http://127.0.0.1:9180/en/doc/` same structure, English copy
4. **Blog article (day-0, es + en):** `/doc/day-0/` and `/en/doc/day-0/`
   - Large display title, quiet meta, body ~65ch readable measure
   - TOC: mobile is a light disclosure (no Snow bordered box); desktop sticky whisper sidebar when ≥3 headings
   - H2s have more space above than below; lists/blockquote/code look editorial
5. **Legacy post:** `/doc/day-1/` still renders without broken blocks (compat CSS)
6. **Tutorials index:** `/tutorials/` and `/en/tutorials/`
   - Same magazine list; platform label is uppercase tracking text, not a pill chip
   - First item lead hierarchy
7. **Tutorial article:** e.g. `/tutorials/getting-started-web/` and `/en/tutorials/getting-started-web/`
   - Same chrome/prose system as blog
8. **Locales:** HEAD 200 for `/ca/doc/`, `/de/doc/`, `/ca/tutorials/`, `/de/tutorials/`
9. **Anti-slop spot-check:** no purple gradients, no Inter-only, no card grid, no glow orbs, no zebra bands inside articles
10. **Phone:** narrow viewport on index + day-0; TOC opens without heavy chrome; text remains comfortable
11. **Build evidence (coder):** `docker compose build && docker compose up -d` green; curl HEAD 200 on `/`, `/doc/`, `/en/doc/`, `/doc/day-0/`, `/tutorials/`, `/en/tutorials/`

## References
- docs/design/blog-tutorials-aesthetics.md
- docs/design/blog-post-template.md
- docs/design/anti-slop-doctrine.md
- docs/brand-tokens.md
- https://nousresearch.com/blog (index energy, not pixel clone)
- Runbook: docs/runbook.md

## Test report

1. **Date/time (UTC):** 2026-07-17T21:56:25Z start → 2026-07-17T21:56:44Z end. Log window: 2026-07-17 21:56:38–21:56:44 UTC (`docker logs km0-web`). Prior docker rebuild at 21:55:29–21:55:39 UTC (shared with #86).
2. **Environment:** branch `main`; `docker compose` loopback `http://127.0.0.1:9180/` (image built with package **1.1.116**); production `https://km0digital.com/` for spot-check (HTTP/2 200 on first poll).
3. **What was tested:** Testing instructions 1–11 via HTTP/HTML/CSS evidence (phone via CSS structure: `doc-toc-mobile lg:hidden`, `px-6`, ~65ch measure; no real device browser).
4. **Results:**
   - Footer ≥1.1.115 → **PASS** (`Versión 1.1.116`)
   - Blog index es (`/doc/`): kicker Blog, lead row, hairline list, Signal hover CSS → **PASS**
   - Blog index en (`/en/doc/`): same structure, English kicker → **PASS**
   - day-0 es/en: `doc-reading-page`, `doc-title`, `doc-body` max-w 65ch / 1.125–1.1875rem / leading 1.65; mobile TOC `bg-transparent` details (not Snow card); sticky desktop TOC; no `section-pad` → **PASS**
   - Legacy `/doc/day-1/`: renders with `doc-block` kits (37 hits), 200 → **PASS**
   - Tutorials indices: magazine list, `doc-platform-badge` uppercase tracking (no `rounded-full`), lead row → **PASS**
   - Tutorial articles: same chrome/prose (`doc-reading-page` + `doc-body`) → **PASS**
   - Locale HEAD 200: `/ca|de/doc/`, `/ca|de/tutorials/` → **PASS**
   - Anti-slop: no purple/Inter/glow/zebra in article HTML; fonts Bricolage + IBM Plex + Source Serif 4 → **PASS**
   - Phone/narrow: TOC is light `<details class="doc-toc-mobile">`; CSS confirms no bordered Snow card → **PASS** (structural)
   - Build/HTTP 200 on required paths → **PASS**
5. **Overall:** **PASS**
6. **URLs:** loopback `/`, `/doc/`, `/en/doc/`, `/doc/day-0/`, `/en/doc/day-0/`, `/doc/day-1/`, `/tutorials/`, `/en/tutorials/`, `/tutorials/getting-started-web/`, `/en/tutorials/getting-started-web/`, `/ca|de/doc/`, `/ca|de/tutorials/`; production `/doc/`, `/`
7. **Logs:** access 200s for all tested paths; no nginx errors in window.

