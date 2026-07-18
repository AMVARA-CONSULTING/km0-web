# Pricing masthead “500 GB” craft

**Status:** brief for NEW task (2026-07-18).  
**Surface:** `/pricing/` first viewport capacity readout (`.pricing-hero-stat` in `src/views/Pricing.astro`).  
**Not:** rewriting the whole pricing page, compare table, or path cards (except tiny hierarchy tweaks if the masthead needs them).

## Current state (why it felt flat)

- Was a single string `"500 GB"` in one Signal display span.
- No number / unit split, no abundance cue, no once-only entrance.
- Price (`€1.99` / `/month`) sat below in muted Plex; capacity did not feel like the hero of the promise.
- Home already ships a stronger capacity moment (`Hero.astro` + `hero-capacity.ts`). Pricing now peers that craft.

## Shipped craft (2026-07-18)

1. **Typographic hierarchy** - Display **500** + quieter Signal **GB** (`heroPrice.capacity` / `unit`).
2. **Abundance cue** - Capacity rail at `--hero-meter-fill` (0.72) + quiet Hetzner · Falkenstein meta.
3. **Once-only motion** - Count-up + opacity settle via shared `hero-capacity.ts`; reduced-motion finals immediate.

## Goal

Make **500 GB** the loud, honest capacity story beside “One public price.” so a visitor opening `/pricing/` next to Stirling-style pricing confidence (or KM0 home proof) feels plan abundance, not a decorative label.

## Recommended craft package (one composition)

Ship **one** composed masthead moment (not five tricks):

1. **Typographic hierarchy** - Split capacity into display **500** + quieter **GB** (i18n: separate keys or reuse home `proof.planCapacity` / `planUnit`). Keep `aria-label` as the full honest sentence.
2. **Abundance cue** - A calm storage meter or capacity rail under the digits (same honesty rules as hero: no fake “28% used”; settle at a roomy mid/high band that reads as plan size). Optional quiet Hetzner / EU meta line.
3. **Once-only motion** - Reuse or thin-adapt hero capacity tokens (`--duration-hero-capacity`, expo ease). Count-up 0→500 **or** opacity/transform settle; `prefers-reduced-motion` shows finals immediately. Cap ≤ ~500–800ms; no loops.

Price stays secondary under capacity (or tightly paired) so Cloud CTA + heading still win the left column.

## Explicit bans

- Purple / glow / confetti / bouncing digits
- Fake usage percentages or Fortune-500 vanity stats
- Equal three-card SaaS pricing tiles as the “fix” for this FEAT
- Infinite breathing meters; motion libraries beyond existing reveal/capacity patterns
- Soft pass: “font-size increased” without a human noticing capacity as the story

## Hard gate

Open `/en/pricing/` (and one other locale) beside `https://km0digital.com/en/` hero proof. Narrate 3 parity + 3 anti-slop claims about the **500 GB** masthead moment. Class-only / curl-200 = fail.

## References

- `docs/design/hero-500gb-motion.md` (reuse vocabulary, do not duplicate bugs)
- `docs/design/craft-parity-phase.md` (pricing secondary hard chrome)
- `docs/brand-tokens.md` (display type, Signal, motion tokens)
- `docs/design/anti-slop-doctrine.md`
