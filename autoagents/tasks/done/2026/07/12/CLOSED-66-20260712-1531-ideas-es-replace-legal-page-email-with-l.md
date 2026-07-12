---
## Closing summary (TOP)

- **What happened:** GitHub issue #66 requested replacing the legal page contact email from `hello.yoel@amvara.de` to `legal@amvara.de`.
- **What was done:** Updated `legal.sections` bodyHtml in all four locale i18n files (`es.json`, `ca.json`, `en.json`, `de.json`); bumped site version to 1.1.99; left contact, presentation, and security emails unchanged.
- **What was tested:** Docker build/deploy, legal pages in all four locales, footer version, loopback smoke, and production readiness poll all **PASS**.
- **Why closed:** All acceptance criteria passed; tester report overall **PASS**.
- **Closed at (UTC):** 2026-07-12 15:32
---

# [ideas/es] Replace legal page email with legal@amvara.de

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/66
- **Number:** #66
- **Labels:** none
- **Created:** 2026-07-12T15:20:28Z

## Problem / goal
## Summary  The submitter asks to update the contact email on the legal page. The address `hello.yoel@amvara.de` should be replaced with `legal@amvara.de`. This is a straightforward content correction for legal/contact information on the site.  ## Or...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/66
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation
- Replaced `hello.yoel@amvara.de` with `legal@amvara.de` in `legal.sections` bodyHtml across all four locale files (`src/i18n/es.json`, `ca.json`, `en.json`, `de.json`).
- Left contact, presentation CTA, and security page emails unchanged (out of scope).
- Site version bumped: `1.1.98` → `1.1.99`.

## Testing instructions
1. `docker compose build && docker compose up -d` (or `npm run build`).
2. Confirm footer shows **Version 1.1.99** (or localized equivalent).
3. Open `/legal/`, `/ca/legal/`, `/en/legal/`, `/de/legal/` and verify:
   - All `mailto:` links and visible legal/privacy contact addresses show `legal@amvara.de`.
   - No `hello.yoel@amvara.de` appears on these pages.
4. Spot-check that `/` contact section and `/security/` still use `hello.yoel@amvara.de` (unchanged).
5. `curl -sI http://127.0.0.1:9180/legal/` returns `200 OK`.

## Test report

1. **Date/time (UTC):** 2026-07-12T15:31:20Z – 2026-07-12T15:31:44Z. Log window: Docker/nginx from 15:31:39Z.
2. **Environment:** branch `main` @ `148ad6d` (uncommitted working tree); build via `docker compose build && docker compose up -d` (`km0-web@1.1.99`, 124 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Docker build/deploy, standard HTTP smoke (home, locales, doc), legal pages (4 locales) for email replacement, spot-check home contact and security emails unchanged, footer version, production readiness poll.
4. **Results:**
   - Docker build & deploy: **PASS**
   - Em dash check (prebuild): **PASS** (`check-no-em-dash: OK`)
   - Footer version **1.1.99**: **PASS** (ES default: `Versión 1.1.99`)
   - Legal pages ES/CA/EN/DE HTTP 200: **PASS**
   - Legal pages show `legal@amvara.de` (12 occurrences, 6 `mailto:` per locale): **PASS**
   - No `hello.yoel@amvara.de` on legal pages: **PASS** (0 in all 4 locales)
   - Home contact still uses `hello.yoel@amvara.de` (2 occurrences): **PASS**
   - Security page still uses `hello.yoel@amvara.de` (6 occurrences): **PASS**
   - Standard loopback smoke (`/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`): **PASS** (all 200)
   - Production readiness: **PASS** (`https://km0digital.com/` HTTP 200 on first poll; production `/legal/` shows `legal@amvara.de`, no `hello.yoel@amvara.de`, footer `Versión 1.1.99`)
   - GitHub label `agent:testing` on issue #66: **PASS** (applied at test start; removed `agent:untested`)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`, `/legal/`, `/ca/legal/`, `/en/legal/`, `/de/legal/`, `/security/`; `https://km0digital.com/`, `https://km0digital.com/legal/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.99 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   15:31:37 [build] 124 page(s) built in 3.96s
   172.21.0.1 - - [12/Jul/2026:15:31:41 +0000] "HEAD /legal/ HTTP/1.1" 200 0
   172.21.0.1 - - [12/Jul/2026:15:31:41 +0000] "GET /legal/ HTTP/1.1" 200 31741
   172.21.0.1 - - [12/Jul/2026:15:31:41 +0000] "GET /en/legal/ HTTP/1.1" 200 31051
   ```
8. **GitHub:** label `agent:testing` applied on issue #66 at test start.
