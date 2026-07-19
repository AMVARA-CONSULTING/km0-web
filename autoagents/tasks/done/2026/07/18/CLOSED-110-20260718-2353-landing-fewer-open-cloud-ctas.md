---
## Closing summary (TOP)

- **What happened:** Home repeated identical Open Cloud btn-primary CTAs across Hero, Offer, Why, and Cloud users.
- **What was done:** Reduced Cloud primaries to hero + one Why reaffirm; demoted Offer/proof/Cloud-users duplicates to text links or section-specific CTAs; documented cadence.
- **What was tested:** Hard gate PASS on ES/EN (and locale inventory): exactly two Cloud-label primaries; Offer zero Cloud primary; section jobs clear; anti-slop clean.
- **Why closed:** Acceptance and Hard gate parity/anti-slop claims all passed.
- **Closed at (UTC):** 2026-07-19 00:18
---

# FEAT-Task: Landing - fewer identical Open Cloud CTAs

## GitHub Issue
- **Number:** #110
- **Title:** Landing: too many identical Open Cloud CTAs
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/110
- **Labels:** (agent:planned after sync)

## Origin
- **Source:** Direct operator request + GitHub #110.
- **Brief:** Home repeats "Abrir Cloud" / "Abrir KM0 Cloud" (and locale equivalents) as loud primary buttons across Hero, Offer, Why (×3), and Cloud users. Fix hierarchy, not just wording.
- **Skills:** `km0-anti-slop-design`, `km0-web-copy`.

## Problem / goal
The gather funnel kept the correct primary **language** (Open KM0 Cloud) but did not cap **how often** that action appears as `btn-primary`. Visitors see CTA spam instead of one confident product door and quieter, section-specific next steps.

**Current inventory (home, ES labels; same pattern ca/en/de):**
1. Hero - `btn-primary` "Abrir KM0 Cloud"
2. Hero proof - surface + QR + `liveCta` also "Abrir KM0 Cloud" → Cloud
3. Offer pin - sticky `btn-primary` "Abrir Cloud"
4. Offer Cloud row - another `btn-primary` "Abrir Cloud"
5. Why - three bands, each `btn-primary` "Abrir KM0 Cloud"
6. Cloud users - another `btn-primary` "Abrir Cloud"

## Locked decisions
1. **First viewport:** keep exactly **one** primary Open Cloud button in the hero CTA row (`m.hero.ctaPrimary`). Proof surface / QR may stay clickable product proof, but do **not** add another labeled primary pill with the same Open Cloud copy in the first viewport.
2. **Hero live strip:** demote or reword the duplicate `proof.liveCta` so it is not a second identical "Abrir KM0 Cloud" shout; prefer host/register hierarchy already started (`Crear cuenta` secondary stays).
3. **Offer:** only **one** Cloud `btn-primary` in `#services` (pin **or** Cloud row, not both with the same label). The other becomes a text link, or points to a different next step (pricing / tutorial already present).
4. **Why bands:** do **not** give all three bands the same Cloud primary. Diversify by band job (e.g. band 1 → Cloud; band 2 → community; band 3 → pricing), matching existing `secondaryCta` intents where useful. One Cloud primary across the whole Why section is enough.
5. **Cloud users band:** keep at most **one** mid/late-page Cloud primary **or** make the loud action Register and Cloud a quieter text link. Do not stack identical "Abrir Cloud" next to hero + Offer + Why.
6. Primary product language remains Open KM0 Cloud / Abrir KM0 Cloud (locale strings); do not invent a new brand CTA. No dual equal pill clusters. No fake urgency.

## Scope
1. Audit and edit home components: `Hero.astro`, `Services.astro`, `WhyKm0.astro`, `CloudUserStats.astro` (and related styles only if hierarchy needs it).
2. Align i18n in `src/i18n/{es,ca,en,de}.json` for CTA labels / band CTAs / liveCta so four locales stay consistent.
3. Optional short note in `docs/design/landing-conversion-gather.md` or `docs/design/ia-map.md` that Open Cloud primary is **once early + at most one reaffirm**, not every section.
4. Anti-slop + copy skills; `npm run build`; `./scripts/bump-patch-version.sh` once; Hard gate Testing instructions; rename to `UNTESTED-`.

## Out of scope
- Changing Cloud/Mail backends, auth URLs, or WhatsApp invite
- Full visual remodel / new brand tokens
- Pricing, presentation, or meeting pages (home landing only unless a shared string forces a locale touch)
- Re-adding Purpose / manifesto blocks

## Acceptance (hard)
- [ ] First viewport: exactly **one** `btn-primary` with Open Cloud / Abrir KM0 Cloud (hero CTA row)
- [ ] Home DOM has **at most two** `btn-primary` elements whose visible label is Open Cloud / Abrir Cloud / Abrir KM0 Cloud (or locale equivalent); prefer **one** early + optional **one** reaffirm later
- [ ] Offer pin and Cloud row are not both Cloud primary pills with the same label
- [ ] Why bands do not all use Cloud as the primary CTA label
- [ ] Register / pricing / community / tutorial remain reachable without inventing new products
- [ ] No em dash; no mailto; four locales updated; site version bumped
- [ ] Hard gate eye-test (below); soft class-only / curl-200 alone = fail

## High-level instructions for coder
- Read issue #110 and this task; do not paste issue HTML into commits.
- Read `docs/design/anti-slop-doctrine.md`, `docs/design/landing-conversion-gather.md`, skills `km0-anti-slop-design` + `km0-web-copy`.
- Prefer **removing** duplicate primary buttons over restyling them.
- Match existing English routes/identifiers; localized labels only in i18n JSON.
- Deploy verification per `docs/runbook.md` (docker compose, curl `127.0.0.1:9180`).

## Testing instructions

### What changed
- **Hero:** kept one `btn-primary` "Abrir KM0 Cloud" / "Open KM0 Cloud"; proof `liveCta` demoted copy to Entrar / Sign in / Anmelden (text link, not a second identical shout).
- **Offer (`#services`):** pin and Cloud row Cloud actions are text links (`offer__pin-link` / `offer-row__text-link`), not `btn-primary`. Email row still has its own primary.
- **Why:** band 1 keeps one Cloud primary reaffirm; band 2 primary → community; band 3 primary → pricing; Cloud remains as quiet secondary text on bands 2–3.
- **Cloud users:** loud action is Register (`Crear cuenta` / locale); "Abrir Cloud" is the quieter text link.
- **Docs:** `landing-conversion-gather.md` notes Open Cloud primary cadence (once early + at most one reaffirm).
- **Version:** `1.2.1` → `1.2.2`.

### Hard gate protocol (coder evidence; tester re-verifies)
| Item | Value |
|------|-------|
| Reference | Prior home: Open Cloud `btn-primary` in Hero + Offer pin + Offer Cloud row + Why×3 + Cloud users |
| KM0 URL | http://127.0.0.1:9180/ and http://127.0.0.1:9180/en/ |
| Decisive viewport | First viewport + scroll Offer → Why → Cloud users |

**3 parity claims (required):**
1. **One early primary:** First viewport has a single Open Cloud / Abrir KM0 Cloud `btn-primary` in the hero CTA row; proof live strip says Entrar / Sign in (not a second identical Open Cloud pill).
2. **No CTA spam mid-page:** Offer has zero Cloud `btn-primary`; Why has exactly one Cloud primary (band 1). Home DOM Cloud-label `btn-primary` count is **2** (hero + Why band 1).
3. **Section jobs clear:** Why band 2 primary is meetups/community; band 3 is pricing; Cloud users loud CTA is Register; Offer Cloud is text-link only.

**3 anti-slop claims:**
1. No equal dual-pill Cloud + Cloud clusters in hero or Offer.
2. No purple / Inter-only / fake urgency / invented metrics.
3. No new card grids or SaaS eyebrow stacks; hierarchy fixed by removing duplicate primaries.

### Automated / deploy checks (coder ran)
```bash
docker compose build && docker compose up -d
curl -sI http://127.0.0.1:9180/   # 200
curl -sI http://127.0.0.1:9180/en/ # 200
curl -sI http://127.0.0.1:9180/ca/ # 200
curl -sI http://127.0.0.1:9180/de/ # 200
curl -sI http://127.0.0.1:9180/doc/ # 200
```
ES home `btn-primary` labels observed: Abrir KM0 Cloud, Abrir Email, Abrir KM0 Cloud, Ver encuentros, Ver precios, Crear cuenta. Footer: Versión 1.2.2. EN: Open KM0 Cloud ×2, Open Email, See meetups, See pricing, Create account.

### Tester checklist
- [ ] Eye-test hard gate on `/` and `/en/` (decisive viewport above)
- [ ] Confirm Offer pin + Cloud row are not Cloud `btn-primary`
- [ ] Confirm hero proof live CTA is not identical Open Cloud copy
- [ ] Confirm Cloud users primary is Register, Cloud is text link
- [ ] Four locales; no em dash; no mailto; footer patch bumped

## References
- Issue: https://github.com/AMVARA-CONSULTING/km0-web/issues/110
- docs/design/landing-conversion-gather.md
- docs/design/anti-slop-doctrine.md
- docs/design/ia-map.md
- docs/brand-tokens.md
- docs/runbook.md
- Site: https://km0digital.com

## Test report

1. **Date/time (UTC) and log window:** Start `2026-07-19T00:11:07Z`, end `2026-07-19T00:12:30Z`. `docker logs --since 2026-07-19T00:11:07Z km0-web`.
2. **Environment:** Branch `main` (working tree includes #109–#113 stack; footer **1.2.6**). Container `km0-web` already healthy on `127.0.0.1:9180` (no rebuild this step). Playwright eye-test via `mcr.microsoft.com/playwright:v1.49.0-jammy` → `autoagents/.runtime/tester-110/`. Production `https://km0digital.com/` also **200** with **Versión 1.2.6** (polled HEAD+body; ready when 200 + version string present).
3. **What was tested:** Hard gate on `/` and `/en/` (hero → Offer → Why → Cloud users); Cloud `btn-primary` inventory ES/CA/EN/DE; Offer pin/Cloud row not primary; hero liveCta demotion; Cloud users Register primary; em-dash/mailto; HTTP locales + `/doc/`.
4. **Results:**
   - First viewport one Cloud `btn-primary` (hero CTA row): **PASS** - screenshot `01-hero.png` / `05-en-hero.png`; live strip **Entrar** / **Sign in** (not second Open Cloud pill).
   - Home DOM at most two Cloud-label `btn-primary`: **PASS** - ES `["Abrir KM0 Cloud","Abrir KM0 Cloud"]` (hero + Why band 1); EN `Open KM0 Cloud` ×2; CA `Obrir KM0 Cloud` ×2; DE `KM0 Cloud öffnen` ×2. Full primary lists also include Email / meetups / pricing / Register (non-Cloud).
   - Offer pin + Cloud row not both Cloud primary: **PASS** - pin class `offer__pin-link offer__pin-cta` (text link "Abrir Cloud"); Cloud row `offer-row__text-link` "Abrir Cloud"; only Email row is `btn-primary` in Offer (`02-offer.png`).
   - Why bands not all Cloud primary: **PASS** - Why primaries ES: Abrir KM0 Cloud / Ver encuentros / Ver precios (`report.json` whyBtns).
   - Cloud users loud CTA Register: **PASS** - `cloud-proof__cta` = Crear cuenta; quiet `cloud-proof__register` = Abrir Cloud.
   - Register / pricing / community reachable: **PASS** - hero Pricing link; Why bands 2–3; Cloud users Register; Offer tutorial/pricing text links.
   - No em dash / no mailto / four locales / version bumped: **PASS** - check scripts OK; locales HTTP 200; footer Versión/Version **1.2.6** (≥ 1.2.2).
   - Hard gate parity (3): **PASS** - (1) one early primary + demoted liveCta; (2) Offer zero Cloud primary, Why one Cloud primary, DOM Cloud primaries = 2; (3) section jobs: meetups / pricing / Register loud.
   - Hard gate anti-slop (3): **PASS** - no dual Cloud+Cloud pills; no purple/Inter-only/fake urgency; hierarchy via fewer primaries, not new card grids.
5. **Overall: PASS**
6. **URLs:** `http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` `/en/doc/day-0/` `/en/pricing/`; `https://km0digital.com/` (200, Versión 1.2.6). Evidence: `autoagents/.runtime/tester-110/{01-hero,02-offer,03-why,04-cloud-users,05-en-hero}.png` + `report.json`.
7. **Logs:** Access lines for tested paths all **200** in window (HEAD/GET `/` `/ca/` `/en/` `/de/` `/doc/` + Playwright asset GETs). No 5xx observed for those paths.

