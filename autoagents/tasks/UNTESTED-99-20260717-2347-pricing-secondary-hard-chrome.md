# FEAT-Task: Pricing + secondary HARD chrome vs Stirling

## GitHub Issue
- **Number:** #99
- **Title:** Craft parity HARD: pricing + secondary pages vs Stirling product chrome
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/99
- **Labels:** enhancement, agent:wip

## Problem / goal
#94 scaffolding is not enough. Pricing and secondary pages must feel product-priced and professionally calm in a Stirling side-by-side.

## Depends on
#97 preferred.

## Spec
`docs/design/craft-parity-phase.md`; Stirling Pricing; paint secondary chrome patterns.

## High-level instructions for coder
1. Repaint `/pricing/` as a real pricing argument (plans/paths, Cloud CTA, calm compare - no card-grid slop).
2. Presentation, Meeting, Ideas, Security, Legal, errors: intentional chrome under light/dark; shared patterns not one-offs.
3. Type/spacing peer energy under KM0 fonts; no mailto; Hard gate vs Stirling Pricing + one secondary.
4. Build; bump; Hard gate protocol required.

## Acceptance (hard)
- Side-by-side claims required; "has page-masthead" alone = FAIL

## Implementation notes (coder)
- Pricing rebuilt as Stirling-style argument: loud masthead (“One public price.”) + capacity/price proof; **Choose a path** with Cloud lead / Email quiet / Custom (editorial columns with hairlines, Cloud elevated Snow, primary Cloud CTA, quieter text CTAs - not icon-tile cards).
- Calm market compare Snow band kept; why + includes share one section; closer Cloud-primary + contact secondary.
- Shared secondary chrome: `.heading-page` peer H1 scale, `.page-meta`, tighter masthead rhythm in `global.css`; Presentation/Meeting/Ideas/Security/Legal/Errors use it; Meeting gains Snow `page-closer`.
- i18n paths + meeting closer + ideas eyebrow in es/ca/en/de; types updated.
- Site version bumped to **1.1.127**. Docker rebuild healthy; locales and secondary routes 200.

## Testing instructions

### Hard gate protocol

1. **Reference URL(s)** (same session):
   - https://stirling.com/pricing (Editor / Processor / Enterprise plan paths + repeated product CTA)
   - Optional About-energy peer: https://stirling.com/ (or About if open) for secondary calm

2. **KM0 URL(s)** (after `docker compose build && docker compose up -d`):
   - http://127.0.0.1:9180/en/pricing/
   - Secondary: http://127.0.0.1:9180/en/presentation/ (About-like) and/or http://127.0.0.1:9180/en/meeting/
   - Optional dark: Theme → Dark on `/en/pricing/` and `/en/meeting/` - paths, table, mastheads stay readable (no purple glow)

3. **Three parity claims** (non-dev visible; open Stirling Pricing beside KM0 pricing):
   - **Plan paths as the argument:** Under the masthead, three editorial paths (Cloud / Email / Custom) read like Stirling’s Editor / Processor / Enterprise: name, price line, short body, feature list, CTA - Cloud is the lead (Snow elevation + primary button); Email and Custom stay quieter text CTAs. Not a thin FAQ with one button.
   - **Promise + price proof loudness:** First viewport shows kicker “Pricing”, H1 “One public price.”, one support line, primary **Open KM0 Cloud**, and a dominant 500 GB / €1.99 proof - same confidence shape as Stirling’s Pricing title + plan price columns.
   - **Calm compare + closer rhythm:** Snow compare band is a quiet table (cost-per-TB reading), not a sales scoreboard; page closes with Cloud primary + proposal secondary, matching Stirling’s repeated product CTA energy without card-grid slop.

4. **Three anti-slop claims** (what was refused):
   - No equal icon-tile / rounded shadow pricing cards; paths use hairline editorial columns with Cloud lead bias.
   - No purple/indigo gradients, Inter-only stack, or zebra Paper/Snow striping on secondary pages.
   - No mailto; Contact/proposal uses on-site contact hash; dark is optional civic remap, not dark-first or glow lab.

5. **Decisive viewport evidence**:
   - Path: `/en/pricing/` first viewport + “Choose a path” band (and one secondary, e.g. `/en/presentation/` masthead with `.heading-page`).
   - Look for: H1 “One public price.”; 500 GB Signal proof; Cloud path with **Open KM0 Cloud** button; “Calm market compare”; footer Version **1.1.127**.
   - Class-list-only evidence (e.g. “has `page-masthead`”) without side-by-side narration = **FAIL**.

### Smoke checks
```bash
curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/de/ http://127.0.0.1:9180/doc/
curl -sI http://127.0.0.1:9180/en/pricing/ http://127.0.0.1:9180/en/presentation/ http://127.0.0.1:9180/en/meeting/ http://127.0.0.1:9180/en/ideas/ http://127.0.0.1:9180/en/security/ http://127.0.0.1:9180/en/legal/
curl -s http://127.0.0.1:9180/en/pricing/ | grep -E 'One public price\.|Choose a path|Calm market compare|1\.1\.127'
docker logs --since 10m km0-web
```

### Browser checklist
- [ ] Stirling Pricing open beside `/en/pricing/` - three parity claims written by tester
- [ ] Path band: Cloud lead vs quieter Email/Custom (not equal cards)
- [ ] Presentation or Meeting masthead feels peer (large H1 + quiet intro + closer where present)
- [ ] Light + Dark both keep pricing paths and secondary mastheads readable
- [ ] No mailto; no em dash; anti-slop holds

## References
- https://stirling.com/pricing
- docs/design/craft-parity-phase.md
- docs/design/stirling-paint-phase.md
