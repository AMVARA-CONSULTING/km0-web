---
## Closing summary (TOP)

- **What happened:** Issue #53 requested KM0 Cloud marketing copy that speaks to individuals and freelancers, not only enterprises.
- **What was done:** Updated `services.headingBefore`, `services.intro`, and cloud card subtitle across es/ca/en/de i18n to remove enterprise-only framing while keeping the 500 GB / 1,99 € slogan unchanged.
- **What was tested:** Docker build, HTTP smoke on all locales, ES services block copy, locale regression, CTAs, footer version 1.1.87, and production readiness; overall **PASS**.
- **Why closed:** All testing criteria passed; broader-audience copy verified on loopback and production.
- **Closed at (UTC):** 2026-06-27 13:21
---

# [ideas/es] KM0 Cloud: copy más amplio que solo empresas

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/53
- **Number:** #53
- **Labels:** none
- **Created:** 2026-06-26T17:10:56Z

## Problem / goal
## Summary  The submitter dislikes the KM0 Cloud marketing block because it frames the offering as enterprise-only ("nube empresarial", "tu empresa"). They want the copy updated to reflect that KM0 Cloud serves a broader audience: individuals, privat...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/53
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation
- **`src/i18n/es.json`**, **`ca.json`**, **`en.json`**, **`de.json`**: Updated `services.headingBefore`, `services.intro`, and cloud card `subtitle` to welcome individuals, freelancers, and businesses of all sizes (removed enterprise-only framing such as "nube empresarial", "tu empresa", "business cloud").
- **Site version:** 1.1.85 → 1.1.86 (`package.json`).

## Testing instructions

1. **Build:** `docker compose build && docker compose up -d` (or `npm run build` when Node is available).
2. **HTTP smoke:** `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` → expect `200` on each.
3. **Services block (ES):** Open `/` and scroll to `#services` (or `#km0-cloud`). Confirm:
   - Heading reads **Tu nube, más cerca que nunca** (not "nube empresarial").
   - Intro mentions **particulares, autónomos y empresas de cualquier tamaño**.
   - Cloud card subtitle mentions **uso personal, profesional o en equipo**.
   - Slogan **500 GB desde 1,99 €/mes** unchanged.
4. **Locales:** Repeat on `/ca/`, `/en/`, `/de/` with aligned localized copy (no enterprise-only wording).
5. **Regression:** Cloud/Email CTAs, pricing link, and tutorial link still work; footer shows version **1.1.86**.

## Test report

1. **Date/time (UTC):** 2026-06-27T13:17:41Z – 2026-06-27T13:19:57Z. Log window: Docker/nginx from 13:18:48Z.
2. **Environment:** branch `main` @ `87d8d56` (uncommitted working tree: i18n, `package.json` 1.1.87); build via `docker compose build && docker compose up -d` (`km0-web@1.1.87`, 96 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** KM0 Cloud broader-audience copy per testing instructions: Docker build/deploy, HTTP smoke, ES services block copy, locale regression (no enterprise-only wording), CTA links, footer version, production readiness.
4. **Results:**
   - Docker build & deploy: **PASS** (`check-no-em-dash: OK`, 96 pages built)
   - HTTP smoke (`/`, `/ca/`, `/en/`, `/de/`): **PASS** (HTTP/1.1 200 OK each)
   - ES heading **Tu nube, más cerca que nunca** (not "nube empresarial"): **PASS**
   - ES intro mentions **particulares, autónomos y empresas de cualquier tamaño**: **PASS**
   - Cloud card subtitle **uso personal, profesional o en equipo**: **PASS**
   - Slogan **500 GB desde 1,99 €/mes** unchanged: **PASS**
   - No enterprise-only wording (`nube empresarial`, `tu empresa`) on ES: **PASS**
   - Locales CA/EN/DE (no enterprise-only framing): **PASS**
   - Regression CTAs (`/pricing/`, `/tutorials/getting-started-web/`, `cloud.km0digital.com`): **PASS**
   - Footer version **1.1.87** (combined delivery; task noted 1.1.86): **PASS**
   - Production readiness: **PASS** (`https://km0digital.com/` HTTP 200 on first poll; updated copy present)
   - GitHub label `agent:testing` on issue #53: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`; `https://km0digital.com/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.87 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   13:18:47 [build] 96 page(s) built in 3.42s
   2026/06/27 13:18:48 [notice] 1#1: start worker processes
   172.21.0.1 - - [27/Jun/2026:13:18:59 +0000] "HEAD / HTTP/1.1" 200 0
   172.21.0.1 - - [27/Jun/2026:13:19:26 +0000] "GET / HTTP/1.1" 200 53896
   172.21.0.1 - - [27/Jun/2026:13:19:26 +0000] "GET /ca/ HTTP/1.1" 200 53907
   ```
8. **GitHub:** label `agent:testing` applied on issue #53 at test start.
