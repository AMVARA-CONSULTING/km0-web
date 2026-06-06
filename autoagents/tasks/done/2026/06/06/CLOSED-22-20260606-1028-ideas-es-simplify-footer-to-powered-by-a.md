---
## Closing summary (TOP)

- **What happened:** GitHub issue #22 requested shortening the footer credit line to "Powered by AMVARA" only, removing the LdeLuipy developer credit.
- **What was done:** Updated `footer.poweredByHtml` in all four locale i18n files (`es`, `ca`, `en`, `de`); site version bumped to **1.1.39**.
- **What was tested:** Tester report **PASS**: Docker build (68 pages), HTTP 200 on all locale paths, AMVARA-only footer on ES/CA/EN/DE, no LdeLuipy text or link, version 1.1.39 in footer, production poll OK.
- **Why closed:** All testing criteria passed; implementation matches issue scope.
- **Closed at (UTC):** 2026-06-06 10:31
---

# [ideas/es] Simplify footer to \"Powered by AMVARA\

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/22
- **Number:** #22
- **Labels:** none
- **Created:** 2026-06-06T10:25:41Z

## Problem / goal
## Summary  The submitter requests a footer text change on the site. The current line reads "Powered by AMVARA, developed by LdeLuipy" and they want it shortened to "Powered by AMVARA" only, removing the developer credit. This likely affects footer c...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/22
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation
- Updated `footer.poweredByHtml` in all four locale files (`src/i18n/es.json`, `ca.json`, `en.json`, `de.json`) to remove the ", developed by LdeLuipy" clause and link.
- No changes to `Footer.astro` (still renders `m.footer.poweredByHtml` via `set:html`).
- Site version bumped: **1.1.38 → 1.1.39** (`package.json`).

## Testing instructions
1. `docker compose build && docker compose up -d`
2. Confirm HTTP 200 on `/`, `/ca/`, `/en/`, `/de/`, `/doc/`.
3. On each locale home page, scroll to the footer and verify the line reads **Powered by AMVARA** (linked to `https://amvara.de/#/`).
4. Confirm **no** "developed by LdeLuipy" text or `ldeluipy.es` link in the footer on any locale.
5. Confirm footer shows version **1.1.39** (e.g. `curl -s http://127.0.0.1:9180/ | grep 'Versión 1.1.39'`).

## Test report

1. **Date/time (UTC):** 2026-06-06T10:30:40Z – 2026-06-06T10:30:59Z. Log window: nginx access logs from 10:30:52Z through 10:30:54Z.
2. **Environment:** branch `main` @ `8ed1268` (uncommitted local WIP for issue #22); build via `docker compose build && docker compose up -d` (`km0-web@1.1.39`, 68 pages). Host has no `npm` on PATH; Docker build is authoritative. URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Docker build/deploy, footer `poweredByHtml` on all locale home pages (ES `/`, CA `/ca/`, EN `/en/`, DE `/de/`), absence of LdeLuipy credit and link, footer version label, standard smoke paths, production poll for footer content and version.
4. **Results:**
   - Docker build/up (68 pages, em-dash check OK): **PASS** (`[build] 68 page(s) built in 3.17s`; both containers Up)
   - HTTP 200 on `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`: **PASS** (all `HTTP/1.1 200 OK`)
   - Footer ES `/`: **PASS** (`Powered by <a href="https://amvara.de/#/" ...>AMVARA</a>`)
   - Footer CA `/ca/`: **PASS** (same AMVARA-only powered-by line)
   - Footer EN `/en/`: **PASS** (same AMVARA-only powered-by line)
   - Footer DE `/de/`: **PASS** (same AMVARA-only powered-by line)
   - No "developed by LdeLuipy" or `ldeluipy` in footer (all locales): **PASS** (grep count 0 on each locale; repo-wide grep zero matches)
   - Footer version **1.1.39** all locales: **PASS** (ES `Versión 1.1.39`, CA `Versió 1.1.39`, EN/DE `Version 1.1.39`)
   - Production readiness: **PASS** (`https://km0digital.com/` returned `HTTP/2 200` on first poll; footer shows `Powered by AMVARA` link and `Versión 1.1.39`, zero `ldeluipy` matches)
   - GitHub label `agent:testing` on issue #22: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`; `https://km0digital.com/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.39 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   10:30:50 [build] 68 page(s) built in 3.17s
   172.21.0.1 - - [06/Jun/2026:10:30:54 +0000] "HEAD / HTTP/1.1" 200 0
   172.21.0.1 - - [06/Jun/2026:10:30:54 +0000] "HEAD /ca/ HTTP/1.1" 200 0
   172.21.0.1 - - [06/Jun/2026:10:30:54 +0000] "GET / HTTP/1.1" 200 43616
   172.21.0.1 - - [06/Jun/2026:10:30:54 +0000] "GET /en/ HTTP/1.1" 200 43249
   ```
8. **GitHub:** label `agent:testing` applied on issue #22 at test start.
