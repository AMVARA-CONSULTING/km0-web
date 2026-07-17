---
## Closing summary (TOP)

- **What happened:** Home and nav stacked overlapping privacy/community sections that repeated the same message.
- **What was done:** Reduced landing to Hero → Offer → WhyKm0 → Community → FAQ → Contact; deleted unused section components; primary nav to 7 items; documented IA in docs/design/ia-map.md.
- **What was tested:** PASS - anchors keep/remove, 7-item nav, cloud-user proof band, FAQ dedupe (5 items), secondary routes 200, ia-map present.
- **Why closed:** All acceptance criteria passed; IA matches remodel epic.
- **Closed at (UTC):** 2026-07-17 18:50
---

# FEAT-Task: Information architecture - fewer sections, clearer paths

## GitHub Issue
- **Number:** #74
- **Title:** (see issue)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/74
- **Labels:** agent:wip
- **Depends / notes:** see body; run remodel epic in order

## Problem / goal

The home page stacks **Vision, Services, CloudUserStats, Mission, PrivacyTrust, Values, Community, MerchShowcase, Meaning, Faq, Contact** - many say the same thing (privacy, community, alternative to Big Tech) with different adjectives. Nav exposes too many peers (vision, values, community, meaning, mission, blog, ideas, meeting, tutorials, presentation, pricing, faq, contact). Readers bounce; agents keep adding sections instead of deleting.

## High-level instructions for coder

1. Read **`docs/design/anti-slop-doctrine.md`** and **`km0-web-copy`**. One job per section.
2. Propose and implement a **reduced IA** (edit `Landing.astro`, Header nav, `src/i18n/paths.ts` as needed):

### Target landing (max ~6 content blocks after header)

| Keep / merge | Role |
|--------------|------|
| Hero | Brand + promise + primary CTA (Cloud or Contact - pick one primary) |
| Offer (Services) | Cloud + Email, price hook, links to pricing/tutorials |
| Why KM0 | **Single** contrast block (replace separate Vision + Mission + Values + Meaning + PrivacyTrust overlap) |
| Community / Encuentros | One short block + link to `/meeting/` (do not duplicate manifesto) |
| FAQ | Keep but **dedupe** overlapping ISO/privacy answers (max one privacy FAQ, one cert FAQ) |
| Contact | Single clear next step |

### Kill or demote off home

- **Meaning** (logo symbolism) → footer link or `/presentation/` only, not a home section
- **MerchShowcase / Horizonte** → remove from home unless it has a real product URL; else kill
- **CloudUserStats** → **SACRED.** Keep the live registered-user counter. **Readapt** into the Offer / proof band (editorial number + short line), not a generic AI stat strip. Never remove the data source.
- **Presentation** → keep route, drop from primary nav if redundant with Why KM0

### Primary nav (desktop) target

Home · Cloud/Services · Pricing · Blog · Tutorials · Encuentros · Contact  
(Secondary: Ideas, Legal, Security, Presentation - footer or overflow)

3. Update all locales’ `nav` keys; remove dead section components only when nothing else imports them (or leave unused files with a comment if safer - prefer delete).
4. Preserve routes that already exist (`/doc/`, `/tutorials/`, `/pricing/`, `/ideas/`, `/meeting/`, `/security/`, `/legal/`) unless this task explicitly merges two pages - **do not** 404 useful URLs without redirects in `nginx/` or Astro redirects.
5. Document the final IA table in `docs/design/ia-map.md` (create short file).
6. Build + bump patch. Use GitHub issue #74.

## Acceptance

- Home has clearly fewer sections than today; no two adjacent sections repeating privacy sermon
- Nav ≤ ~7 primary items
- `docs/design/ia-map.md` exists
- Locales es/ca/en/de nav still coherent

## Implementation summary

**Direction (anti-slop pre-flight for IA-only scope):** civic editorial IA, editorial-column home order (not more SaaS sections), type/tokens deferred to FEAT-75, teal Signal for proof number, refuse: extra privacy sermons, merch theater, presentation in primary nav.

- Landing order: Hero → Offer (Services + CloudUserStats band) → WhyKm0 (`#why`) → Community → FAQ → Contact
- Deleted unused home components: Vision, Mission, Values, PrivacyTrust, Meaning, MerchShowcase
- Header: 7 items (Home, Services, Pricing, Blog, Tutorials, Encuentros, Contact); Ideas/Presentation/FAQ/Legal/Security in footer
- Hero CTA: primary → Cloud URL; secondary → Pricing (labels updated es/ca/en/de)
- FAQ: 5 items (merged duplicate ISO + privacy pairs) in all locales
- Documented in `docs/design/ia-map.md`; site version **1.1.103**
- Dead i18n keys for removed sections left for FEAT-76 cleanup

## Testing instructions

1. **HTTP smoke:** `curl -sI http://127.0.0.1:9180/` and `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/meeting/`, `/presentation/`, `/ideas/`, `/tutorials/` → expect **200**.
2. **Home sections:** Open `/`. Confirm anchors `#home`, `#services`, `#cloud-users`, `#why`, `#community`, `#faq`, `#contact` exist. Confirm `#vision`, `#mission`, `#values`, `#meaning`, `#privacy-trust` are **absent**.
3. **Nav:** Desktop header shows exactly **7** primary links: Inicio/Home, Servicios, Precios, Blog, Tutoriales, Encuentros, Contacto (locale equivalents). No Presentation/Ideas in primary bar.
4. **Offer + counter:** Under Services, live registered-user number appears as editorial proof (`cloud-user-proof`), not a full navy stat-strip section.
5. **Hero CTAs:** Primary goes to `https://cloud.km0digital.com`; secondary to locale Pricing (`/pricing/` or `/en/pricing/` etc.).
6. **Community:** CTA opens `/meeting/` (or locale `/ca/meeting/` etc.).
7. **FAQ:** Exactly **5** accordion items; one ISO question; one combined privacy/security question; no duplicate “is it certified?” pair.
8. **Footer:** Ideas, Presentation, Legal, Security still reachable; Why links to `/#why`.
9. **Version:** Footer shows **1.1.103**.
10. **Logs:** `docker logs --since 10m km0-web` shows no 5xx for the smoke paths.

## References
- `src/views/Landing.astro`
- `src/components/Header.astro`
- `docs/design/ia-map.md`
- NN/g succinct writing: https://www.nngroup.com/articles/be-succinct-writing-for-the-web/

## Test report

1. **Date/time (UTC):** 2026-07-17T18:48:03Z – 2026-07-17T18:48:30Z. Log window: nginx access from prior deploy (container already on 1.1.106) through smoke GETs at 18:48:17Z.
2. **Environment:** branch `main` @ `6edfc07`; container `km0-web` already rebuilt this session (`docker compose` → `1.1.106`). URLs: `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** HTTP smoke on home + secondary routes, landing anchors (keep vs remove), primary nav count/labels (ES/EN), Offer counter band, Hero CTAs, Community → meeting, FAQ count/dedupe, footer secondary links + `/#why`, `docs/design/ia-map.md`, version, 5xx scan.
4. **Results:**
   - HTTP smoke (`/`, locales, `/doc/`, `/pricing/`, `/meeting/`, `/presentation/`, `/ideas/`, `/tutorials/`): **PASS** (all 200)
   - Home anchors present (`#home`, `#services`, `#cloud-users`, `#why`, `#community`, `#faq`, `#contact`): **PASS**
   - Removed anchors absent (`#vision`, `#mission`, `#values`, `#meaning`, `#privacy-trust`): **PASS**
   - Primary nav exactly 7 (Inicio/Servicios/Precios/Blog/Tutoriales/Encuentros/Contacto; EN Home/Services/Pricing/Blog/Tutorials/Meetings/Contact): **PASS**; Presentation/Ideas not in primary bar
   - Offer + `cloud-user-proof` / `#cloud-users`: **PASS**
   - Hero CTAs: primary `https://cloud.km0digital.com` (`Abrir KM0 Cloud`), secondary `/pricing/` (`Ver precios`): **PASS**
   - Community CTA → `/meeting/`: **PASS**
   - FAQ exactly 5 items; one ISO; one privacy (`¿Vendéis o perfiláis mis datos?`); no duplicate cert pair: **PASS**
   - Footer Ideas/Presentation/Legal/Security + `/#why`: **PASS**
   - `docs/design/ia-map.md` exists: **PASS**
   - Footer version: **PASS** (`Versión 1.1.106`; task noted 1.1.103, later FEATs bumped)
   - No 5xx in recent `docker logs`: **PASS**
   - GitHub label `agent:testing` on issue #74: **PASS**
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/` (+ `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/meeting/`, `/presentation/`, `/ideas/`, `/tutorials/`, `/en/pricing/`, `/ca/meeting/`).
7. **Log excerpts:**
   ```
   HTTP smoke: 200 for /, /ca/, /en/, /de/, /doc/, /pricing/, /meeting/, /presentation/, /ideas/, /tutorials/
   FAQ buttons (ES): 5 - ¿Qué es KM0? / ¿Cómo puedo participar? / ¿Dónde están los datos? / ¿Hay certificación ISO 27001? / ¿Vendéis o perfiláis mis datos?
   ```
8. **GitHub:** label `agent:testing` applied on issue #74 at test start.
