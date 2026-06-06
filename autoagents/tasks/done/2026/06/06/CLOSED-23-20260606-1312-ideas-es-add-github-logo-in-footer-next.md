---
## Closing summary (TOP)

- **What happened:** Issue #23 asked for a GitHub Octocat icon beside the footer GitHub link on all locales.
- **What was done:** Coder added an inline SVG mark inside the footer GitHub link in `Footer.astro` (`inline-flex`, `currentColor`, `aria-hidden`) and bumped site version to 1.1.40.
- **What was tested:** Docker build (68 pages), HTTP 200 on all locale roots, footer icon/link/hover/a11y/version on loopback and production; overall **PASS**.
- **Why closed:** All acceptance and test criteria passed.
- **Closed at (UTC):** 2026-06-06 13:15
---

# [ideas/es] Add GitHub logo in footer next to GitHub link

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/23
- **Number:** #23
- **Labels:** none
- **Created:** 2026-06-06T10:54:50Z

## Problem / goal
## Summary  The submitter asks to add a GitHub logo in the site footer, placed next to the existing "GitHub" text or link. This is a small visual enhancement to make the GitHub reference easier to recognize. The change would likely involve the footer...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/23
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- Added inline GitHub mark SVG inside the footer GitHub link in `src/components/Footer.astro`.
- Link uses `inline-flex items-center gap-1.5`; icon is `h-4 w-4`, `fill="currentColor"`, `aria-hidden="true"`.
- Site version bumped: 1.1.39 → 1.1.40.

## Testing instructions
1. **Build:** `docker compose build && docker compose up -d` (or `npm run build` if Node is available).
2. **HTTP smoke:** All locale roots return 200:
   - `curl -sI http://127.0.0.1:9180/`
   - `curl -sI http://127.0.0.1:9180/ca/`
   - `curl -sI http://127.0.0.1:9180/en/`
   - `curl -sI http://127.0.0.1:9180/de/`
   - `curl -sI http://127.0.0.1:9180/doc/`
3. **Footer GitHub icon (all locales):** Open `/`, `/ca/`, `/en/`, `/de/` (and optionally `/doc/`). In the footer right column, confirm the GitHub link shows the Octocat icon immediately before the "GitHub" label, aligned on one line.
4. **Link behavior:** Click the footer GitHub link; it opens `https://github.com/AMVARA-CONSULTING/km0-web` in a new tab.
5. **Hover:** Icon and text share the same hover color (`hover:text-navy`).
6. **Version:** Footer shows `1.1.40` (or current patch from `package.json`).
7. **Accessibility:** Icon has `aria-hidden="true"`; link text remains "GitHub" for screen readers.
8. **Logs:** `docker logs --since 10m km0-web` shows no errors after deploy.

## Test report

1. **Date/time (UTC):** 2026-06-06T13:14:48Z – 2026-06-06T13:15:13Z. Log window: nginx access logs from 13:14:59Z through 13:15:10Z.
2. **Environment:** branch `main` @ `311ad83` (uncommitted local changes for issue #23); build via `docker compose build && docker compose up -d` (`km0-web@1.1.40`, 68 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Docker build/deploy, footer GitHub link with Octocat SVG on all locale home pages (ES `/`, CA `/ca/`, EN `/en/`, DE `/de/`, `/doc/`), link href/target/rel, shared hover styling, accessibility attributes, footer version label, standard smoke paths, production poll for footer icon and version.
4. **Results:**
   - Docker build/up (68 pages, em-dash check OK): **PASS** (`[build] 68 page(s) built in 2.78s`; both containers Up)
   - HTTP 200 on `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`: **PASS** (all `HTTP/1.1 200 OK`)
   - Footer GitHub icon before label (ES `/`): **PASS** (`inline-flex` link with SVG Octocat path + `GitHub` text)
   - Footer GitHub icon (CA `/ca/`, EN `/en/`, DE `/de/`, `/doc/`): **PASS** (same SVG + label on each locale)
   - Link href `https://github.com/AMVARA-CONSULTING/km0-web` with `target="_blank"` `rel="noopener noreferrer"`: **PASS** (verified in HTML on `/`)
   - Shared hover `hover:text-navy` on link (icon uses `fill="currentColor"`): **PASS**
   - Footer version **1.1.40** all locales: **PASS** (ES `Versión 1.1.40`, CA `Versió 1.1.40`, EN/DE `Version 1.1.40`)
   - Accessibility: SVG `aria-hidden="true"`, link text `GitHub`: **PASS**
   - Docker logs: no errors after deploy: **PASS** (nginx startup notices + 200 responses only)
   - Production readiness: **PASS** (`https://km0digital.com/` returned HTTP 200 on first poll; footer shows Octocat SVG + `GitHub` and `Versión 1.1.40`)
   - GitHub label `agent:testing` on issue #23: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`; `https://km0digital.com/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.40 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   13:14:57 [build] 68 page(s) built in 2.78s
   172.21.0.1 - - [06/Jun/2026:13:15:06 +0000] "HEAD / HTTP/1.1" 200 0
   172.21.0.1 - - [06/Jun/2026:13:15:06 +0000] "HEAD /ca/ HTTP/1.1" 200 0
   172.21.0.1 - - [06/Jun/2026:13:15:06 +0000] "GET / HTTP/1.1" 200 44480
   172.21.0.1 - - [06/Jun/2026:13:15:06 +0000] "GET /en/ HTTP/1.1" 200 44113
   ```
8. **GitHub:** label `agent:testing` applied on issue #23 at test start.
