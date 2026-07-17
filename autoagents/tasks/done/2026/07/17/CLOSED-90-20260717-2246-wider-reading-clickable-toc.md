---
## Closing summary (TOP)

- **What happened:** Reading surfaces were too narrow and TOC links did not look clickable.
- **What was done:** Widened reading measure to 75ch and restyled TOC (desktop + mobile) with Signal color, underline, focus/active states; docs updated; site version bumped.
- **What was tested:** Tester PASS - HTTP 200 on locales/doc/tutorials, 75ch measure and TOC chrome in built CSS, aria-current scroll behavior, anti-slop/em-dash/mailto OK, footer ≥ 1.1.118.
- **Why closed:** All acceptance criteria passed.
- **Closed at (UTC):** 2026-07-17 23:09
---

# FEAT-Task: Wider reading measure + obvious clickable TOC

## GitHub Issue
- **Number:** #90
- **Title:** Reading surfaces: wider measure + obvious clickable TOC
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/90
- **Labels:** agent:untested

## Problem / goal
Reading column on blog/tutorials is too narrow (`max-w-[65ch]` today). TOC (“índice de apartados”) does not look clickable. Widen measure using longform/docs research; make TOC affordance unmistakable (NN/G: color + underline / clear link treatment).

## What was done
- `src/styles/reading.css`: article + prose measure **`max-w-[75ch]`** (was 65ch); shell `max-w-7xl`; TOC grid middle track `48rem`.
- TOC: `.reading-toc-link` and mobile summary use Signal + underline; hover / `:focus-visible` / `aria-current`; larger mobile touch targets.
- Docs: measure notes in `blog-tutorials-aesthetics.md` + `blog-tutorials-ground-up-v2.md`.
- Cleared blocking em dashes in unrelated FEAT/runtime files so `npm run build` precheck passes.
- Version **1.1.118**. Deployed via `docker compose build && up -d`.

## Acceptance
- Visibly wider reading column on desktop vs current 65ch
- Stranger test: TOC items look clickable
- Active/focus OK; build green

## Testing instructions
1. `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` → expect **200**.
2. Open `/doc/day-0/` and `/en/doc/day-0/` at desktop ≥1024px:
   - Inspect `.reading-column` / `.reading-prose` → computed `max-width: 75ch` (CSS: `index.*.css`).
   - TOC rail links (`.reading-toc-link`) use Signal teal + underline (not muted gray plain text).
   - Click a TOC entry; heading is not hidden under sticky header (`scroll-mt-28`).
   - Scroll: active TOC item gets `aria-current="location"` (ink + medium weight).
3. Narrow viewport: mobile `details.reading-toc-mobile` summary looks like a link (Signal + underline); list entries tappable with comfortable spacing.
4. Open `/tutorials/getting-started-web/` (and `/en/tutorials/…` if present): same measure + TOC chrome (shared `reading.css`).
5. Footer shows **1.1.118** (or later if another bump landed).
6. Anti-slop smoke: no purple gradients, no bordered TOC card slab, no zebra bands inside the article.
7. `./scripts/check-no-em-dash.sh` and `./scripts/check-no-mailto.sh` → OK.

## References
- https://www.nngroup.com/articles/table-of-contents/
- src/styles/reading.css
- docs/design/blog-tutorials-aesthetics.md

## Test report

1. **Date/time (UTC):** start 2026-07-17T23:02:59Z; evidence window ~23:03:11Z–23:03:53Z; end 2026-07-17T23:04:00Z (approx).
2. **Environment:** branch `main`; build via `docker compose build && docker compose up -d` (host has no `npm`); loopback `http://127.0.0.1:9180/`; production polled `https://km0digital.com/`. Site version in footer: **1.1.122** (later than task note 1.1.118).
3. **What was tested:** HTTP 200 on locales + `/doc/` + day-0 + tutorials; built CSS measure/TOC chrome; inline TOC `aria-current` script; em-dash/mailto checks; anti-slop smoke on reading HTML/CSS; footer version.
4. **Results:**
   - HTTP `/` `/ca/` `/en/` `/de/` `/doc/` `/doc/day-0/` `/en/doc/day-0/` → **PASS** (all `HTTP/1.1 200 OK`; container healthy).
   - Wider measure 75ch → **PASS** (built `index.CiUsrUuv.css`: `.reading-column{max-width:75ch}`, `.reading-prose{max-width:75ch}`; 16× `75ch`, shell `max-width:80rem`, grid track `48rem`).
   - TOC clickable (Signal + underline) → **PASS** (`.reading-toc-link`: `color:rgb(15 118 110)`, `text-decoration-line:underline`; hover teal `#0f766e`; focus-visible outline Signal).
   - Sticky header offset → **PASS** (`scroll-margin-top:7rem` = `scroll-mt-28` in built CSS).
   - Active TOC `aria-current="location"` → **PASS** (inline module on `/doc/day-0/` sets `aria-current` to `location`/`false` via IntersectionObserver; CSS `[aria-current=location]{font-weight:500;color:ink}`).
   - Mobile TOC summary → **PASS** (`.reading-toc-mobile-summary`: Signal teal + underline, `min-height:2.75rem`; mobile links `py` 0.625rem / `text-sm`).
   - Tutorials share chrome → **PASS** (`/tutorials/getting-started-web/` and `/en/…` 200; same `reading-column` / `reading-prose` / `reading-toc-link` classes + shared CSS bundle).
   - Footer version ≥ 1.1.118 → **PASS** (`Versión 1.1.122` on loopback `/`).
   - Anti-slop smoke → **PASS** (no purple/indigo/violet in reading CSS; TOC is whisper rail, no bordered card slab on `.reading-toc`).
   - `check-no-em-dash` / `check-no-mailto` → **PASS** (both OK via `node:22-alpine` bind-mount; also green in Docker image `prebuild`).
5. **Overall: PASS**
6. **URLs:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/doc/day-0/`, `/en/doc/day-0/`, `/tutorials/getting-started-web/`, `/en/tutorials/getting-started-web/`; production ready check: `https://km0digital.com/` and `/doc/day-0/` returned **HTTP/2 200** (polled, no sleep-based wait; loopback was the deploy under test).
7. **Logs (km0-web, UTC window):** nginx start `2026/07/17 23:03:22`; sample `HEAD /doc/day-0/ 200`, `GET /doc/day-0/ 200`, `GET /tutorials/getting-started-web/ 200` at 23:03:33–23:03:34. Build: Astro 124 pages, Complete; prebuild em-dash/mailto OK.
