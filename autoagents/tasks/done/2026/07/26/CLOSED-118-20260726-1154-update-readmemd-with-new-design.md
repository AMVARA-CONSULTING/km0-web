---
## Closing summary (TOP)

- **What happened:** Issue #118 asked to update root README.md so contributor docs match the shipped civic-dark remodel.
- **What was done:** README locales (incl. German), About, design-system table, visual locks, and footer version wording were updated; no `src/` or package bump (docs-only).
- **What was tested:** Tester PASS on instructions 1–9 (diff scope, locales, design links on disk, visual locks, version wording, em dash, HTTP 200 smoke, bump N/A). Craft Hard gate N/A (not a UI craft FEAT).
- **Why closed:** All testing criteria passed; anti-slop archive check N/A for README-only docs (no page surface regress).
- **Closed at (UTC):** 2026-07-26 11:58
---

# Update README.md with new design

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/118
- **Number:** #118
- **Labels:** agent:wip
- **Created:** 2026-07-26T11:48:36Z

## Problem / goal
The README.md file in  https://github.com/AMVARA-CONSULTING/km0-web/ should be updated according to the design changes.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/118
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary

Updated root **`README.md`** so contributor docs match the shipped civic-dark remodel (not the older light/incomplete locale picture).

### Changes
- **Locales:** Document German (`/de/`, `de.json`, `src/content/doc/de/`) alongside es/ca/en.
- **About:** State dark-only cool civic editorial (Ink / Paper / Signal, IBM Plex Sans + Source Serif 4) with links to `docs/brand-tokens.md` and anti-slop doctrine.
- **Design system section:** Table of doctrine, remodel epic, Stirling paint, craft parity Hard gate, Hallmark, IA map, and agent skills; short visual locks summary (no zebra, Origin motif, live product proof, motion cap).
- **Version:** Footer source of truth is `package.json` via `src/lib/site-version.ts` + bump script; `VERSION` noted for release tags.
- **Layout / editing tables:** `docs/design/`, `tokens.css`, paint/craft paths; four i18n files everywhere.
- **Links:** `docs/agent-loop.md` from Server deployment.

### Out of scope
- No `src/`, `public/`, nginx, or Astro product changes.
- **Site version bump: N/A** (`site-version-bump.mdc` skip for root `README.md` only).

### Pre-emit (docs only)
N/A for P/H/E/S/R/V UI scores (README, not a page surface).

## Testing instructions

1. **Diff scope** - Confirm only `README.md` and this task file changed; no `src/`, `package.json`, or Docker image churn required.
2. **Locale accuracy** - README Production line and Locales table include Spanish `/`, Catalan `/ca/`, English `/en/`, German `/de/`, and blog `/doc/` (plus locale blog paths).
3. **i18n paths** - README cites `src/i18n/{es,ca,en,de}.json` and `src/content/doc/{es,ca,en,de}/`.
4. **Design system table** - Every linked path exists on disk:
   - `docs/brand-tokens.md`
   - `docs/design/anti-slop-doctrine.md`
   - `docs/design/remodel-epic.md`
   - `docs/design/stirling-paint-phase.md`
   - `docs/design/craft-parity-phase.md`
   - `docs/design/hallmark-adaptations.md`
   - `docs/design/ia-map.md`
   - `.cursor/skills/km0-anti-slop-design/SKILL.md`
   - `.cursor/skills/km0-web-copy/SKILL.md`
5. **Visual locks** - README states dark-only Paper canvas, opt-in surfaces (no zebra), Origin / `.km0-motif`, first-viewport live proof, and capped motion vocabulary.
6. **Version wording** - README says footer semver comes from `package.json` (not `VERSION` alone).
7. **Em dash** - `./scripts/check-no-em-dash.sh` (or `grep $'\xe2\x80\x94' README.md`) returns no matches in README.
8. **HTTP smoke (regression only)** - `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` all return 200 (site unchanged by this task).
9. **package.json bump N/A** - Confirm `package.json` `version` unchanged for this task.

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-26 11:57:20 UTC; end 2026-07-26 11:57:45 UTC. Docker access log window ~11:57:29Z (HEAD checks) through 11:57:34Z.
2. **Environment:** Branch `main` (local uncommitted `README.md` + this task). No rebuild required (docs-only). Container `km0-web` healthy Up 15h on `http://127.0.0.1:9180/`. Production `https://km0digital.com/` HEAD **200** on first poll (ready via immediate 200). Craft Hard gate: **N/A** (README docs, not UI craft FEAT).
3. **What was tested:** Testing instructions 1–9 (diff scope, locales, i18n paths, design doc links on disk, visual locks copy, version wording, em dash, HTTP regression smoke, package.json bump N/A).
4. **Results:**
   - Diff scope: **PASS** - ship for #118 is `README.md` + this task file only. No `src/`, `package.json`, `nginx/`, or `astro.config.mjs` in diff. Unrelated dirty tree: `autoagents/001-gh-reviewer/time-of-last-review.txt`, `.cursor/debug-cc03be.log` (not part of this task).
   - Locale accuracy: **PASS** - Production line lists `/`, `/ca/`, `/en/`, `/de/`, `/doc/`; Locales table has German `/de/`; blog paths include `/de/doc/`.
   - i18n paths: **PASS** - README cites `src/i18n/{es,ca,en,de}.json` and `src/content/doc/{es,ca,en,de}/`; all four JSON files and four doc dirs exist on disk.
   - Design system table: **PASS** - all nine linked paths exist (`docs/brand-tokens.md`, anti-slop, remodel-epic, stirling-paint, craft-parity, hallmark, ia-map, both agent skills). Also `src/styles/tokens.css` present.
   - Visual locks: **PASS** - README states dark-only Paper canvas; opt-in `.surface-snow` / `.surface-ink` / `.surface-band` (no `nth-child` zebra); Origin + `.km0-motif`; first-viewport live product proof; motion capped to reveals, masthead compact, Offer sticky pin, hero capacity meter.
   - Version wording: **PASS** - "Footer semver comes from **package.json** `version` (via `src/lib/site-version.ts`)"; `VERSION` only for release tags.
   - Em dash: **PASS** - `./scripts/check-no-em-dash.sh` OK; `grep` U+2014 on README empty.
   - HTTP smoke: **PASS** - loopback HEAD `/` `/ca/` `/en/` `/de/` `/doc/` all **200**. Production `/` **200**.
   - package.json bump N/A: **PASS** - `git diff origin/main -- package.json` empty; version remains **1.2.12**.
   - Docker logs: **PASS** - tested paths **200**; no 5xx in test window (prior unrelated 404s for legacy font/favicon.ico outside this task).
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/`; `https://km0digital.com/` (ready check).
7. **Log excerpts:**
   ```
   172.21.0.1 - - [26/Jul/2026:11:57:29 +0000] "HEAD / HTTP/1.1" 200
   172.21.0.1 - - [26/Jul/2026:11:57:29 +0000] "HEAD /ca/ … /en/ … /de/ … /doc/" 200
   ```
8. **GitHub:** label `agent:testing` on #118 at start; removed on PASS → CLOSED.
