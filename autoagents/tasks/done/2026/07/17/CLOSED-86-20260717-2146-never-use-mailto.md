---
## Closing summary (TOP)

- **What happened:** Product owner banned `mailto:` across km0-web; legal/security/contact still used it.
- **What was done:** Replaced all shipped mailto links with plain email text or on-site contact hashes; added `check-no-mailto` rule, script, prebuild/CI hooks; version 1.1.114 (tree later at 1.1.116).
- **What was tested:** Tester PASS: zero mailto in sources and nginx html; contact/pricing/legal/security/security.txt; locales and production spot-check.
- **Why closed:** All acceptance criteria passed; durable regression guard in place.
- **Closed at (UTC):** 2026-07-17 21:58
---

# FEAT-Task: Never use mailto: links anywhere on the site

## GitHub Issue
- **Number:** #86
- **Title:** Never use mailto: links anywhere on the site
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/86
- **Labels:** agent:wip

## Problem / goal
Product owner mandate: **never use the `mailto:` tag/scheme** on km0-web. Existing legal/security/contact copy still links emails with `mailto:` (e.g. `legal@amvara.de`, `hello.yoel@amvara.de` in `src/i18n/*.json`). Agents must not reintroduce it.

## High-level instructions for coder
1. Search the whole repo for `mailto:` (`src/`, `email-templates/`, `public/`, docs that ship to site). List hits in the Implementation summary.
2. Replace every `<a href="mailto:…">` with plain visible email text (or a non-mailto pattern such as copy-to-clipboard if already used elsewhere). Keep the address readable for humans and accessible (do not obfuscate into unusable junk).
3. Add a durable ban:
   - `.cursor/rules/` always-apply or glob rule: **never emit mailto:**
   - Prefer a prebuild check (mirror `check-no-em-dash` style) that fails the build if `mailto:` appears under `src/` (and other shipped paths).
4. Update `CONTRIBUTING.md` / agent prompts briefly if they mention contact links.
5. `npm run build` / docker per runbook; `./scripts/bump-patch-version.sh`; gh comment; labels `agent:wip` → UNTESTED.

## Acceptance
- Zero `mailto:` in shipped frontend content
- Automated guard or explicit rule so regressions fail loudly
- Four locales (es/ca/en/de) consistent
- Build green

## Implementation summary
### mailto: hits found (before)
- `src/components/Contact.astro` - contact CTA `mailto:${email}`
- `src/views/Pricing.astro` - custom proposal CTA `mailto:`
- `src/views/Presentation.astro` - CTA email `mailto:`
- `src/i18n/{es,ca,en,de}.json` - 9 mailto anchors each in legal/security HTML
- `public/.well-known/security.txt` - `Contact: mailto:hello.yoel@amvara.de`
- `email-templates/cloudstyle/{es,ca,en,de}.html` and `email-templates/welcome/es.html` - help mailto links

### Changes
- Replaced mailto anchors with plain visible email text in all four locale JSON files; rewrote privacy bullet that claimed "email links open your mail client".
- Contact: plain `contact__email` text (no link). Pricing custom CTA → `withHash(locale, 'contact')`. Presentation: plain email span.
- `security.txt` Contact → `https://km0digital.com/security/` (RFC 9116 URI, no mailto).
- Email templates: help address as plain text.
- Added `.cursor/rules/no-mailto.mdc`, `scripts/check-no-mailto.sh`, `npm run check:no-mailto` on predev/prebuild, pre-commit + CI workflow, CONTRIBUTING + direct-user-prompts notes.
- Site version **1.1.113 → 1.1.114**.
- Scrubbed sibling FEAT/docs em dashes so `check-no-em-dash` / Docker build could pass (unrelated to product mailto work).

## Testing instructions
1. `./scripts/check-no-mailto.sh` → OK (zero matches in `src/`, `public/`, `email-templates/`).
2. `./scripts/check-no-em-dash.sh` → OK.
3. `docker compose build km0-web && docker compose up -d km0-web` (prebuild runs both checks; build green, 124 pages).
4. HTTP 200: `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/legal/`, `/security/`, `/pricing/`, `/presentation/`, `/.well-known/security.txt`.
5. `grep -r mailto: /usr/share/nginx/html` inside container → zero hits.
6. Landing contact shows plain `hello.yoel@amvara.de` (not an `<a href="mailto:…">`).
7. `/en/pricing/` custom CTA href is `/en/#contact` (not mailto).
8. `/en/legal/` and `/en/security/` show `legal@amvara.de` / `hello.yoel@amvara.de` as text; zero `mailto:`.
9. `curl -s http://127.0.0.1:9180/.well-known/security.txt` → `Contact: https://km0digital.com/security/`.
10. Footer version **1.1.114** on `/`.
11. Optional negative: temporarily add `mailto:` under `src/` and confirm `npm run check:no-mailto` / prebuild fails.

## References
- Runbook: docs/runbook.md
- Site: https://km0digital.com

## Test report

1. **Date/time (UTC):** 2026-07-17T21:55:15Z start → 2026-07-17T21:56:07Z end. Log window: 2026-07-17 21:55:39–21:55:56 UTC (`docker logs km0-web`).
2. **Environment:** branch `main` (synced, ahead of origin with uncommitted work); build via `docker compose build km0-web && docker compose up -d km0-web`; loopback `http://127.0.0.1:9180/`; production `https://km0digital.com/` (HTTP/2 200, ready on first poll). Host has no npm; checks used `./scripts/check-no-mailto.sh` / `check-no-em-dash.sh` on host and prebuild inside Docker.
3. **What was tested:** Testing instructions 1–10 (optional negative skipped); zero `mailto:` in sources and nginx html; contact/pricing/legal/security/`security.txt`; footer version; locale landings; production spot-check.
4. **Results:**
   - check-no-mailto → **PASS** (`check-no-mailto: OK`; prebuild in Docker also OK)
   - check-no-em-dash → **PASS**
   - Docker build/up → **PASS** (124 pages; container Up on 127.0.0.1:9180)
   - HTTP 200 paths (`/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/legal/`, `/security/`, `/pricing/`, `/presentation/`, `/.well-known/security.txt`, `/en/pricing|legal|security/`) → **PASS**
   - `grep -r mailto:` under `/usr/share/nginx/html` → **PASS** (`files_with_mailto_count=0`)
   - Contact plain email (`contact__email`, `hello.yoel@amvara.de`, no mailto) → **PASS**
   - `/en/pricing/` custom CTA `href="/en/#contact"` → **PASS**
   - `/en/legal/` + `/en/security/` plain addresses, zero mailto → **PASS**
   - `security.txt` Contact `https://km0digital.com/security/` → **PASS** (loopback + production)
   - Footer version → **PASS** (task noted 1.1.114; tree shows **1.1.116** after sibling UNTESTED-87/88 bumps; bump present and shipped)
   - Guard artifacts (`.cursor/rules/no-mailto.mdc`, `scripts/check-no-mailto.sh`, CI workflow) → **PASS**
   - Production `/` mailto count 0; `security.txt` Contact https → **PASS** (ready: first `curl -sI` returned HTTP/2 200)
5. **Overall:** **PASS**
6. **URLs:** `http://127.0.0.1:9180/` (+ locales, doc, legal, security, pricing, presentation, security.txt, en variants); `https://km0digital.com/`, `https://km0digital.com/.well-known/security.txt`
7. **Logs:** nginx start 21:55:39 UTC; access 200s for all tested paths 21:55:55–21:55:56 UTC; no errors in tail.

