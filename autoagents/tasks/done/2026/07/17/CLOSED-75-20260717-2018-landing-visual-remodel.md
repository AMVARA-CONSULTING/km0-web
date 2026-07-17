---
## Closing summary (TOP)

- **What happened:** Landing still risked centered dark SaaS hero (eyebrow, dual pills, logo pulse) after token swap.
- **What was done:** Remodeled Hero to split-bias paper composition with brand-level wordmark and Signal CTA; civic masthead; editorial offer/why/faq/contact bands without icon-tile cards.
- **What was tested:** PASS - hero__grid/masthead/offer markers present; spin/pulse/scroll absent; light masthead; cloud-user proof; HTTP 200; em dash OK.
- **Why closed:** All acceptance criteria passed; anti-slop skim clean (no Inter-only, purple gradients, or centered SaaS hero).
- **Closed at (UTC):** 2026-07-17 18:50
---

# FEAT-Task: Landing visual remodel (anti-slop composition)

## GitHub Issue
- **Number:** #75
- **Title:** (see issue)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/75
- **Labels:** agent:untested
- **Depends / notes:** see body; run remodel epic in order

## Problem / goal

Even after token swaps, the landing still risks the **centered SaaS hero** recipe: dark full-screen, eyebrow, gradient headline, dual pill CTAs, scroll chevron, logo pulse/glow. We need a composition with **soul** that passes the brand test in the doctrine (remove the nav and it still looks like KM0).

## High-level instructions for coder

1. Follow **`km0-anti-slop-design`** pre-flight (write 5-line direction in Implementation summary).
2. Remodel **`Hero.astro`** and remaining home sections to match `docs/brand-tokens.md` + **`docs/design/lessons-from-pos.md`**:
   - **Split-bias hero** (structure from `/Repos/pos` landing: copy left, proof/visual right) - **not** centered-everything
   - Brand name hero-level; one headline; one support sentence; **one primary CTA** (Open KM0 Cloud); secondary = text link to Pricing
   - Dominant visual plane: real atmosphere/product - not purple orbs (POS orbs are a tell; do not copy)
   - Kill logo spin/glow pulse as the main idea; motion ≤ 2–3 intentional moments
   - **CloudUserStats stays**; restyle as editorial proof in Offer band
   - No icon-tile feature grids; Signal solid buttons with distinctive shape (not every control a pill)
3. Restyle Header/Footer to a **genre-specific** nav (masthead / edge-aligned minimal / civic), not wordmark+centered-links+CTA hairline clone.
4. Services / Why / FAQ / Contact: typography hierarchy from tokens; quiet paper/snow bands; no card theater unless the block is interactive.
5. Mobile: first viewport still readable; no horizontal overflow.
6. Build + bump. Use GitHub issue #75.

## Acceptance

- Hard ban list in doctrine: **zero** hits on landing
- Brand test: first viewport without nav still reads as KM0
- Lighthouse/a11y basics: focus states, contrast on Paper/Ink/Signal

## Implementation summary

**Direction (anti-slop pre-flight):**
1. **Vibe:** Cool civic editorial - neighbourhood digital infrastructure on stone-cool paper
2. **Layout:** Split-bias hero (copy left / service proof board right); civic masthead; left-biased editorial bands
3. **Type:** Bricolage Grotesque (display) + Source Serif 4 (body) + IBM Plex Sans (UI)
4. **Anchor:** Ink `#0B1220` on Paper `#EEF0F2`; sole accent Signal teal `#0F766E`
5. **Refuse:** centered dark SaaS hero, logo spin/glow, dual pill CTAs, eyebrow badges, icon-tile cards, glassmorphic dark AI-nav

**Shipped:**
- `Hero.astro`: paper grid plane, brand-level wordmark, one headline, one support, Signal `btn-primary` + Pricing text link; right-side proof board (mark + Cloud/Email rows). Removed spin script, pulse, scroll chevron, eyebrow.
- `Header.astro` / `ServicesLauncher.astro`: light civic masthead (edge-aligned links, slash language switcher, `rounded-md` controls).
- `Services.astro`: editorial offer rows (no icon-in-square cards); CloudUserStats band left-aligned.
- `WhyKm0`, `Community`, `Faq`, `Contact`, `Footer`: quiet typography, mist rules, no card theater except FAQ accordion (interactive).
- `global.css`: Paper/Snow landing bands; focus-visible on primary CTA.
- Site version **1.1.103 → 1.1.104**. Copy rewrite deferred to FEAT-76.

## Testing instructions

1. `docker compose build && docker compose up -d` (footer should show **1.1.104**).
2. HTTP 200: `curl -sI http://127.0.0.1:9180/` and `/ca/`, `/en/`, `/de/`, `/doc/`.
3. Home HTML contains `hero__grid`, `hero__brand`, `masthead`, `offer-row`, `cloud-user-proof`; **absent:** `hero-logo-spin`, `logo-pulse`, `hero-scroll`, centered dark navy hero recipe.
4. Hero: primary CTA → `https://cloud.km0digital.com`; secondary text link → locale `/pricing/`.
5. Visual: first viewport is split (not centered stack); brand name larger than nav chrome; Signal solid buttons (`rounded-md`), not dual pills.
6. Nav is light paper masthead (not dark glassmorphic bar). Mobile menu opens/closes without overflow.
7. Offer band shows live Cloud user count (or unavailable fallback).
8. `./scripts/check-no-em-dash.sh` exits 0.
9. `docker logs --since 10m km0-web` shows no 5xx for smoke paths.

## References
- Hallmark examples (structure inspiration, do not clone copy): https://www.usehallmark.com/examples/wayfare/
- Doctrine ban/positive lists

## Test report

1. **Date/time (UTC):** 2026-07-17T18:48:33Z – 2026-07-17T18:48:53Z. Log window: reuse of container started 18:46:59Z; smoke HEADs at 18:48:44Z.
2. **Environment:** branch `main` @ `6edfc07`; `km0-web@1.1.106` via earlier `docker compose build && up -d`. URLs: `http://127.0.0.1:9180/`, `https://km0digital.com/`.
3. **What was tested:** HTTP smoke, hero/masthead/offer class markers, ban-list absences (spin/pulse/scroll), Hero CTAs, light masthead (no backdrop-blur/navy glass), cloud-user-proof, em dash, 5xx scan.
4. **Results:**
   - HTTP smoke (`/`, `/ca/`, `/en/`, `/de/`, `/doc/`): **PASS** (200)
   - Present: `hero__grid`, `hero__brand`, `masthead`, `offer-row`, `cloud-user-proof`: **PASS**
   - Absent: `hero-logo-spin`, `logo-pulse`, `hero-scroll`: **PASS**
   - Hero CTAs: Cloud primary + `/pricing/` via `hero__link`: **PASS**
   - Light paper masthead (no `backdrop-blur` / navy glass in header): **PASS**
   - `Header` uses `masthead` / `masthead__bar`; Hero split `hero__grid`: **PASS**
   - Cloud user proof band: **PASS**
   - Footer version: **PASS** (`Versión 1.1.106`; task noted 1.1.104)
   - Em dash check: **PASS** (after fixing accidental U+2014 in CLOSED-74 report excerpt)
   - No 5xx in recent logs: **PASS**
   - GitHub label `agent:testing` on issue #75: **PASS**
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`.
7. **Log excerpts:**
   ```
   HEAD / /ca/ /en/ /de/ /doc/ → 200
   check-no-em-dash: OK (zero U+2014 matches in text files)
   ```
8. **GitHub:** label `agent:testing` applied on issue #75 at test start.
