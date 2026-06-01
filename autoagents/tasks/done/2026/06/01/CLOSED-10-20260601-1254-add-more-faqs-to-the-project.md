---
## Closing summary (TOP)

- **What happened:** GitHub issue #10 requested additional FAQ entries on security and certification topics.
- **What was done:** Added three FAQ items (`iso27001`, `data-security`, `certification`) in all four locale i18n files with honest posture and links to blog and contact.
- **What was tested:** Tester PASS: Docker deploy, HTTP smoke 200, six FAQ accordion items including new entries, blog/contact links, no em dash in i18n.
- **Why closed:** All testing criteria passed.
- **Closed at (UTC):** 2026-06-01 12:55
---

# Add more FAQs to the project

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/10
- **Number:** #10
- **Labels:** agent:wip
- **Created:** 2026-06-01T12:31:08Z

## Problem / goal
Add more FAQ entries to address common security and certification questions (ISO 27001, data security, general certification), consistent with the project's honest security posture.

## Implementation
- Added three FAQ items (`iso27001`, `data-security`, `certification`) in `src/i18n/es.json`, `ca.json`, `en.json`, `de.json`.
- Answers state no ISO 27001 / third-party audits today; describe EU hosting, TLS, no data resale; link to locale blog and `#contact`.
- Site version bumped to **1.1.15** (`package.json`).

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Testing instructions

1. **Build:** `docker compose build && docker compose up -d` (or `npm run build` if Node is available).
2. **HTTP smoke:** `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` — expect `200 OK`.
3. **FAQ content (all locales):** Open `/#faq` (or `/ca/#faq`, `/en/#faq`, `/de/#faq`). Confirm six accordion items; new ones cover ISO 27001 (answer: no), data security, and general certification.
4. **Footer:** Confirm version **1.1.15** on Spanish (`Versión`), English (`Version`), Catalan (`Versió`), German (`Version`).
5. **Links:** Blog links in new FAQs resolve (`/doc/`, `/ca/doc/`, `/en/doc/`, `/de/doc/`). Contact anchors scroll to `#contact`.
6. **No em dash:** `grep -r $'\xe2\x80\x94' src/i18n/` should return nothing.

## Test report

1. **Date/time (UTC):** 2026-06-01T12:53:19Z – 2026-06-01T12:54:34Z. Log window: nginx startup at 12:53:55Z.
2. **Environment:** branch `main`, `docker compose build && docker compose up -d`. URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Docker deploy, HTTP smoke, FAQ section (6 items, new ISO/data/cert entries), footer version all locales, blog/contact links in i18n, em dash grep.
4. **Results:**
   - Docker build/up: **PASS**
   - HTTP smoke `/`, `/ca/`, `/en/`, `/de/`, `/doc/`: **PASS** (all `200`)
   - FAQ content (6 accordion items; ISO 27001 “no”, data security, certification): **PASS** (`faq-item` count 6 on ES/CA/EN/DE; ISO 27001 text in rendered HTML)
   - Footer version **1.1.15** (as written at handoff): **PASS** superseded – workspace `package.json` is **1.1.17** after later tasks; footer shows **1.1.17** on ES (`Versión`), CA (`Versió`), EN/DE (`Version`)
   - Blog links `/doc/`, `/ca/doc/`, `/en/doc/`, `/de/doc/` and `#contact` in new FAQ answers: **PASS** (verified in `src/i18n/*.json` and rendered CA/EN HTML)
   - No em dash in `src/i18n/`: **PASS** (grep zero matches)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`; `https://km0digital.com/` (`200` on first poll).
7. **Log excerpts:** nginx worker processes started 12:53:55Z (see task #9 report window).
