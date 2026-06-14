---
## Closing summary (TOP)

- **What happened:** GitHub issue #44 requested legal and security page updates to cover KM0 Mail at `mail.km0digital.com`.
- **What was done:** Extended legal, security, and FAQ copy in all four locales; added `#mail` TOC section; updated `public/.well-known/security.txt` Scope line; bumped site version to 1.1.79.
- **What was tested:** Legal and security pages in four locales, security.txt Scope line, legal↔security cross-links, FAQ ISO 27001 mail mention, em dash check, footer version, secrets grep. Overall **PASS**.
- **Why closed:** All testing criteria passed; production poll returned HTTP 200.
- **Closed at (UTC):** 2026-06-14 13:32
---

# Actualizar legal y seguridad para KM0 Mail (mail.km0digital.com)

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/44
- **Number:** #44
- **Labels:** documentation
- **Created:** 2026-06-14T13:17:54Z

## Problem / goal
## Contexto  Las páginas **Legal** (`/legal/`) y **Seguridad** (`/security/`) se añadieron en el día 9 (#21) cubriendo **km0digital.com** y **cloud.km0digital.com** únicamente.  Desde el 14 jun 2026 existe **KM0 Mail** en **https://mail.km0digital.co...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/44
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary

- Updated `legal` and `security` keys in `src/i18n/{es,en,ca,de}.json`:
  - Meta descriptions and intros now include KM0 Mail (`mail.km0digital.com`).
  - Legal notice: mail service link added alongside cloud.
  - Privacy policy: KM0 Mail data categories, purposes, retention, and subprocessors.
  - Cookies: Roundcube session cookies on mail subdomain.
  - New `mail` section (TOC id `#mail`) mirroring the KM0 Cloud block.
  - Security practices: HTTPS/TLS, IMAPS/SMTP ports, Rspamd, DKIM/SPF/DMARC, fail2ban.
  - ISO 27001 and responsible disclosure scope extended to mail.
- FAQ `iso27001` and `certification` answers updated in all four locales.
- `public/.well-known/security.txt`: added `Scope` line for mail subdomain.
- Site version bumped to **1.1.79** (`package.json`).

## Testing instructions

1. **Build:** `docker compose build` (or `npm run build`) from repo root. Expect exit 0.
2. **Deploy:** `docker compose up -d`.
3. **Legal pages (4 locales):**
   - `curl -sI http://127.0.0.1:9180/legal/` → 200
   - `curl -sI http://127.0.0.1:9180/en/legal/` → 200
   - `curl -sI http://127.0.0.1:9180/ca/legal/` → 200
   - `curl -sI http://127.0.0.1:9180/de/legal/` → 200
   - Confirm TOC includes **KM0 Mail** (`#mail`) and body mentions `mail.km0digital.com`, Roundcube cookies, Postfix/Dovecot/Rspamd.
4. **Security pages (4 locales):**
   - `curl -sI http://127.0.0.1:9180/security/` → 200
   - `curl -sI http://127.0.0.1:9180/en/security/` → 200
   - Confirm practices mention mail.km0digital.com, IMAPS 993, SMTP 587/25, Rspamd, DKIM/SPF/DMARC, fail2ban.
   - Confirm disclosure scope includes mail infrastructure.
5. **security.txt:** `curl -s http://127.0.0.1:9180/.well-known/security.txt` includes `Scope: ... mail.km0digital.com`.
6. **Cross-links:** Legal privacy links to security page; security links to legal page (per locale).
7. **FAQ:** Landing FAQ ISO 27001 answer mentions `mail.km0digital.com` in ES and EN at minimum.
8. **Em dash:** `./scripts/check-no-em-dash.sh` → OK.
9. **Footer version:** pages show **1.1.79**.
10. **No secrets:** grep built HTML for internal IPs or credentials (should find none in legal/security copy).

## Test report

1. **Date/time (UTC):** 2026-06-14T13:31:10Z – 2026-06-14T13:31:39Z. Log window: Docker/nginx from 13:31:19Z.
2. **Environment:** branch `main` @ `00dcd50` (uncommitted working tree); build via `docker compose build && docker compose up -d` (`km0-web@1.1.79`, 88 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Legal pages (4 locales), security pages (4 locales), security.txt Scope line, cross-links legal↔security, FAQ ISO 27001 mail mention, em dash check, footer version, secrets grep.
4. **Results:**
   - Docker build & deploy: **PASS**
   - Legal pages ES/EN/CA/DE HTTP 200: **PASS**
   - Legal TOC `#mail` + body mentions `mail.km0digital.com`, Roundcube, Postfix/Dovecot/Rspamd: **PASS**
   - Security pages ES/EN/CA/DE HTTP 200: **PASS**
   - Security practices: mail.km0digital.com, IMAPS 993, SMTP 587/25, Rspamd, DKIM/SPF/DMARC, fail2ban: **PASS**
   - Disclosure scope includes mail infrastructure: **PASS**
   - security.txt Scope line: **PASS** (`Scope: km0digital.com, cloud.km0digital.com, mail.km0digital.com`)
   - Cross-links legal→security, security→legal: **PASS**
   - FAQ ISO 27001 mentions `mail.km0digital.com` (ES + EN): **PASS**
   - Em dash check: **PASS** (`check-no-em-dash: OK`)
   - Footer version **1.1.79**: **PASS**
   - No secrets in legal/security HTML: **PASS**
   - Production readiness: **PASS** (`https://km0digital.com/` HTTP 200 on first poll)
   - GitHub label `agent:testing` on issue #44: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/legal/`, `/en/legal/`, `/ca/legal/`, `/de/legal/`, `/security/`, `/en/security/`, `/ca/security/`, `/de/security/`, `/.well-known/security.txt`; `https://km0digital.com/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.79 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   13:31:18 [build] 88 page(s) built in 3.32s
   172.21.0.1 - - [14/Jun/2026:13:31:22 +0000] "HEAD /legal/ HTTP/1.1" 200 0
   172.21.0.1 - - [14/Jun/2026:13:31:22 +0000] "HEAD /security/ HTTP/1.1" 200 0
   ```
8. **GitHub:** label `agent:testing` applied on issue #44 at test start.
