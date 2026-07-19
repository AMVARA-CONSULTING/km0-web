---
name: km0-anti-slop-design
description: >-
  Enforce non-generic frontend for km0-web. Use when building or remodeling
  pages, components, tokens, Tailwind classes, heroes, blogs, or any UI that
  risks AI/Tailwind slop (Inter, purple gradients, centered SaaS layouts,
  zebra bands, generic map-pin favicons).
---

# KM0 anti-slop design

Read **`docs/design/anti-slop-doctrine.md`** first. Then **`docs/brand-tokens.md`**, **`docs/design/hallmark-adaptations.md`**, **`docs/design/reference-study-stirling-satisfecho-nous.md`**, **`docs/design/stirling-paint-phase.md`**, **`docs/design/craft-parity-phase.md`** (when the FEAT cites craft / HARD parity), and **`docs/design/lessons-from-pos.md`**.

## When this skill applies

Any change to `src/components/`, `src/views/`, `src/layouts/`, `src/styles/`, `tailwind.config.mjs`, marketing pages, blog/tutorial chrome, brand assets, or visual tokens.

## Pre-flight (mandatory)

Before writing UI code, state in 5 lines:

1. **Vibe** (one sentence, KM0-specific)
2. **Layout archetype** (e.g. split-bias, editorial column, departures-board, masthead - not “centered SaaS”)
3. **Type pair** (display + body; never Inter-only)
4. **Anchor hue + single accent** (no multi-stop purple chains)
5. **What you refuse** (2–3 slop tells you will not ship)

If you cannot fill those five lines from brand docs, **stop** and ask - do not invent another purple gradient.

## Pre-emit self-critique (Hallmark-adapted)

After the five-line pre-flight, score the planned output **1-5** on **P**hilosophy, **H**ierarchy, **E**xecution, **S**pecificity, **R**estraint, **V**ariety (see `docs/design/hallmark-adaptations.md`). Any axis below **3** → revise before shipping. Record one line in the task Implementation summary (`Pre-emit: P# H# E# S# R# V#`). Do **not** put Hallmark stamp comments in production CSS. Variety means avoiding the generic AI section fingerprint **inside** locked KM0 tokens - never rotate a theme catalog.

## Phase-2 locks (auto-fail if ignored)

From the Stirling / Satisfecho / Nous study and remodel #80–#84:

| Lock | Do | Do not |
|------|----|--------|
| Rhythm | Continuous Paper; explicit surface opt-in | `nth-child` zebra / automatic Snow↔Paper stripes |
| Mark | Origin stamp (`public/brand/logo.svg`, full-bleed `favicon.svg`) | Generic map-pin, padded favicon, purple gradient pin |
| Hero | Product-recognizable proof + quiet CTA hierarchy | Logo-only first viewport theater |
| Bands | Audience/scale argument when needed | Equal icon-tile feature grids |
| Atmosphere | `.km0-motif` / `--origin` sparingly (hero + ≤2); optional ambient SE grid drift (16s) | Glow orbs, purple bloom, zebra as “texture”, busy scrolling grids |

## Paint-phase locks (auto-fail if ignored)

From `docs/design/stirling-paint-phase.md` and remodel #91–#94 (encoded #95):

| Lock | Do | Do not |
|------|----|--------|
| Surfaces | `.surface-snow` / `.surface-ink` / `.surface-band` when a band is earned; `.page-shell` continuous Paper | Zebra via `nth-child` or decorative alternating backgrounds |
| Reveal | `[data-reveal]` once via `scroll-reveal.ts`; expo ease; auto-stagger | Bounce, multi-lib animation kits, reveal on every tiny element |
| Sticky | Masthead compact on scroll (Snow + hairline); Offer `offer__pin` on `lg+`; reading TOC sticky as chrome | Glassmorphic sticky AI-nav; extra sticky gadgets / progress bars |
| Motion budget | ≤3 sitewide moments beyond quiet chrome; honor `prefers-reduced-motion` | Parallax spam, scroll toys, animation without a job |
| Secondary chrome | `.page-masthead` + `.page-closer` shared patterns; light reveals | One-off page grids that fight Origin motif / tokens |

Surface + motion token tables: `docs/brand-tokens.md` (Surfaces, Motion). CSS: `src/styles/tokens.css`, `src/styles/global.css`.

## Craft-parity locks (auto-fail if ignored)

From `docs/design/craft-parity-phase.md` and remodel #96–#100 (encoded #101). Soft class-only / curl-200 / “no purple” passes are **FAIL**.

| Lock | Do | Do not |
|------|----|--------|
| Hard gate protocol | Document reference URL(s), KM0 URL(s), 3 parity claims, 3 anti-slop claims, decisive viewport evidence | Close on class lists, section order, locales, or build green alone |
| Dark only (supersedes #96) | Civic dark tokens in `:root`; no light scheme / toggle | Light theme reintroduction; purple glow / neon orbs / Nous-only dark |
| Landing hard parity (#97) | Side-by-side vs stirling.com: promise loudness, scale bands, CTA rhythm, continuous canvas | Class rename / surface checklist as “Stirling energy” |
| Live product proof (#98) | First viewport QR and/or deep link into real Cloud / public product | Static mock or logo card with no live path |
| Pricing / secondary (#99) | Product-priced editorial chrome under KM0 tokens (Stirling pricing/about energy) | “Has `.page-masthead`” without peer chrome |
| Motion you can feel (#100) | Sticky masthead + Offer pin + reveals obvious on `lg+`; honor reduced motion | HTML reveals a human cannot notice; animation spam |

Before **UNTESTED-** on a craft FEAT: Testing instructions **must** include the Hard gate protocol. Tester and closing reviewer reject soft evidence.

## Hallmark-adapted locks (auto-fail if ignored)

From `docs/design/hallmark-adaptations.md` and Nutlope/hallmark references (encoded #108):

| Lock | Do | Do not |
|------|----|--------|
| Tokens | Named vars from `tokens.css` / brand-tokens | One-off hex / font-family mid-component |
| Type | Roman headings; italic only in body | Italic display / section headers |
| Chrome | Real screenshots in quiet figures | Fake browser / phone / IDE / code-window chrome |
| Proof | Sourced or live numbers only | Invented “10× / 50k teams / 99.9%” strips |
| Motion tells | Paint-phase vocabulary | `transition-all`, universal `scale-105`, bounce UI |
| Structure | Page-genre rhythm under KM0 system | Hero → 3 icon cards → dual pills fingerprint |
| Labels | One-line clickable nav/CTA/footer text at ~375 px | Two-line button / nav labels |

## Implementation rules

- Prefer CSS variables in `tokens.css`; map sparingly into Tailwind `theme.extend`.
- Tailwind is a **tool**, not an aesthetic. Utility classes that recreate shadcn/Tailwind-UI demos are a smell.
- First viewport: brand + one headline + one support line + one CTA group + one dominant visual. Nothing else.
- No cards in the hero. No icon-tile feature grids. No fake stats. No card-in-card or decorative side-stripe cards.
- Sections: one job each. Collapse redundant Vision/Mission/Values/Meaning/Privacy blocks when remodeling IA.
- Motion: paint-phase vocabulary only (reveals + masthead compact + Offer pin); honor `prefers-reduced-motion`.
- Atmosphere: reuse **Origin field** (`.km0-motif` / `.km0-motif--origin`); optional ambient SE grid drift only; never invent glow orbs as brand atmosphere. Hero + ≤2 bands.
- Mark system: keep logo / favicon / apple-touch / OG aligned with `docs/brand-tokens.md` Assets. Favicon stays edge-to-edge.
- Surfaces: continuous Paper; elevating a band means an explicit `.surface-*` (or documented Snow opt-in), never zebra.

## Self-audit before done

Run mentally against the doctrine **Hard ban list**, **Hallmark-adapted locks**, **Phase-2 locks**, **Paint-phase locks**, and **Craft-parity locks** (when the FEAT is craft / HARD). Confirm pre-emit scores are all ≥ 3. If any item matches a ban, rewrite.

## References

- Doctrine: `docs/design/anti-slop-doctrine.md`
- Hallmark adaptations: `docs/design/hallmark-adaptations.md`
- Paint phase: `docs/design/stirling-paint-phase.md`
- Craft parity: `docs/design/craft-parity-phase.md`
- Phase-2 study: `docs/design/reference-study-stirling-satisfecho-nous.md`
- Epic: `docs/design/remodel-epic.md`
- Tokens: `docs/brand-tokens.md`
- Hallmark live: https://www.usehallmark.com/
- Hallmark skill (study only): https://github.com/Nutlope/hallmark/blob/main/skills/hallmark/SKILL.md
- Purple gradient essay: https://prg.sh/ramblings/Why-Your-AI-Keeps-Building-the-Same-Purple-Gradient-Website
- NN/g reading: https://www.nngroup.com/articles/how-users-read-on-the-web/
