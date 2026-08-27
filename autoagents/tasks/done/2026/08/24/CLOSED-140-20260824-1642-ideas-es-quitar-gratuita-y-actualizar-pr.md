---
## Closing summary (TOP)

- **What happened:** Issue #140 asked to remove "free/gratuita" KM0 Mail wording and align site copy with the paid 7,99 €/month base plan.
- **What was done:** Updated mail-register tutorials, day-20 blog bullets, and i18n pricing/services strings in all four locales; bumped site version to 1.3.3.
- **What was tested:** Docker build/deploy, grep for free-mail wording, tutorial/pricing/landing/blog spot-checks across ES/CA/EN/DE, HTTP smoke, and production poll. All PASS.
- **Why closed:** All testing criteria passed; copy-only diff with no anti-slop UI regressions.
- **Closed at (UTC):** 2026-08-24 16:46
---

# [ideas/es] Quitar \"gratuita\" y actualizar pricing KM0 Mail

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/140
- **Number:** #140
- **Labels:** agent:wip → agent:untested → agent:testing → CLOSED (pass)
- **Created:** 2026-08-24T16:36:21Z

## Problem / goal
## Summary  The submitter asks to update KM0 Mail onboarding or marketing copy on the site. Remove wording that implies a free account ("gratuita") and replace it with guidance on creating a paid KM0 Mail account. The intended model is a base plan at...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/140
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary

Removed all "free/gratuita/kostenlos" KM0 Mail wording and aligned copy with the **7,99 €/month base plan** (mail + cloud included, extra storage as paid add-on).

### Changed files

| Area | Files |
|------|-------|
| Tutorials | `src/content/tutorials/{es,ca,en,de}/mail-register.md` |
| Blog | `src/content/doc/{es,ca,en,de}/day-20.md` |
| i18n pricing + services | `src/i18n/{es,ca,en,de}.json` (KM0 Email path: 6,99 → 7,99, mail + cloud bundle) |
| Version | `package.json` 1.3.2 → 1.3.3 |

### Copy changes

- Tutorial titles: "Cómo crear una cuenta de KM0 Mail" (and equivalents in ca/en/de).
- Tutorial intros: state 7,99 €/month base plan, mail + cloud included, extra storage paid; link to pricing page.
- Blog day-20 bullet updated to match paid model.
- Landing services card and pricing page email path: 7,99 €/month, "mail + cloud" bundle copy.

## Testing instructions

1. **Build:** `docker compose build && docker compose up -d` (PASS: build completes, footer shows **Versión 1.3.3**).
2. **No free wording:** `rg -i 'gratuit|kostenlos|free.*mail' src/` returns zero matches.
3. **Spanish tutorial:** open `/tutorials/mail-register/` - title must **not** contain "gratuita"; intro must show **7,99 €/mes** and link to `/pricing/`.
4. **Locales:** repeat spot-check on `/ca/tutorials/mail-register/`, `/en/tutorials/mail-register/`, `/de/tutorials/mail-register/` (200 OK, paid-plan copy present).
5. **Pricing page:** open `/pricing/` and `/en/pricing/` - KM0 Email path shows **7,99 €** (or €7.99) with "mail + cloud" note, not 6,99 €.
6. **Landing services:** home page KM0 Email card shows 7,99 €/month pricing.
7. **Blog:** `/doc/day-20/` list item 1 mentions paid base plan, not "cuenta gratuita".
8. **HTTP smoke:** `curl -sI http://127.0.0.1:9180/` and locale paths return **200**.

## Test report

1. **Date/time (UTC) and log window:** Start 2026-08-24T16:44:54Z (UNTESTED → TESTING + `agent:testing`). Docker rebuild/up 16:45:08Z–16:45:12Z. Checks 16:45:15Z–16:45:35Z. Report close 16:45:35Z. Docker log window 16:45:12Z–16:45:15Z.

2. **Environment:** Branch `main` at `50af0fa` (local uncommitted ship under test, package `1.3.3`). Build: `docker compose build && docker compose up -d` (Astro `1.3.3`, em-dash/mailto prebuild OK after tester fixed U+2014 in task Testing instructions, 176 pages). Loopback `http://127.0.0.1:9180/`. Production: `https://km0digital.com/` polled to **200** on first attempt (16:45:19Z); tutorial and footer show **Versión 1.3.3** and paid-plan copy.

3. **What was tested:** Docker build/deploy; grep for free-mail wording in `src/`; Spanish/CA/EN/DE mail-register tutorials; ES/EN pricing KM0 Email path; home services KM0 Email card; blog day-20 list item; HTTP smoke on locale and content paths; production spot-check; docker access logs.

4. **Results:**
   - **Build and deploy:** **PASS** - `docker compose build` completed; container `km0-web` up on `127.0.0.1:9180->80`; footer shows **Versión 1.3.3**.
   - **No free wording:** **PASS** - `grep -riE 'gratuit|kostenlos|free.*mail' src/` returned zero matches.
   - **Spanish tutorial:** **PASS** - Title "Cómo crear una cuenta de KM0 Mail" (no "gratuita"); intro shows **7,99 €/mes** and link to `/pricing/`.
   - **Locales (CA/EN/DE tutorials):** **PASS** - All **200**; paid-plan copy present (7,99 €/mes, €7.99/month, 7,99 €/Monat) with mail + cloud wording and pricing links.
   - **Pricing page (ES/EN):** **PASS** - KM0 Email path shows **7,99 €** / **€7.99** with `/mes · mail + cloud` note; no **6,99 €** / **6.99** on either page.
   - **Landing services card:** **PASS** - Home page shows **7,99 €/mes** for KM0 Email with mail + cloud.
   - **Blog day-20:** **PASS** - List item 1: "plan base de 7,99 €/mes (correo y cloud)"; no "cuenta gratuita".
   - **HTTP smoke:** **PASS** - `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`, all four mail-register tutorials, `/pricing/`, `/en/pricing/`, `/doc/day-20/` returned **200**.
   - **Production:** **PASS** - `https://km0digital.com/` **200**; `/tutorials/mail-register/` shows paid 7,99 € copy and **Versión 1.3.3** footer.
   - **GitHub label:** **PASS** - `agent:testing` on #140 at start; removed on PASS → CLOSED.

5. **Overall: PASS**

6. **URLs tested:** Loopback: `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`, `/tutorials/mail-register/`, `/ca/tutorials/mail-register/`, `/en/tutorials/mail-register/`, `/de/tutorials/mail-register/`, `/pricing/`, `/en/pricing/`, `/doc/day-20/`. Production: `https://km0digital.com/`, `https://km0digital.com/tutorials/mail-register/`.

7. **Log excerpts:**
   ```
   km0-web Up 127.0.0.1:9180->80/tcp (started 2026/08/24 16:45:12)
   Astro build: 176 page(s) built; check-no-em-dash OK; check-no-mailto OK
   GET / HTTP/1.1 200 (Versión 1.3.3)
   HEAD /tutorials/mail-register/ 200; HEAD /pricing/ 200
   ```

8. **GitHub:** label `agent:testing` on #140 at start; removed on PASS → CLOSED.
