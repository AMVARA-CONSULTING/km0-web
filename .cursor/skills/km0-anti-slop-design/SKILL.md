---
name: km0-anti-slop-design
description: >-
  Enforce non-generic frontend for km0-web. Use when building or remodeling
  pages, components, tokens, Tailwind classes, heroes, blogs, or any UI that
  risks AI/Tailwind slop (Inter, purple gradients, centered SaaS layouts).
---

# KM0 anti-slop design

Read **`docs/design/anti-slop-doctrine.md`** first. Then **`docs/brand-tokens.md`** and **`docs/design/lessons-from-pos.md`**.

## When this skill applies

Any change to `src/components/`, `src/views/`, `src/layouts/`, `src/styles/`, `tailwind.config.mjs`, marketing pages, blog/tutorial chrome, or visual tokens.

## Pre-flight (mandatory)

Before writing UI code, state in 5 lines:

1. **Vibe** (one sentence, KM0-specific)
2. **Layout archetype** (e.g. split-bias, editorial column, departures-board, masthead - not “centered SaaS”)
3. **Type pair** (display + body; never Inter-only)
4. **Anchor hue + single accent** (no multi-stop purple chains)
5. **What you refuse** (2–3 slop tells you will not ship)

If you cannot fill those five lines from brand docs, **stop** and ask - do not invent another purple gradient.

## Implementation rules

- Prefer CSS variables in `tokens.css`; map sparingly into Tailwind `theme.extend`.
- Tailwind is a **tool**, not an aesthetic. Utility classes that recreate shadcn/Tailwind-UI demos are a smell.
- First viewport: brand + one headline + one support line + one CTA group + one dominant visual. Nothing else.
- No cards in the hero. No icon-tile feature grids. No fake stats.
- Sections: one job each. Collapse redundant Vision/Mission/Values/Meaning/Privacy blocks when remodeling IA.
- Motion: 2–3 intentional moments max; honor `prefers-reduced-motion`.
- Atmosphere: reuse **Origin field** (`.km0-motif` / `.km0-motif--origin`); never invent glow orbs as brand atmosphere. Hero + ≤2 bands.

## Self-audit before done

Run mentally against the doctrine **Hard ban list**. If any item matches, rewrite.

## References

- Doctrine: `docs/design/anti-slop-doctrine.md`
- Tokens: `docs/brand-tokens.md`
- Hallmark: https://www.usehallmark.com/
- Purple gradient essay: https://prg.sh/ramblings/Why-Your-AI-Keeps-Building-the-Same-Purple-Gradient-Website
- NN/g reading: https://www.nngroup.com/articles/how-users-read-on-the-web/
