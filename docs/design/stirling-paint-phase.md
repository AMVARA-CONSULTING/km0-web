# Stirling-inspired site paint (phase)

**Status:** shipped #91–#94; agent doctrine encoded by #95.  
Epic table: `docs/design/remodel-epic.md` (Paint phase).  
Doctrine: `docs/design/anti-slop-doctrine.md` (Paint-phase locks).  
Skill: `.cursor/skills/km0-anti-slop-design/SKILL.md`.

Reference: https://stirling.com/ (+ Features, Pricing, About, Contact). Steal **professional craft and scroll behavior**, not Framer pixels or their purple-free-but-SaaS-generic defaults that conflict with KM0 tokens.

## What Stirling does well

| Pattern | Meaning for KM0 |
|---------|-----------------|
| Continuous professional canvas | No automatic zebra stripes; rare intentional full-bleed bands |
| Scale / argument bands | Full-width story sections with one job + one CTA |
| Sticky chrome | Nav stays usable while scrolling; proof elements can pin briefly |
| Confident motion | Section entrances, subtle sticky/parallax-lite - not random bounce |
| Product-led CTAs | Repeated primary action; secondary quieter |
| Trust without clutter | Real stats / verticals, not icon-tile spam |

## KM0 constraints (do not drop)

- Tokens: Ink / Paper / Signal teal - `docs/brand-tokens.md`
- Anti-slop bans: purple gradients, Inter-only, centered SaaS hero recipe, icon-tile grids, glow orbs, **zebra**
- `prefers-reduced-motion`: every animation off or minimal
- No `mailto:`
- Sacred Cloud user counter

## Motion vocabulary (phase goal)

1. **Scroll reveal** - staggered entrance for section blocks (`[data-reveal]` hidden until `.is-visible`; expo ease, once, auto-stagger). Distance/duration must be human-noticeable (#100).
2. **Sticky while scrolling** - Masthead compact within ~1 scroll (solid Snow + hairline + soft elevate, no glass); home Offer sticky pin (`offer__pin`) for heading + Cloud CTA while rows scroll (`lg+`), with a visible stuck surface (`offer__pin--stuck`); reading TOC sticky unchanged.
3. **Scroll-linked polish** - keep tasteful (2–4 sitewide motions max beyond reveals); no extra progress bars unless a later FEAT asks.
4. **No animation spam** - one orchestrated system in `tokens.css` + `scroll-reveal.ts`.

Shipped in #92; craft feel hardened in #100. Token table: `docs/brand-tokens.md` Motion.

## Surfaces

Home, Header/Footer, Pricing, Presentation, Meeting, Ideas, Security, Legal, Errors - then ensure reading pages inherit professional chrome (measure/TOC may stay on #90).

### Surface utilities (#91)

| Class | Role |
|-------|------|
| (default body / `.page-shell`) | Continuous Paper canvas |
| `.surface-snow` | Rare elevated band |
| `.surface-ink` | Rare proof / dark band |
| `.surface-band` | Optional Mist hairlines on a band |

CSS: `src/styles/tokens.css` (`--surface-*`, `--space-section-*`) + `src/styles/global.css`. See `docs/brand-tokens.md` Surfaces.

### Secondary page chrome (#94)

Shared in `global.css` + views under `src/views/`:

| Pattern | Role |
|---------|------|
| `.page-shell` + sticky masthead | Continuous Paper; nav compact on scroll (#92) |
| `.page-masthead` | Editorial page open (kicker / H1 / intro) |
| `.page-closer` + `.page-closer__actions` | CTA band; primary Cloud (or page job), secondary text link |
| `data-reveal` on mastheads / bands | Light scroll entrance (same system as home) |
| Intentional Snow only | Pricing compare + custom closer; Presentation compare + closer; Ideas form |

No zebra; no `mailto:`; Presentation hero uses Origin motif (not a one-off grid).

## Out of scope

- Cloning Stirling PDF product UI
- Fake Fortune-500-style claims
- Rewriting all blog day prose

## Agent training

Closing reviewers and coders treat paint-phase regressions as auto-fails:

- Zebra / automatic Paper↔Snow stripes
- Motion spam outside the reveal + masthead compact + Offer pin vocabulary
- Secondary pages that invent chrome instead of `.page-shell` / `.page-masthead` / `.page-closer`

Canonical locks live in `docs/design/anti-slop-doctrine.md` and the skill table.
