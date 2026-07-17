---
## Closing summary (TOP)

- **What happened:** Landing lacked professional motion (reveals + sticky-while-scroll) with reduced-motion safety.
- **What was done:** Upgraded scroll-reveal (expo ease, stagger, once), solid masthead compact state, Offer sticky pin on desktop; motion tokens documented; version bumped.
- **What was tested:** Tester PASS - reveals + prefers-reduced-motion, masthead compact without glass blur, offer sticky pin, reading TOC sticky, HTTP/anti-slop OK.
- **Why closed:** All acceptance criteria passed.
- **Closed at (UTC):** 2026-07-17 23:09
---

# FEAT-Task: Motion system - reveals + sticky-while-scroll

## GitHub Issue
- **Number:** #92
- **Title:** Motion system - reveals + sticky-while-scroll
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/92
- **Labels:** agent:wip → agent:untested

## Problem / goal
Add professional motion: scroll reveals + elements that stay static/sticky while you scroll (header + at least one content pin), Stirling-class polish. Always honor `prefers-reduced-motion`.

## Depends on
Coordinate with #91; can land motion tokens alongside surfaces.

## High-level instructions for coder
1. Upgrade `src/scripts/scroll-reveal.ts` + CSS `.reveal` (expo ease, stagger, once).
2. Sticky Header scroll state (compact/border) - professional, not AI glass nav.
3. One home sticky-while-scroll moment (proof/CTA pin for a scroll range).
4. Document motion tokens in `tokens.css` / brand-tokens.
5. Cap vanity animations. Build; bump; gh #92.

## Acceptance
- Sticky header + pin moment work on desktop
- Reduced-motion safe
- Build green

## What was done
- Motion tokens in `src/styles/tokens.css` (`--duration-reveal`, `--duration-chrome`, `--reveal-distance`, `--reveal-stagger`, `--masthead-offset*`); documented in `docs/brand-tokens.md` and `docs/design/stirling-paint-phase.md`.
- `scroll-reveal.ts`: once-only IntersectionObserver, CSS `--reveal-delay`, sibling auto-stagger, masthead compact + `html[data-masthead]`.
- `.reveal` uses expo ease / distance tokens; reduced-motion shows immediately.
- Masthead: solid Snow (no glass blur), compact padding/logo + Mist hairline when scrolled.
- Home Offer: `offer__pin` sticky column (heading + Cloud CTA) while rows scroll on `lg+`.
- Version **1.1.120**.

## Testing instructions

1. **Build / deploy:** `docker compose build && docker compose up -d` already green (Astro build Complete; container `km0-web` up).
2. **HTTP smoke:** `curl -sI http://127.0.0.1:9180/` and `/ca/`, `/en/`, `/de/`, `/doc/` → expect `200`. Footer shows **1.1.120**.
3. **Reveal system:** Home HTML has many `data-reveal`. CSS contains `.reveal` with `--duration-reveal` / `--reveal-distance` and `@media (prefers-reduced-motion: reduce)`. In a browser (or DevTools), scroll: blocks fade/slide in once; with reduced motion, they are visible immediately (no decorative delay).
4. **Masthead compact:** Fixed `.masthead` uses solid Snow (no `backdrop-filter` on the bar). After scrolling past ~20px, class `masthead--compact` + `html[data-masthead=compact]`: shorter bar, smaller logo, Mist bottom border. Transitions off under reduced motion.
5. **Sticky pin (desktop ≥1024px):** On `/` (and `/en/`), Offer section has `.offer__layout` / `.offer__pin` / `.offer__pin-cta`. Scroll through service rows: left pin (heading + Open Cloud CTA) stays under the masthead then releases at section end. Below `lg`, pin stacks normally (CTA hidden; header above list).
6. **Reading TOC:** `/doc/day-0/` still has `reading-toc--sticky` (unchanged chrome).
7. **Anti-slop:** No purple gradients, no glass nav blur on masthead, no new bounce/orb animations. Em dash / mailto checks OK.
8. **Logs:** `docker logs --since 10m km0-web` - no 5xx on smoke paths.

## References
- docs/design/stirling-paint-phase.md
- https://stirling.com/
- docs/design/anti-slop-doctrine.md
- docs/brand-tokens.md
- Runbook: docs/runbook.md

## Test report

1. **Date/time (UTC):** start 2026-07-17T23:06:07Z; evidence ~23:06:07Z–23:06:09Z; end 2026-07-17T23:06:26Z.
2. **Environment:** branch `main`; same `km0-web` Docker deploy (footer **1.1.122** ≥ 1.1.120); loopback `http://127.0.0.1:9180/`.
3. **What was tested:** HTTP smoke; reveal CSS/tokens + reduced-motion; masthead solid Snow + compact; Offer sticky pin; reading TOC sticky; anti-slop.
4. **Results:**
   - HTTP + footer → **PASS** (200 on `/` `/ca/` `/en/` `/de/` `/doc/`; version 1.1.122).
   - Reveal system → **PASS** (≥24 `data-reveal` on home; `.reveal` uses `--duration-reveal` / `--reveal-distance` / expo ease; `prefers-reduced-motion: reduce` forces opacity 1 / no transition; JS honors reduced motion + sets `masthead--compact` / `data-masthead`).
   - Masthead compact / no glass → **PASS** (`.masthead{background:var(--color-snow)}`; compact Mist border; no `backdrop-filter` on masthead rules; transition none under reduced motion).
   - Sticky pin desktop → **PASS** (`.offer__pin{position:sticky;top:var(--masthead-offset)}`; compact offset; `offer__pin-cta` `inline-flex` at lg; present on `/` and `/en/`).
   - Reading TOC sticky → **PASS** (`reading-toc--sticky` on `/doc/day-0/`).
   - Anti-slop → **PASS** (no purple; no masthead glass blur; mailto/em-dash OK from prior window).
5. **Overall: PASS**
6. **URLs:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/doc/day-0/`.
7. **Logs:** reuse healthy nginx after prior smoke; no 5xx on these paths.
