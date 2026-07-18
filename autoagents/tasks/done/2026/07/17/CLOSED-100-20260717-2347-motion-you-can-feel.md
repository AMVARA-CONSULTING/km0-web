---
## Closing summary (TOP)

- **What happened:** Craft parity HARD for noticeable scroll motion (masthead compact, Offer pin, reveals) reached CLOSED after tester PASS with Hard gate evidence.
- **What was done:** Shipped human-noticeable masthead compact, Offer sticky pin with stuck Snow/Signal surface, and ~2rem fade/slide reveals; reduced-motion and dark remap honored; version 1.1.128.
- **What was tested:** Hard gate vs Stirling (3 parity + 3 anti-slop + decisive Offer pin mid-scroll screenshots/metrics); locales HTTP 200; reduced-motion; dark sticky without purple glow; no progress/parallax/glass masthead.
- **Why closed:** All acceptance criteria and Hard gate fields passed with narrated, measurable motion (not class-count soft evidence).
- **Closed at (UTC):** 2026-07-18 00:52
---

# FEAT-Task: Motion you can feel (sticky, pin, reveals)

## GitHub Issue
- **Number:** #100
- **Title:** Craft parity HARD: motion you can feel (sticky, pin, reveals)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/100
- **Labels:** enhancement, agent:wip → agent:untested

## Problem / goal
#92 hooks exist but humans do not notice them. Ship scroll craft that is obvious on lg+ with motion on; honor reduced-motion.

## Depends on
#97 preferred.

## Spec
`docs/design/craft-parity-phase.md`; `docs/design/stirling-paint-phase.md` Motion; https://stirling.com/

## High-level instructions for coder
1. Masthead compact/solid obvious within ~1 scroll; Offer pin visibly sticks on lg+; reveals noticeable once.
2. No progress bars / parallax junk / bounce; reduced-motion safe.
3. Light + dark if available.
4. Testing instructions must narrate visible sticky/reveal behavior - `data-reveal` count is not evidence.
5. Build; bump.

## Acceptance (hard)
- Human-narrated scroll behavior in test report; attribute counts alone = FAIL

## What was done
- **Reveals:** `[data-reveal]` hidden from first paint until `.is-visible` (fixes FOUC / invisible motion). Distance **2rem**, duration **820ms**, stagger **90ms**; observer threshold tightened so entrances are seen.
- **Masthead:** taller open state → compact within ~12px scroll: shorter bar, smaller logo/wordmark, Mist hairline + `--masthead-elevate` soft lift (solid Snow, no glass). Works with light/dark Snow remap.
- **Offer pin (lg+):** sticky under masthead; list `min-height: 42rem` for scroll runway; when stuck, Snow panel + Signal left edge + Cloud CTA (`offer__pin--stuck` via scroll/rAF).
- **Reduced-motion:** reveals immediate; chrome/pin surface transitions off; sticky layout may remain.
- Tokens documented in `docs/brand-tokens.md` + paint-phase motion note. Version **1.1.128**.
- Refused: progress bars, parallax, bounce, glass blur nav, purple glow.

## Testing instructions

### Hard gate protocol (required)

1. **Reference URL:** https://stirling.com/ (desktop ≥1024px, motion on) - note sticky chrome confidence while scrolling.
2. **KM0 URL:** `http://127.0.0.1:9180/` (and `/en/`); footer **1.1.128**. Optional dark: header theme toggle → dark, repeat scroll.
3. **Three parity claims** (narrate what you see; class counts alone = FAIL):
   - Within ~1 scroll tick, masthead clearly shortens and gains a Mist hairline + soft lift over the page.
   - In Offer (`#services`) on lg+, left heading + Open Cloud CTA stay pinned under the nav while Cloud/Email rows scroll; stuck state shows a Snow panel with Signal edge.
   - Mid-page bands (Why / Offer rows / Community) rise in once with a clear ~2rem fade/slide (expo), not an invisible opacity wink.
4. **Three anti-slop claims:**
   - No glassmorphic / blurred sticky nav; no purple glow.
   - No scroll progress bar, parallax toys, or bounce easing.
   - No zebra section stripes; continuous Paper + intentional surfaces only.
5. **Decisive viewport:** Desktop home Offer pin mid-scroll (`#services`) with `offer__pin--stuck` Snow panel visible while rows move; screenshot or HTML evidence of that state + narrated masthead compact on first scroll.

### Functional checks

1. `docker compose build && docker compose up -d` (already green for coder); `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` → 200.
2. **Motion on (lg+):** scroll home slowly - narrate masthead compact, Offer pin stuck surface, at least one below-fold reveal entrance.
3. **Reduced-motion:** DevTools → emulate `prefers-reduced-motion: reduce` - reveals visible immediately (no wait); masthead/pin transitions not animated; sticky layout OK.
4. **Dark:** theme toggle dark - same sticky/reveal jobs; no purple glow.
5. Cap check: no new progress bars / bounce / glass `backdrop-filter` on `.masthead`.
6. `docker logs --since 10m km0-web` - no 5xx on smoke paths.
7. Em dash / mailto: checks pass via build hooks.

## References
- docs/design/craft-parity-phase.md
- docs/design/stirling-paint-phase.md
- https://stirling.com/
- docs/brand-tokens.md (Motion)

## Test report

1. **Date/time (UTC):** start 2026-07-18 00:48:56 UTC; end 2026-07-18 00:50:21 UTC. Log window: `docker logs --since 2026-07-18T00:48:56Z km0-web`.
2. **Environment:** branch `main` (synced); `docker compose build && docker compose up -d` (image rebuild, Astro `km0-web@1.1.128`); loopback `http://127.0.0.1:9180/`; production `https://km0digital.com/` polled until HTTP 200. Headless Chromium via existing image `mcr.microsoft.com/playwright:v1.49.1-jammy` (1280×800, lg+). Evidence: `autoagents/.runtime/motion-evidence/` (`report.json` + PNGs).
3. **What was tested:** Hard gate vs Stirling + home motion (masthead compact, Offer pin stuck, reveals), reduced-motion, dark theme sticky, anti-slop caps, locale HTTP smoke, footer version, nginx logs.
4. **Results:**

### Hard gate protocol

| Field | Evidence |
|-------|----------|
| Reference URL | https://stirling.com/ opened same session (WebFetch). Sticky product chrome / scroll confidence is the peer bar for KM0 masthead + Offer pin. |
| KM0 URL(s) | `http://127.0.0.1:9180/en/` (Playwright); footer **Version 1.1.128**. Production `https://km0digital.com/` → 200, footer **Versión 1.1.128** (ready = HTTP 200 + matching semver, no fixed sleep). |
| Parity 1 | Within one scroll tick (`scrollY` 0→40): masthead shortens (bar pad 18.4px→7.2px, logo 37.6px→25.6px), Mist hairline `rgb(216,220,224)`, soft elevate shadow. Classes `masthead--compact` + `html[data-masthead=compact]`. Screenshot `02-masthead-compact.png`. |
| Parity 2 | Mid-Offer (`#services`, `scrollY`≈2845, lg+): `offer__pin--stuck` true; pin `position:sticky` at top 58.4px; Snow panel `background rgb(255,255,255)`; Signal edge `border-left rgb(15,118,110)`; padded surface. Screenshot `03-offer-pin-mid.png` shows left pin (The products + Open Cloud) held while Email row is in view. |
| Parity 3 | Below-fold reveals: pre-visible nodes at opacity 0 with `translateY` 32px (2rem); visible nodes fade to opacity 1 / identity transform. Mid-scroll sample included Why bands still rising vs already-entered Offer header. Not an invisible wink. |
| Anti-slop 1 | Masthead `backdrop-filter: none`; solid Snow/Ink remap, no glass blur. |
| Anti-slop 2 | No scroll progress bar / parallax / bounce toys (`caps.hasProgressBar=false`; no bounce easing in motion CSS). |
| Anti-slop 3 | Continuous Paper canvas + intentional surfaces; no `nth-child` zebra striping in chrome styles. |
| Decisive viewport | `03-offer-pin-mid.png` + `report.json` stuck metrics; masthead compact proven by `01-top.png` vs `02-masthead-compact.png`. |

### Functional criteria

| Criterion | Result | Evidence |
|-----------|--------|----------|
| Build + deploy | PASS | Docker build Astro complete; container healthy; nginx ready |
| HTTP `/` `/ca/` `/en/` `/de/` `/doc/` `/en/doc/day-0/` | PASS | all HEAD 200 |
| Footer 1.1.128 | PASS | ES/EN loopback + production |
| Motion on lg+ (narrated) | PASS | Playwright scroll metrics + screenshots above |
| Reduced-motion | PASS | `reducedMotion: reduce` → all 23 `[data-reveal]` immediately `.is-visible`, opacity 1, reveal/masthead `transition: none` (`04-reduced-motion.png`) |
| Dark sticky/reveal | PASS | Theme toggle → `THEME DARK`; body `rgb(11,18,32)`, masthead Snow remap, compact still true; no purple glow (`05-dark-compact.png`) |
| Cap: no progress/bounce/glass masthead | PASS | see anti-slop |
| Logs no 5xx | PASS | access logs 200 only in window |
| Em dash / mailto | PASS | prebuild hooks OK in docker build |

5. **Overall: PASS**
6. **URLs:** http://127.0.0.1:9180/ , /ca/, /en/, /de/, /doc/, /en/doc/day-0/; https://km0digital.com/; https://stirling.com/ (reference)
7. **Log excerpts:**
```
2026/07/18 00:49:12 [notice] 1#1: start worker process ...
172.21.0.1 - - [18/Jul/2026:00:49:21 +0000] "HEAD / HTTP/1.1" 200
172.21.0.1 - - [18/Jul/2026:00:49:21 +0000] "HEAD /en/ HTTP/1.1" 200
172.21.0.1 - - [18/Jul/2026:00:49:52 +0000] "GET /en/ HTTP/1.1" 200 ... HeadlessChrome/...
```
No 5xx in window.

