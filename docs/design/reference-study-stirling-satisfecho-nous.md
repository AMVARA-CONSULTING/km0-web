# Reference study: Stirling · Satisfecho · Nous (phase-2 remodel)

Sources reviewed 2026-07-17 (home + key subpages). Steal **structure and discipline**, not pixels or fonts.

## Stirling (https://stirling.com/)

**What works**

- **One promise, loud:** “Your PDFs. Your control.” Outcome + ownership in five words.
- **Scale argument instead of feature-card grid:** tiers by volume (under 10k / 10k–1M / 1M+) - each band is a mini-landing with one CTA.
- **Infrastructure trust without purple SaaS:** “Run on any infrastructure”, air-gapped, vendor lock-in called out.
- **Proof that feels earned:** Fortune 500 %, 55K companies, named verticals (gov, health, legal) - not fake “10× faster”.
- **About page as story arc:** Origin → Architecture → Standard (narrative, not slogan stack).
- **Rhythm:** continuous canvas + intentional full-bleed bands; **not** automatic white/gray zebra.

**KM0 takeaways**

- Replace zebra with intentional surfaces only.
- Offer/Why can argue by **audience scale** (person / family-coop / org) instead of icon tiles.
- Keep real proof (Cloud user counter); add verticals only if true.

## Satisfecho / POS (https://satisfecho.de/)

**What works**

- **Live product proof in the first screen:** QR → real demo menu. Visitors *do* something.
- **Features by job-to-be-done:** Guest / Operations / Business / Platform - scannable, not 12 equal cards.
- **Primary CTA = product action** (open demo / register), secondary is quieter.
- Token-first styling and split hero (already in `lessons-from-pos.md`).

**KM0 takeaways**

- Hero visual must become **usable proof** (Cloud panel mock with real price row is a start; evolve toward something people recognize as the product).
- Tutorials / pricing / services should group by audience job, Satisfecho-style.
- Do **not** copy Inter + cream + terracotta orbs.

## Nous Research (https://nousresearch.com/)

**What works**

- **Personality as system:** monospaced “OUTPUT / SEED” chrome, dense mission blocks, blog as a first-class surface.
- **Continuous dark field** with type hierarchy - no zebra stripes.
- **Brand mark with attitude** (NOUS stamp / underground imprint) - the mark is memorable at favicon size.
- Blog index is editorial list energy, not SaaS card grid.

**KM0 takeaways**

- Invent a **KM0 signature motif** (kilómetro-0 / pin / signal) that survives 16×16 favicon - current pin SVG is too generic.
- Allow one “terminal/civic” accent voice (meta labels, mono for data) without going full dark-mode AI lab.
- Blog and longform keep calm measure; personality lives in mark + rhythm, not in more sections.

## Anti-patterns still visible on KM0 after phase 1

1. **Zebra:** `main:has(#home) > section…nth-child(odd/even)` forces Snow/Paper stripes (`src/styles/global.css`).
2. **Logo/favicon:** same minimal pin in teal - weak brand test, weak tab icon (also user idea #72).
3. **Hero proof** still logo-centric more than product-centric.
4. **Section surfaces** lack intentional full-bleed moments (Stirling-style argument bands).

## Phase-2 FEAT themes

| Theme | Issue focus |
|-------|-------------|
| Kill zebra | Explicit section surfaces; continuous Paper default |
| Mark system | Logo + favicon + apple-touch + OG |
| Hero proof 2.0 | Product-recognizable visual; Satisfecho energy |
| Audience/scale bands | Stirling-style argument without fake stats |
| Signature motif | Subtle KM0 atmosphere (not orbs, not purple) |
| Doctrine update | Encode this study into agent training |

See `docs/design/remodel-epic.md` for the live queue.
