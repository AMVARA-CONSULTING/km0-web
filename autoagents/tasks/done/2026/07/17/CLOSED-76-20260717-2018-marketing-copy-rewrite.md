---
## Closing summary (TOP)

- **What happened:** Landing and chrome copy was slogan-heavy and repetitive across hero/why/faq/services.
- **What was done:** Rewrote es/ca/en/de marketing strings for surviving keys; deleted dead IA keys; privacy said once in FAQ; services use price/facts.
- **What was tested:** PASS - hero headlines per locale, 15-second scan, FAQ privacy/ISO uniqueness, dead keys gone, em dash OK, HTTP 200.
- **Why closed:** All acceptance criteria passed; copy skill criteria met.
- **Closed at (UTC):** 2026-07-17 18:50
---

# FEAT-Task: Marketing copy 180° - i18n rewrite

## GitHub Issue
- **Number:** #76
- **Title:** (see issue)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/76
- **Labels:** agent:untested
- **Depends / notes:** see body; run remodel epic in order


## Problem / goal

Landing and shared chrome copy is **repetitive, slogan-heavy, and tiring**. Privacy / community / “alternativa real” appear in hero, vision, mission, privacyTrust, values, community, FAQ, and services with the same shape. Readers scan; marketese lowers trust (NN/g).

**Objective:** make someone understand and *like* reading KM0 - concrete, short, honest. Use LLM strength for clarity, not for more adjectives.

## High-level instructions for coder

1. Apply **`km0-web-copy`** fully. Read NN/g concise/scannable/objective.
2. Rewrite **`src/i18n/es.json`** first for surviving keys only (delete dead keys for removed sections).
3. Rules of thumb:
   - ≤50% words vs current fluff where possible
   - One privacy statement site-wide in FAQ or Why - not five
   - Hero: one promise a neighbour would say out loud
   - Services: price + what you get + where data lives - no “fiable, segura y gestionada” adjective stacks
   - FAQ: merge duplicate ISO/cert/privacy items into one clear answer each
   - Contact: one action (email or WhatsApp), not a manifesto
4. Mirror into `ca.json`, `en.json`, `de.json` with equal quality (not broken calques).
5. No U+2014 em dashes. Keep HTML in FAQ answers valid.
6. Do not rewrite full blog markdown here (separate FEAT) except shared `doc.*` chrome strings if needed.
7. Build + bump. Use GitHub issue #76.

## Acceptance

- No near-duplicate paragraphs across hero/why/faq
- 15-second test: stranger can say what KM0 offers and what to do next
- All four locales updated

## Implementation summary

- Rewrote landing + shared chrome in **es/ca/en/de**: meta, hero, Why (`vision`), Offer (`services`), community, FAQ, contact, `doc.*`, tutorials intros.
- Deleted dead keys from removed IA sections: `values`, `meaning`, `mission`, `privacyTrust`, `merch`, plus unused nested fields; trimmed `nav.values|meaning|mission`. Updated `src/i18n/types.ts`.
- Privacy said once as a hard answer in FAQ (`data-privacy`); hero keeps one short neighbour-line; Why focuses on contrast facts (hosting, price, people), not a second privacy sermon.
- Services: price + what + UE location; no adjective stacks.
- Light trim on pricing headlines / trust privacy duplicate and presentation lead (full secondary remodel remains FEAT-79).
- Site version **1.1.105**. `docker compose build && up -d` green; HTTP 200 on `/`, `/ca/`, `/en/`, `/de/`, `/doc/`.

## Testing instructions

1. **HTTP smoke:** `curl -sI http://127.0.0.1:9180/` and `/ca/`, `/en/`, `/de/`, `/doc/` → **200**.
2. **Hero (ES):** Open `/`. Headline reads **Nube y correo en la UE.** Support line includes **500 GB** and **1,99 €**. Primary CTA opens Cloud; secondary goes to Pricing.
3. **15-second scan:** From hero + services alone, a stranger can name Cloud + Email, the price, and the next action (Open Cloud / Pricing / Contact).
4. **No privacy echo:** Why (`#why`) must not repeat the FAQ privacy answer verbatim. FAQ has exactly **one** privacy item (`data-privacy`) and **one** ISO item.
5. **Services copy:** Cloud/Email descriptions state facts (GB, Hetzner/UE). No “fiable, segura y gestionada” stacks.
6. **Contact:** Heading/body are action-first (email + WhatsApp), not a movement manifesto.
7. **Locales:** Spot-check `/ca/`, `/en/`, `/de/` hero + FAQ for native phrasing (not broken calques). EN hero: **Cloud and email in the EU.**
8. **Dead keys:** Confirm `src/i18n/es.json` has **no** top-level `values`, `meaning`, `mission`, `privacyTrust`, `merch`.
9. **Blog chrome:** `/doc/` heading/intro are short (“Blog técnico” / “No filler” equivalents).
10. **Version:** Footer shows **1.1.105**.
11. **Em dash:** `./scripts/check-no-em-dash.sh` → OK.
12. **Logs:** `docker logs --since 10m km0-web` shows **200** for smoke paths, no 5xx.

## References
- https://www.nngroup.com/articles/how-users-read-on-the-web/
- https://www.nngroup.com/articles/concise-scannable-and-objective-how-to-write-for-the-web/
- `.cursor/skills/km0-web-copy/SKILL.md`

## Test report

1. **Date/time (UTC):** 2026-07-17T18:49:12Z – 2026-07-17T18:49:40Z. Log window: container from 18:46:59Z; smoke at 18:49:12Z+.
2. **Environment:** branch `main` @ `6edfc07`; `km0-web@1.1.106` on `http://127.0.0.1:9180/`.
3. **What was tested:** HTTP smoke, ES/CA/EN/DE hero headlines, 15-second offer facts, FAQ privacy/ISO uniqueness, Why vs FAQ privacy non-verbatim, services fact copy, contact action-first, dead i18n keys, `/doc/` chrome, version, em dash.
4. **Results:**
   - HTTP smoke (`/`, `/ca/`, `/en/`, `/de/`, `/doc/`): **PASS** (200)
   - Hero ES **Nube y correo en la UE.** with **500 GB** and **1,99 €**; Cloud + Pricing CTAs: **PASS**
   - 15-second scan (Cloud+Email, price, next action): **PASS**
   - FAQ: 5 items; one `data-privacy`; one `iso27001`; Why contrast facts ≠ FAQ privacy verbatim: **PASS**
   - Services: GB + Hetzner/UE facts; no "fiable, segura y gestionada" stack: **PASS**
   - Contact action-first (email + WhatsApp): **PASS**
   - Locales CA/EN/DE heroes native (EN: Cloud and email in the EU.): **PASS**
   - Dead keys absent (`values`, `meaning`, `mission`, `privacyTrust`, `merch`) in es/ca/en/de: **PASS**
   - Blog chrome `/doc/`: **Blog técnico** / **Sin relleno**: **PASS**
   - Footer version: **PASS** (`Versión 1.1.106`; task noted 1.1.105)
   - Em dash check: **PASS**
   - GitHub label `agent:testing` on issue #76: **PASS**
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`.
7. **Log excerpts:**
   ```
   HTTP 200 on /, /ca/, /en/, /de/, /doc/
   check-no-em-dash: OK
   ES H1: Nube y correo en la UE.
   EN H1: Cloud and email in the EU.
   ```
8. **GitHub:** label `agent:testing` applied on issue #76 at test start.
