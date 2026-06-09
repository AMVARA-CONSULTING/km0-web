---
## Closing summary (TOP)

- **What happened:** Ferran asked whether legal compliance topics were covered; human validation approved unified Legal and Security pages for km0digital.com and KM0 Cloud.
- **What was done:** Added `/legal/` and `/security/` routes in all four locales with i18n content, footer links, FAQ cross-links, `security.txt`, and nginx Permissions-Policy; site version bumped to 1.1.41.
- **What was tested:** Docker build (76 pages), HTTP smoke on all legal/security routes and locales, content checks, security headers, footer version, locale switcher, and production poll on km0digital.com; all PASS.
- **Why closed:** All acceptance criteria and testing instructions passed; production readiness confirmed.
- **Closed at (UTC):** 2026-06-09 13:54
---

# [ideas/ca] Pregunta sobre temes de legalitat

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/21
- **Number:** #21
- **Labels:** none
- **Created:** 2026-06-05T20:19:46Z

## Problem / goal
Ferran asked whether legal compliance topics have been addressed. Human validation approved implementing unified Legal and Security pages covering km0digital.com and KM0 Cloud.

## Implementation summary
- Added `/legal/` and `/security/` routes in all four locales (es, ca, en, de)
- Views: `src/views/Legal.astro`, `src/views/Security.astro`
- i18n: legal notice, GDPR privacy (marketing + cloud), cookies, KM0 Cloud section, security practices, ISO 27001, responsible disclosure
- Footer links to Legal and Security
- FAQ entries (iso27001, data-security, certification) cross-link to new pages
- `public/.well-known/security.txt` (RFC 9116)
- nginx: Permissions-Policy header in container and production vhost
- Site version bumped to 1.1.41

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Testing instructions

1. **Build:** `docker compose build km0-web && docker compose up -d km0-web`
2. **HTTP smoke (expect 200):**
   - `curl -sI http://127.0.0.1:9180/legal/`
   - `curl -sI http://127.0.0.1:9180/security/`
   - `curl -sI http://127.0.0.1:9180/ca/legal/`
   - `curl -sI http://127.0.0.1:9180/en/security/`
   - `curl -sI http://127.0.0.1:9180/de/legal/`
   - `curl -sI http://127.0.0.1:9180/.well-known/security.txt`
3. **Content checks (browser or curl):**
   - `/legal/` shows AMVARA CONSULTING S.L., NIF ES-B65707994, Barcelona address
   - Cookie section states no marketing cookies today
   - Privacy covers ideas form spool (minutes), GitHub Issues retention, WhatsApp third-party notice
   - `#cloud` section documents KM0 Cloud data processing
   - `/security/` includes ISO 27001 wording aligned with FAQ and responsible disclosure rules
   - Footer on home page shows Legal and Security links (all locales)
   - FAQ items on ISO/security/certification link to `/legal/` and `/security/`
4. **Headers:** response includes `Permissions-Policy`, `X-Content-Type-Options`, `X-Frame-Options`, `Referrer-Policy`
5. **Footer version:** shows `1.1.41` after rebuild with bumped `package.json`
6. **Locale switcher:** on `/en/legal/`, CA/DE/ES links preserve `/legal/` path

**Note:** Legal/privacy owner review recommended before production release per issue acceptance criteria.

## Test report

1. **Date/time (UTC):** 2026-06-09T13:53:53Z – 2026-06-09T13:54:20Z. Log window: nginx access logs from 13:54:09Z through 13:54:16Z.
2. **Environment:** branch `main` @ `da23041` (uncommitted local changes for issue #21); build via `docker compose build km0-web && docker compose up -d km0-web` (`km0-web@1.1.41`, 76 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Docker build/deploy, HTTP smoke on `/legal/`, `/security/`, locale variants, `/.well-known/security.txt`, standard locale paths; legal notice content (AMVARA, NIF, Barcelona); cookie/privacy/cloud sections; security ISO 27001 and responsible disclosure; footer Legal/Security links (all locales); FAQ cross-links; security headers; footer version 1.1.41; locale switcher path preservation on `/en/legal/`; production poll for `/legal/` and version.
4. **Results:**
   - Docker build/up (76 pages, em-dash check OK): **PASS** (`[build] 76 page(s) built in 3.01s`; container Up)
   - HTTP 200 on `/legal/`, `/security/`, `/ca/legal/`, `/en/security/`, `/de/legal/`, `/.well-known/security.txt`: **PASS** (all `HTTP/1.1 200 OK`)
   - HTTP 200 on `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`: **PASS**
   - Legal notice (AMVARA CONSULTING S.L., ES-B65707994, Barcelona): **PASS**
   - Cookie section (no marketing cookies today): **PASS** (`hoy no establecemos cookies en las páginas de marketing`)
   - Privacy (ideas spool minutes, GitHub Issues retention, WhatsApp third-party): **PASS**
   - `#cloud` section (KM0 Cloud data processing): **PASS** (`section id="cloud"`)
   - Security page (ISO/IEC 27001:2022, responsible disclosure rules): **PASS**
   - Footer Legal/Security links (ES `/`, CA `/ca/`, EN `/en/`, DE `/de/`): **PASS**
   - FAQ cross-links to `/legal/` and `/security/` (incl. `#iso27001`): **PASS**
   - Security headers (`Permissions-Policy`, `X-Content-Type-Options`, `X-Frame-Options`, `Referrer-Policy`): **PASS** on loopback and production
   - Footer version **1.1.41** all locales: **PASS** (ES `Versión 1.1.41`, CA `Versió 1.1.41`, EN/DE `Version 1.1.41`)
   - Locale switcher on `/en/legal/` preserves `/legal/` (CA, DE, ES, EN): **PASS**
   - `security.txt` RFC 9116 fields (Contact, Policy, Expires): **PASS**
   - Docker logs: no errors after deploy: **PASS** (nginx startup + 200 responses only)
   - Production readiness: **PASS** (`https://km0digital.com/legal/` returned HTTP 200 on first poll; footer `Versión 1.1.41`, AMVARA content present, security headers present)
   - GitHub label `agent:testing` on issue #21: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/legal/`, `/security/`, `/ca/legal/`, `/en/security/`, `/de/legal/`, `/.well-known/security.txt`, `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`; `https://km0digital.com/`, `https://km0digital.com/legal/`, `https://km0digital.com/security/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.41 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   13:54:07 [build] 76 page(s) built in 3.01s
   172.21.0.1 - - [09/Jun/2026:13:54:12 +0000] "HEAD /legal/ HTTP/1.1" 200 0
   172.21.0.1 - - [09/Jun/2026:13:54:12 +0000] "HEAD /security/ HTTP/1.1" 200 0
   172.21.0.1 - - [09/Jun/2026:13:54:12 +0000] "HEAD /.well-known/security.txt HTTP/1.1" 200 0
   172.21.0.1 - - [09/Jun/2026:13:54:13 +0000] "GET /en/legal/ HTTP/1.1" 200 21728
   172.21.0.1 - - [09/Jun/2026:13:54:16 +0000] "GET /.well-known/security.txt HTTP/1.1" 200 148
   ```
8. **GitHub:** label `agent:testing` applied on issue #21 at test start.
