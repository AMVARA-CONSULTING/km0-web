---
## Closing summary (TOP)

- **What happened:** GitHub issue #19 requested showing the total number of cloud clients on km0-web.
- **What was done:** Added localized `/cloud/` pages with build-time OpenCloud user count via Graph API, navbar links, Docker env vars, i18n strings, and site version 1.1.27.
- **What was tested:** All criteria passed: Docker build/deploy, HTTP 200 on all locale cloud paths, numeric count (15), no secrets in HTML, nav links, i18n headings/labels, footer version, missing-credentials fallback, and production poll.
- **Why closed:** Tester report overall PASS; all testing instructions satisfied.
- **Closed at (UTC):** 2026-06-05 07:47
---

# [ideas/en] Display number of cloud clients on the site

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/19
- **Number:** #19
- **Labels:** none
- **Created:** 2026-06-05T05:06:55Z

## Problem / goal
## Summary  The submitter suggests showing the total number of cloud clients on the km0-web site. They did not specify where on the page it should appear, how the count should be sourced, or whether it should update dynamically. This reads as a marke...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/19
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- New `/cloud/` page (all locales) with build-time OpenCloud user count
- `src/lib/cloud-users.ts` fetches Graph API at build; credentials from `CLOUD_ADMIN_USER` / `CLOUD_APP_TOKEN`
- Navbar + mobile menu link (`cloudUsers` i18n key)
- Docker build args + `.env.example`; runbook documents 12-month token renewal
- GitHub repo secrets set for future CI: `CLOUD_ADMIN_USER`, `CLOUD_APP_TOKEN`
- Site version: **1.1.27**

## Testing instructions

1. **Env:** Ensure repo-root `.env` has `CLOUD_ADMIN_USER` and `CLOUD_APP_TOKEN` (see `.env.example`). Token expires after 12 months.
2. **Build:** `set -a && source .env && set +a && docker compose build && docker compose up -d`
3. **HTTP 200:** `curl -sI http://127.0.0.1:9180/cloud/ http://127.0.0.1:9180/en/cloud/ http://127.0.0.1:9180/ca/cloud/ http://127.0.0.1:9180/de/cloud/`
4. **Count rendered:** `curl -s http://127.0.0.1:9180/en/cloud/ | grep cloud-users-count` shows a numeric count (not "unavailable").
5. **No secrets in HTML:** `curl -s http://127.0.0.1:9180/en/cloud/ | grep -E 'CLOUD_|token|password'` returns nothing.
6. **Nav:** Desktop and mobile menus on `/en/` include "Cloud users" linking to `/en/cloud/`.
7. **i18n:** Spot-check `/cloud/` (ES), `/ca/cloud/`, `/de/cloud/` for localized heading and count label.
8. **Footer:** All locales show version **1.1.27**.
9. **Missing credentials:** Build without env vars shows "unavailable" message (no crash).

## Test report

1. **Date/time (UTC):** 2026-06-05T07:45:49Z – 2026-06-05T07:46:38Z. Log window: nginx access logs from 07:46:05Z through 07:46:18Z.
2. **Environment:** branch `main` @ `2a254bd` (uncommitted local WIP for issue #19); build via `docker compose build && docker compose up -d` with `.env` credentials (`km0-web@1.1.27`, 64 pages). Host has no `npm` on PATH; Docker build is authoritative. Missing-credentials check via separate `docker build` with empty `CLOUD_*` args. URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Docker build/deploy with credentials, cloud pages all locales, numeric count render, no secrets in HTML, desktop/mobile nav links, i18n headings and count labels (ES/CA/DE), footer version all locales, standard smoke paths, missing-credentials build (unavailable fallback), locale switcher `hreflang` on cloud page, production poll for cloud paths and version, nginx logs.
4. **Results:**
   - Docker build/up with credentials (64 pages, cloud routes in build log): **PASS** (`[build] 64 page(s) built in 2.83s`; both containers Up)
   - Cloud pages `/cloud/`, `/en/cloud/`, `/ca/cloud/`, `/de/cloud/`: **PASS** (all `HTTP/1.1 200 OK`)
   - Count rendered on `/en/cloud/`: **PASS** (`cloud-users-count` shows **15**, not "unavailable")
   - No secrets in HTML: **PASS** (`grep -E 'CLOUD_|token|password'` returned no matches)
   - Nav desktop + mobile on `/en/`: **PASS** ("Cloud users" links to `/en/cloud/` in both menus)
   - i18n ES `/cloud/`: **PASS** (heading "Número de usuarios en la nube", label "usuarios registrados en la nube", count 15)
   - i18n CA `/ca/cloud/`: **PASS** (heading "Nombre d'usuaris al núvol", label "usuaris registrats al núvol", count 15)
   - i18n DE `/de/cloud/`: **PASS** (heading "Anzahl der Cloud-Nutzer", label "registrierte Cloud-Nutzer", count 15)
   - Footer version **1.1.27**: **PASS** (`Versión 1.1.27` ES, `Versió 1.1.27` CA, `Version 1.1.27` EN/DE)
   - Standard smoke `/`, `/ca/`, `/en/`, `/de/`, `/doc/`: **PASS** (all `200`)
   - Missing credentials build: **PASS** (64 pages built; `/en/cloud/` shows "User count is temporarily unavailable.", no crash)
   - Locale switcher on `/en/cloud/`: **PASS** (`/ca/cloud/`, `/de/cloud/`, `/en/cloud/`, `/cloud/` with `hreflang`)
   - Production readiness: **PASS** (`https://km0digital.com/en/cloud/` returned `200` on first poll; count **15** and `Versión 1.1.27` on homepage)
   - GitHub label `agent:testing` on issue #19: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/cloud/`, `/en/cloud/`, `/ca/cloud/`, `/de/cloud/`, `/`, `/ca/`, `/en/`, `/de/`, `/doc/`; `https://km0digital.com/`, `https://km0digital.com/en/cloud/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.27 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   07:46:00 [build] 64 page(s) built in 2.83s
   172.21.0.1 - - [05/Jun/2026:07:46:09 +0000] "HEAD /cloud/ HTTP/1.1" 200 0
   172.21.0.1 - - [05/Jun/2026:07:46:09 +0000] "HEAD /en/cloud/ HTTP/1.1" 200 0
   172.21.0.1 - - [05/Jun/2026:07:46:09 +0000] "GET /en/cloud/ HTTP/1.1" 200 12152
   172.21.0.1 - - [05/Jun/2026:07:46:09 +0000] "GET /cloud/ HTTP/1.1" 200 12197
   ```
8. **GitHub:** label `agent:testing` applied on issue #19 at test start.
