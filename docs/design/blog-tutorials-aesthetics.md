# Blog & tutorials aesthetics  -  research notes (2026-07-17)

KM0 `/doc/` and `/tutorials/` still feel dull after phase-1 chrome. Goal: pages people **want** to finish reading, aligned with anti-slop + civic editorial tokens.

## What good longform does (evidence)

| Practice | Target | Sources |
|----------|--------|---------|
| Measure | ~72–78ch for KM0 tech reading (`max-width: ~75ch`); classic prose often 60–70ch | Baymard / Bringhurst; code-friendly upper band |
| Body size | 18–21px desktop; leading ~1.6–1.7 | NN/g + Practical Typography consensus |
| Hierarchy | Modular scale (~1.25); more space **above** H2 than below | Designer Daily long-form typography |
| Meta | Date / reading time quiet; never compete with title | Editorial sites, Remarque |
| Index | Title-led list (Nous blog energy), not SaaS cards | https://nousresearch.com/blog |
| TOC | Sticky, light, only when useful; not a bordered card slab | Calm docs (Linear/Stripe docs feel) |
| Space | Generous paragraph gaps; full-bleed page, narrow text | Measure ≠ container width |
| Mobile | Phone-first proof; TOC collapse without ugly chrome | Industry practice |

## Reference vibes (steal structure, not pixels)

- **Nous blog:** huge titles, short dek, continuous field, no card grid.
- **Stirling docs/marketing:** quiet craft, clear hierarchy, intentional bands.
- **Hallmark editorial examples:** biased layout, type as the hero.
- **KM0 tokens:** Paper / Ink / Signal; Bricolage + Source Serif 4 + IBM Plex Sans.

## Current KM0 pain (code)

- Index is a flat hairline list  -  correct direction, but **under-designed** (weak masthead, weak hover/focus, little typographic drama).
- Article chrome still carries **TOC-in-a-box** (mobile details border/snow) and marketing `section-pad` density.
- Legacy **`doc-block` HTML kits** in most `day-*` posts fight the reading measure and look like admin docs.
- Tutorials share chrome but platform badges feel like leftover SaaS chips.
- Code/pre/blockquote/table styles likely still “utility default,” not editorial.

## Design direction for the FEAT

1. **Index:** magazine masthead + title-first rows; latest post can be larger; Signal hover underline; no cards/shadows.
2. **Article:** typography-first shell  -  large display title, quiet meta, body 18–21px / 1.65, ~75ch; TOC as whisper sidebar with unmistakable link affordance (Signal + underline), no heavy borders.
3. **Shared beauty system:** one `.doc-prose` scale for blog + tutorials (headings, lists, code, notes).
4. **Anti-slop:** no purple, no Inter-only, no equal card grids, no glow, no zebra inside articles.
5. **Content:** do not rewrite all historical days here; improve CSS compatibility for legacy kits + keep day-0 Markdown pilot looking best.

## Out of scope here

- Full prose rewrite of day-1…N (separate epic).
- Changing Cloud/Email apps.


## Measure + TOC affordance (shipped)

- **Wider technical reading:** article column + prose use **`max-w-[75ch]`** (target 72–78ch). Shell `max-w-7xl`; TOC layout middle track `48rem`. Do not use full viewport width for body text.
- **TOC clickability (NN/G):** `.reading-toc-link` (and mobile summary) use Signal color + underline; hover / `:focus-visible` / `aria-current`. Sticky rail + `scroll-mt-28` on headings.
