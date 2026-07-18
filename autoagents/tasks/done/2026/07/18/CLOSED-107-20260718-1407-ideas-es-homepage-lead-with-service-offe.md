---
## Closing summary (TOP)

- **What happened:** Homepage first screen led with movement/community framing instead of the concrete product offer.
- **What was done:** Product-first hero copy across locales; new `TrustSignals.astro` under hero; Community moved below FAQ; service-first WhyKm0/FAQ tweaks; live Cloud proof retained.
- **What was tested:** Product-first H1/tagline all locales; DOM order home→trust→…→faq→community→contact→purpose; trust facts + security links; anti-slop + live Cloud 302 PASS; Overall PASS.
- **Why closed:** Acceptance and anti-slop checks passed; not a craft-parity Hard-gate FEAT; skim found no SaaS icon-tile or purple-gradient regressions.
- **Closed at (UTC):** 2026-07-18 14:18
---

# [ideas/es] Homepage: lead with service offer, not movement

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/107
- **Number:** #107
- **Labels:** agent:wip
- **Created:** 2026-07-18T12:03:52Z

## Problem / goal
Homepage first screen should lead with the concrete product offer (EU-hosted private cloud and email, transparent pricing, human support, strong privacy defaults) instead of movement or community framing. Community language moves lower. Trust signals (Germany hosting, AMVARA operator, ISO, security) appear higher.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/107
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation notes
- Hero copy (es/ca/en/de): product-first headline ("Private cloud and email" / locale equivalents) + tagline with EU hosting, public price, human support, no profile sales.
- New `TrustSignals.astro` (`#trust`): editorial four-fact row (Germany hosting, AMVARA, ISO 27001, Security link) directly under the hero.
- Landing order: Hero → Trust → Services → WhyKm0 → CloudUserStats → Faq → Community → Contact → Purpose. Community/meetups sit below FAQ; Purpose stays as philosophy closer.
- WhyKm0 mid band + FAQ "what is KM0" / start answers: service-first, meetings optional.
- Site version bumped to **1.1.145**.

## Testing instructions

### Smoke
1. `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` → expect **200**.
2. Footer shows **Versión 1.1.145** (or locale equivalent) on home.
3. `docker logs --since 10m km0-web` → no nginx/build errors for these requests.

### Product-first hierarchy
4. Open `http://127.0.0.1:9180/`: H1 contains **Nube privada** / **y correo**; support line mentions UE, **1,99**, soporte humano / precio público; no "Tu control" movement-style hero lead.
5. Section DOM order (grep `id=`): `home` → `trust` → `services` → `why` → … → `faq` → `community` → `contact` → `purpose`.
6. `#trust` lists Alemania/Hetzner, AMVARA CONSULTING, ISO/IEC 27001:2022, and a link to `/security/`.
7. Repeat for `/en/`: H1 **Private cloud** / **and email**; trust shows Germany + Security → `/en/security/`. Same order on `/ca/` and `/de/`.

### Community lower / anti-slop
8. `#community` appears after `#faq`, not above products. FAQ "¿Qué es KM0?" leads with Cloud/Email, not "proyecto comunitario".
9. Visual: trust row is a hairline editorial fact grid (no icon-tile cards, no fake stat strip, no purple gradients, no centered SaaS dual-pill CTA recipe). Hero still has live Cloud proof (QR + deep link).

## Test report

1. **Date/time (UTC):** 2026-07-18 14:16:34 start → 14:17:20 end. Log window: docker access from 14:15:36Z deploy through 14:17:04Z test GETs.
2. **Environment:** branch `main` (uncommitted coder tree); image from earlier `docker compose build && up -d` (km0-web@1.1.146, healthy on `127.0.0.1:9180`); production HEAD `https://km0digital.com/` 200 (local verification primary).
3. **What was tested:** Smoke locales; product-first H1/tagline ES/EN/CA/DE; DOM section order; `#trust` facts + security hrefs; FAQ service-first; community below FAQ; anti-slop trust markup; live Cloud deep link.
4. **Results:**
   - Smoke 200 `/` `/ca/` `/en/` `/de/` `/doc/`: **PASS**
   - Footer version: **PASS** - `Versión`/`Version`/`Versió` **1.1.146** (supersedes task note 1.1.145 after later Ideas-nav bump; still ≥ required bump).
   - Logs: **PASS** - no nginx error/crit in window; 200 access lines only.
   - ES H1 product-first: **PASS** - `Nube privada y correo.`; support: UE, `1,99`, precio público, soporte humano; no `Tu control`.
   - Section order: **PASS** - `home → trust → services → why → cloud-users → faq → community → contact → purpose`.
   - `#trust` facts: **PASS** - Alemania/Hetzner Falkenstein, AMVARA CONSULTING, ISO/IEC 27001:2022, Seguridad → `/security/` (EN Germany + `/en/security/`; CA/DE localized + locale security paths).
   - EN/CA/DE H1: **PASS** - `Private cloud and email.` / `Núvol privat i correu.` / `Private Cloud und E-Mail.`; same section order.
   - Community after FAQ; FAQ not community-lead: **PASS** - order confirmed; ¿Qué es KM0? opens with `KM0 Cloud y KM0 Email : nube y correo privados alojados en la UE`.
   - Anti-slop trust + live proof: **PASS** - `TrustSignals.astro` is hairline 4-col label/value list (0 SVG icons, no purple/indigo classes); hero links `https://cloud.km0digital.com` (HEAD **302** → `auth.km0digital.com/login?service=cloud`, real product surface).
5. **Overall: PASS**
6. **URLs:** `http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/`; `https://cloud.km0digital.com` (302); `https://km0digital.com/` HEAD 200.
7. **Logs:** healthy container; sample `GET /` `GET /en/` etc. 200; no error lines.
