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
