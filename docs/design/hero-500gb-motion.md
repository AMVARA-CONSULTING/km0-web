# Hero “500 GB” motion (research brief)

**Status:** queued as FEAT (issue linked from remodel / autoagents).  
**Surface:** home hero product proof - plan name **500 GB** + storage meter (`Hero.astro`).  
**Not:** fake Fortune-500 counters; not sitewide animation spam.

## Current state (why it feels weak)

- Plan label is static text (`proof.planName`).
- Meter is a thin bar with `scaleX` fill (~0.9s) to a fixed **28%** width - easy to miss, reads as a leftover progress stub, not a capacity story.
- Reduced-motion already disables the meter animation (good baseline).

## Best-practice synthesis (2025–2026)

Sources consulted: [Motion budget for fast sites (2026)](https://www.monotonomo.com/journal/motion-budget-fast-sites-2026/), microinteraction guides (purpose / 100–400ms), [web.dev prefers-reduced-motion](https://web.dev/articles/prefers-reduced-motion), accessible counter patterns.

| Rule | Implication for KM0 |
|------|---------------------|
| **Purpose first** | Motion must say “generous EU storage / plan clarity,” not decorate |
| **Motion budget** | Cap this hero moment so first-viewport animations stay lean (single anim ≤ ~500ms; do not stack long loops) |
| **Compositor-only** | Prefer `transform` / `opacity` (and carefully scoped width on the meter fill if needed) - no layout thrash |
| **Once** | Play on enter / first reveal; do not re-trigger on every scroll |
| **Reduced motion** | Show final “500 GB” + final meter state immediately; no count-up, no sliding fill |
| **A11y for numbers** | Screen readers get the final value; avoid announcing every tick. Use `tabular-nums` if digits animate |
| **No vanity metrics** | Do not invent “99.9%” or fake usage %; capacity story must stay honest |
| **Brand** | Dark civic + Signal; no glow, bounce, confetti, or purple neon |

## Recommended direction (coder picks one coherent package)

Ship **both** of these as one composed moment (not five competing tricks):

1. **Capacity readout** - Make **500 GB** the hero of the plan row: weight/size hierarchy + a short, once-only entrance (opacity/transform and/or accessible count-up 0→500 with unit `GB` stable). Final value always in DOM for AT.
2. **Storage meter as abundance** - Retune fill so it communicates “roomy plan” (e.g. fill settles at a calm mid/high band with expo ease), timed with the readout. Label/meta stays Hetzner · Falkenstein quiet.

Optional polish (only if budget allows): subtle Signal tick on settle - no infinite pulse.

## Explicit bans

- Infinite looping “breathing” bars or number flicker
- Parallax / 3D flip of the whole proof card for this FEAT
- Duration > 800ms for this moment alone
- JS libraries heavier than needed (prefer CSS + tiny script aligned with `scroll-reveal` / existing tokens)
- Soft pass: “animation property exists” without a human noticing the 500 GB story

## Hard gate (tester)

Narrate what happens to **500 GB** and the meter on first load (`/` + one locale) with motion on; confirm reduced-motion shows finals instantly; confirm no purple/glow/spam.
