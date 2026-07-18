# FEAT-Task: Landing Stirling HARD visual parity

## GitHub Issue
- **Number:** #97
- **Title:** Craft parity HARD: landing must win side-by-side vs stirling.com
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/97
- **Labels:** enhancement, agent:wip

## Problem / goal
#93 soft-passed on section order. Landing must win a human side-by-side with https://stirling.com/ for promise loudness, scale bands, CTA rhythm, continuous canvas. Class checklists = fail.

## Depends on
#96 preferred first (dark must not break landing).

## Spec
`docs/design/craft-parity-phase.md` Hard gate protocol. Prior paint: `docs/design/stirling-paint-phase.md`.

## High-level instructions for coder
1. Open Stirling home + KM0 home. Rebuild until three non-dev-visible parity claims are true.
2. Promise loudness in first viewport; scale/argument bands (not equal feature strips); CTA rhythm (Cloud primary); sacred counter kept.
3. No Stirling copy/palette clone; no zebra/icon-tiles/purple/Inter-only/centered SaaS hero.
4. Light + dark both must hold if dark shipped.
5. Build; bump; Testing instructions with full Hard gate protocol.

## Acceptance (hard)
- Tester writes 3 parity + 3 anti-slop claims after opening Stirling
- Soft class-only evidence = FAIL (tester + closing)

## Implementation notes (coder)
- Hero promise shortened to ownership punch (es/ca/en/de): e.g. EN “Your data. Your control.” with EU/price in support line; display size raised; accent on second line.
- Landing order: Hero → Why (scale) → Offer → Cloud user Ink proof → Community → FAQ → Contact (Stirling: promise → volume stories → product).
- Why bands rebuilt as full-width scale stories (large display titles, generous pad, one Snow middle band only); every band primary CTA = Open KM0 Cloud; secondary quieter for meetups/pricing.
- Offer: Cloud `offer-row--lead` vs Email `offer-row--quiet` (not equal strips).
- Dark-safe mist/on-ink color-mix in hero proof + cloud proof labels.
- Site version bumped to **1.1.125**. Docker rebuild healthy; locales `/` `/en/` `/ca/` `/de/` `/doc/` 200.

## Testing instructions

### Hard gate protocol

1. **Reference URL(s)** (same session):
   - https://stirling.com/ (home: “Your PDFs. Your control.” + volume tiers + repeated Get started)

2. **KM0 URL(s)** (after `docker compose build && docker compose up -d`):
   - http://127.0.0.1:9180/en/
   - http://127.0.0.1:9180/ (ES)
   - Optional dark: toggle Theme → Dark on `/en/` and confirm bands/hero still hold

3. **Three parity claims** (non-dev visible; open Stirling beside KM0):
   - **Promise loudness:** First viewport reads a short ownership headline (“Your data. / Your control.”) at hero-display scale, brand above it, one support line with EU/price, one primary Cloud CTA + quieter Pricing link, product proof panel on the right - same confidence shape as Stirling’s five-word promise, not a soft descriptive subtitle.
   - **Scale / argument bands:** Immediately under the hero, three stacked full-width stories (Person / Community / Organisation) with volume-tier energy: large titles, body + fact, primary **Open KM0 Cloud** on each band; middle band is an intentional Snow elevation (not zebra). Scroll feels like Stirling’s under-10k / 10k–1M / 1M+ stories, not a flat feature list.
   - **CTA rhythm + continuous canvas:** Cloud primary repeats at hero, every scale band, Offer pin/Cloud row, and Ink user-counter band; Pricing/meetups stay text-secondary. Canvas stays Paper with earned Ink proof + one Snow scale band + Contact Snow - no automatic Paper/Snow striping while scrolling.

4. **Three anti-slop claims** (what was refused):
   - No icon-tile equal feature grids; Offer is Cloud-led + quieter Email, not three equal cards.
   - No purple/indigo gradients, Inter-only stack, or centered SaaS hero recipe (eyebrow pill + dual pills + chevron).
   - No Stirling copy/palette clone (“Your PDFs…”, Framer purple-free SaaS chrome); KM0 voice + Ink/Paper/Signal tokens only.

5. **Decisive viewport evidence**:
   - Path: `/en/` first viewport + first scale band after one scroll.
   - Look for: H1 “Your data.” / “Your control.”; brand “Kilometer 0 Digital”; proof panel with plan/files; then Why band “Start at home, without Big Tech” with **Open KM0 Cloud** button; footer Version **1.1.125**.
   - Class-list-only evidence (e.g. “has `why-band`”) without side-by-side narration = **FAIL**.

### Smoke checks
```bash
curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/de/ http://127.0.0.1:9180/doc/
curl -s http://127.0.0.1:9180/en/ | grep -E 'Your data\.|Your control\.|Start at home|1\.1\.125'
docker logs --since 10m km0-web
```

### Browser checklist
- [ ] Stirling home open beside `/en/` - three parity claims written by tester
- [ ] Scale bands visibly larger than old list rows; Cloud CTA on all three
- [ ] Light + Dark (#96 toggle) both keep promise/bands readable
- [ ] Sacred Cloud user counter still present after Offer
- [ ] No mailto; no em dash; anti-slop holds

## References
- https://stirling.com/
- docs/design/craft-parity-phase.md
- docs/design/anti-slop-doctrine.md
