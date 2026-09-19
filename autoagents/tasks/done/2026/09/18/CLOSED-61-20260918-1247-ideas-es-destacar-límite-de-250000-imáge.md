---
## Closing summary (TOP)

- **What happened:** Issue #61 asked the site to highlight a 250,000-image allowance and a professional file move; the public 150 GB plan was restated as about 75,000 photos, with the move quoted in writing.
- **What was done:** A shared capacity note (es/ca/en/de) sits under the landing Cloud row and the pricing masthead, and the storage FAQ matches it. Site version is 1.3.20. The note is a Signal left-edge block, not a new hero or icon tiles.
- **What was tested:** Tester PASS on loopback: HTTP 200, 75,000-photo copy and quoted move in four locales, 250,000 absent, FAQ agreement, footer 1.3.20, em dash and mailto checks, and a rendered note with no italic heading or icon row. Craft hard gate does not apply (copy note, not Stirling/Satisfecho parity).
- **Why closed:** All stated criteria passed. Anti-slop skim of the new note found no Inter-only type, purple or indigo gradients, centered SaaS hero, or icon-tile grid.
- **Closed at (UTC):** 2026-09-18 12:58
---

# [ideas/es] Destacar límite de 250.000 imágenes y migración profesional

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/61
- **Number:** #61
- **Labels:** agent:wip → agent:untested → agent:testing → CLOSED (pass)
- **Created:** 2026-07-05T15:02:18Z

## Problem / goal
## Summary  The submitter suggests improving site messaging to highlight that users can upload up to 250,000 images. They also want to communicate that, when needed, the team can help customers move all their files in a professional way. This is a ma...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/61
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- Human note on #61: the 250,000-photo line belonged to the old 500 GB plan. Same assumption (about 2 MB per photo: 500 GB / 250,000 = 2 MB) scales the public 150 GB plan to about 75,000 photos. It is a size you can picture, not a file-count cap.
- Shared `services.capacityNote` (es/ca/en/de) on the landing Cloud row (`Services.astro`) and under the pricing masthead (`Pricing.astro`). Left-edge Signal note, existing type and tokens. No new section, no icon tiles.
- FAQ `storage-150gb` now states the same 75,000-photo reference and that extra capacity and the file move are quoted. The €1.99 plan does not include a free full-library move.
- Site version bumped `1.3.19` → `1.3.20` via `./scripts/bump-patch-version.sh`.
- Pre-flight: quiet capacity translation for a normal reader; editorial left-edge note (not a centered hero); existing display + sans; Signal edge on Ink; refuse a 250k KPI, icon tiles, italic headers.
- Pre-emit: P4 H4 E4 S5 R4 V4. Craft hard gate N/A (copy note, not Stirling/Satisfecho parity).

## Testing instructions

1. **HTTP smoke**
   ```bash
   curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/de/ http://127.0.0.1:9180/doc/
   ```
   Expect `200` on each. Also `200` on `/pricing/`, `/ca/pricing/`, `/en/pricing/`, `/de/pricing/`.

2. **75,000-photo reference, not 250,000, on home and pricing**
   ```bash
   curl -s http://127.0.0.1:9180/ | grep -F '75.000 fotos'
   curl -s http://127.0.0.1:9180/pricing/ | grep -F 'El traslado se presupuesta por escrito.'
   curl -s http://127.0.0.1:9180/en/ | grep -F '75,000 photos'
   curl -s http://127.0.0.1:9180/en/pricing/ | grep -F 'quoted in writing'
   curl -s http://127.0.0.1:9180/ca/pricing/ | grep -F 'trasllat es pressuposta'
   curl -s http://127.0.0.1:9180/de/pricing/ | grep -F 'schriftlich kalkuliert'
   ```
   Each must match. Home and `/pricing/` must **not** contain `250.000` or `250,000`.

3. **FAQ agrees**
   ```bash
   curl -s http://127.0.0.1:9180/ | grep -F '75.000 fotos'
   curl -s http://127.0.0.1:9180/en/ | grep -F '75,000 photos'
   ```
   The storage FAQ answer includes the photo count and that the move is quoted.

4. **Footer version**
   ```bash
   curl -s http://127.0.0.1:9180/en/ | grep -oE 'Version [0-9.]+'
   ```
   Expect `Version 1.3.20` (or a later patch if another task bumped after this one).

5. **Em dash / mailto**
   ```bash
   ./scripts/check-no-em-dash.sh
   ./scripts/check-no-mailto.sh
   ```

6. **Visual (copy block, not a new hero)**
   Open `http://127.0.0.1:9180/#km0-cloud` and `http://127.0.0.1:9180/pricing/` at about 1280 px and 390 px. The note sits under the Cloud description and under the pricing masthead: Signal left edge, two short paragraphs, no icon row, no italic heading. Confirm the same block exists on `/en/pricing/`.

Coder evidence (2026-09-18): `docker compose build && docker compose up -d` PASS (prebuild em-dash and mailto OK). HTTP 200 on `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, and four pricing paths. String checks HIT for 75k + quoted move in es/ca/en/de. `250.000` absent on `/` and `/pricing/`. Footer `Versión 1.3.20` / `Version 1.3.20` / `Versió 1.3.20`. `docker logs --since 5m km0-web`: 0 `5xx`. Host `npm` is not installed; build ran inside the image. No browser tool in this session; visual check is listed for the tester.

## Test report

1. **Date/time (UTC) and log window:** Start 2026-09-18T12:53:58Z (UNTESTED → TESTING + `agent:testing` on #61). Checks 12:55:30Z–12:55:58Z. Report close 2026-09-18T12:56:18Z. Docker log window 12:53:58Z–12:55:30Z. Container already healthy (started 2026-09-18T12:52:12Z); no rebuild this session because loopback already served the new copy.

2. **Environment:** Branch `main` at `40d4c4d` (ahead of `origin/main` by 4; feature still in the working tree). Build method: existing `docker compose` image `km0-km0-web` (host `npm` not installed). Loopback `http://127.0.0.1:9180/`. Production polled once: `https://km0digital.com/` returned `200` in 0.125s (ready on first poll). The 75,000-photo copy was verified on loopback only; this change is not committed, so production copy was not asserted.

3. **What was tested:** HTTP smoke on home, four locales, `/doc/`, four pricing paths, and `/en/doc/day-0/`. 75,000-photo reference and quoted file move on home and pricing (es/ca/en/de). Absence of `250.000` / `250,000`. FAQ storage answer agrees. Footer `1.3.20`. Em dash and mailto scripts. Rendered capacity note (DOM + shipped CSS): Signal left edge, two short paragraphs, no icon row, no italic heading. Hallmark skim of the new note CSS. Craft hard gate N/A (copy note, not Stirling/Satisfecho parity).

4. **Results:**
   - **HTTP smoke:** **PASS** - `200` on `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/ca/pricing/`, `/en/pricing/`, `/de/pricing/`, `/en/doc/day-0/`.
   - **75,000-photo reference, not 250,000:** **PASS** - HIT `75.000 fotos` on `/`; `El traslado se presupuesta por escrito.` on `/pricing/`; `75,000 photos` on `/en/`; `quoted in writing` on `/en/pricing/`; `trasllat es pressuposta` on `/ca/pricing/`; `schriftlich kalkuliert` on `/de/pricing/`. `250.000` and `250,000` absent on `/`, `/pricing/`, and the ca/en/de home and pricing paths.
   - **FAQ agrees:** **PASS** - `/` contains `75.000 fotos` and `presupuestamos el traslado`. `/en/` contains `75,000 photos` and `quote extra capacity and the file move`. `/ca/` HIT `pressupostem el trasllat`. `/de/` HIT `kalkulieren wir mehr Speicher`.
   - **Footer version:** **PASS** - `Version 1.3.20` (`/en/`, `/de/`), `Versión 1.3.20` (`/`), `Versió 1.3.20` (`/ca/`).
   - **Em dash / mailto:** **PASS** - `check-no-em-dash: OK`; `check-no-mailto: OK`.
   - **Visual (copy block):** **PASS** - Rendered `<aside class="offer-row__capacity">` sits inside `#km0-cloud` after the description and before the actions: label `<p>`, two line `<p>`s, no `<h*>`, no `<svg>`/`<img>`, no `<i>`/`<em>`. Same shape on `/pricing/` and `/en/pricing/` (`pricing-capacity-note`). Shipped CSS `Landing.nD6ZhxCM.css` and `Pricing.Dd3hzi-o.css`: `border-left:2px solid var(--color-signal)`, sans uppercase label, no `font-style:italic`, no `transition-all`. No breakpoint hides the note, so the block is in the document at both ~1280 px and ~390 px. No graphical browser on this host, so pixel screenshots were not captured.
   - **Hallmark / anti-slop skim:** **PASS** - Implementation summary has pre-emit scores (P4 H4 E4 S5 R4 V4). New note is not an italic display header, fake device chrome, or a 250k KPI strip. New CSS has no `transition-all` or `scale-105`.
   - **Craft hard gate:** **N/A** - task states copy note, not Stirling/Satisfecho parity.
   - **GitHub label:** **PASS** - `agent:testing` on #61 at start; removed on PASS → CLOSED.
   - **Docker 5xx:** **PASS** - 0 responses matching ` 5xx ` in the log window.

5. **Overall:** **PASS**

6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/ca/pricing/`, `/en/pricing/`, `/de/pricing/`, `/en/doc/day-0/`. Production: `https://km0digital.com/` (status only).

7. **Relevant log excerpts:**
   ```text
   172.21.0.1 - - [18/Sep/2026:12:55:30 +0000] "HEAD / HTTP/1.1" 200 0 "-" "curl/8.14.1" "-"
   172.21.0.1 - - [18/Sep/2026:12:55:30 +0000] "HEAD /en/pricing/ HTTP/1.1" 200 0 "-" "curl/8.14.1" "-"
   172.21.0.1 - - [18/Sep/2026:12:55:30 +0000] "GET / HTTP/1.1" 200 62293 "-" "curl/8.14.1" "-"
   172.21.0.1 - - [18/Sep/2026:12:55:30 +0000] "GET /de/pricing/ HTTP/1.1" 200 41512 "-" "curl/8.14.1" "-"
   ```
   5xx count in window: 0.

8. **GitHub:** label `agent:testing` on #61 at start; removed on PASS → CLOSED.
