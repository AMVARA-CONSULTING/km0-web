---
## Closing summary (TOP)

- **What happened:** Blog reading chrome was card-heavy and hard to finish; day-0 needed a simpler prose template.
- **What was done:** Rebuilt DocIndex/DocPost/DocArticleChrome with editorial rows and calm TOC; migrated day-0 pilot to Markdown prose; legacy day-* kept via compat CSS.
- **What was tested:** PASS - index doc-post-row, day-0 prose/TOC/measure, day-1 compat, tutorials share chrome, fonts without Inter, all listed routes 200.
- **Why closed:** All acceptance criteria passed; no purple accent bars or Inter-only article face.
- **Closed at (UTC):** 2026-07-17 18:50
---

# FEAT-Task: Blog redesign from zero (reading experience)

## GitHub Issue
- **Number:** #77
- **Title:** (see issue)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/77
- **Labels:** agent:planned
- **Depends / notes:** see body; run remodel epic in order


## Problem / goal

`/doc/` (blog) is hard to read: heavy `doc-block` / `doc-lead-block` chrome, card shells, dense TOC theater, and HTML-as-content that fights longform. Prior readability work improved metrics but not **soul** or ease. Rebuild the **reading system** from zero using editorial best practices while staying off repetitive “AI blog” templates (generic Inter article card grids, purple left borders, etc.).

## High-level instructions for coder

1. Study doctrine + NN/g F-pattern / succinct longform. Optional inspiration: Hallmark editorial examples (structure, not clone).
2. Redesign:
   - `DocArticleChrome.astro` / `DocPost.astro` / `DocIndex.astro`
   - Blog CSS in `global.css` (`.doc-*`) - prefer deleting complexity
   - Index: simple list or asymmetric editorial list - **not** identical SaaS cards with shadows
   - Article: comfortable measure (~60–70ch), clear H1, meta (date, reading time) quiet, TOC only if ≥3 headings and visually calm
3. Content strategy for `src/content/doc/**`:
   - Prefer **Markdown prose** over nested HTML section kits where possible
   - Migrate **only the pilot** `day-0` (all locales that exist) to the new simpler pattern as the **template**
   - **All other `day-*` posts:** compatibility CSS only so they still render cleanly - **do not** rewrite their prose here (that is a later epic). Zero broken pages.
4. Keep i18n routes and slugs stable (`/doc/day-N/`).
5. Tutorials may **share** the new chrome if it fits; if tutorial needs differ, share tokens/type only and note follow-up - do not make tutorials worse.
6. Build + bump. Use GitHub issue #77.

## Acceptance

- Blog index and at least one full post feel calm, distinctive, easy to finish
- No purple accent bars / glow / Inter-only article face
- TOC and meta do not dominate the first screen on mobile
- All locale doc routes 200

## Testing instructions

1. **Version:** Footer shows `1.1.106` on `/` (and locales).
2. **HTTP 200:** `curl -sI http://127.0.0.1:9180/` plus `/ca/`, `/en/`, `/de/`, `/doc/`, `/doc/day-0/`, `/doc/day-1/`, `/en/doc/day-0/`, `/ca/doc/day-0/`, `/de/doc/day-0/`, `/tutorials/`, `/tutorials/getting-started-web/`.
3. **Index (anti-slop):** Open `/doc/` and `/en/doc/`. Expect asymmetric editorial rows (`doc-post-row`), not shadowed SaaS cards. Titles use display face; no purple gradient CTAs.
4. **Pilot post:** Open `/doc/day-0/` and `/en/doc/day-0/`. Body is Markdown prose (`##` headings), measure ~60-70ch, quiet date/reading-time meta. No `doc-lead-block` / nested section kits in the article body.
5. **TOC:** On day-0 (desktop) sticky aside is calm; on mobile TOC is a compact details summary, not a full first-screen wall.
6. **Compat:** Open `/doc/day-1/` (legacy HTML kit). Still readable, no broken layout; kits render without heavy card shells / numbered pill steps theater.
7. **Tutorials share chrome:** `/tutorials/` uses the same editorial list; a tutorial post uses `DocArticleChrome` without regressions.
8. **Logs:** `docker logs --since 10m km0-web` - no nginx/start errors after deploy.
9. **Em dash:** `./scripts/check-no-em-dash.sh` OK (also runs in Docker build).

## References
- `src/views/DocPost.astro`, `src/components/DocArticleChrome.astro`
- https://www.nngroup.com/articles/f-shaped-pattern-reading-web-content-discovered/
- https://www.developersdigest.tech/blog/ai-design-slop-and-how-to-spot-it

## Test report

1. **Date/time (UTC):** 2026-07-17T18:49:57Z – 2026-07-17T18:50:10Z. Log window: container from 18:46:59Z; smoke HEADs at 18:49:57Z+.
2. **Environment:** branch `main` @ `6edfc07`; `km0-web@1.1.106` on `http://127.0.0.1:9180/`.
3. **What was tested:** Footer version, HTTP smoke (home/locales/doc/day-0/day-1/tutorials), index anti-slop rows, day-0 pilot prose/TOC/measure, day-1 compat, tutorials shared chrome, em dash, nginx error scan.
4. **Results:**
   - Footer version **1.1.106**: **PASS**
   - HTTP 200 on `/`, locales, `/doc/`, `/doc/day-0/`, `/doc/day-1/`, locale day-0, `/tutorials/`, `/tutorials/getting-started-web/`: **PASS**
   - Index `/doc/` + `/en/doc/`: `doc-post-row` present; no `shadow-lg` / purple CTAs: **PASS**
   - Pilot `/doc/day-0/` + `/en/doc/day-0/`: Markdown `h2` prose, `doc-meta`, `doc-lead-block` absent, measure ~68ch in CSS: **PASS**
   - TOC: desktop sticky aside (`doc-toc-aside` / `lg:block`); mobile compact `<details class="doc-toc-mobile">`: **PASS**
   - Compat `/doc/day-1/`: 200, readable H1, legacy kits still render: **PASS**
   - Tutorials index uses `doc-post-row`; tutorial post has article chrome + H1: **PASS**
   - Fonts: Bricolage present; no `Inter:wght`: **PASS**
   - Em dash check: **PASS**
   - No nginx error/emerg in recent logs: **PASS**
   - GitHub label `agent:testing` on issue #77: **PASS**
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/` (+ locales), `/doc/`, `/doc/day-0/`, `/doc/day-1/`, `/en/doc/`, `/en/doc/day-0/`, `/ca/doc/day-0/`, `/de/doc/day-0/`, `/tutorials/`, `/tutorials/getting-started-web/`.
7. **Log excerpts:**
   ```
   HEAD smoke: all listed paths 200
   Versión 1.1.106
   check-no-em-dash: OK
   ```
8. **GitHub:** label `agent:testing` applied on issue #77 at test start.
