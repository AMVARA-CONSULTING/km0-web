# Kilómetro 0 Digital - brand tokens

> **Locked for the remodel epic** (2026-07-17). See `docs/design/anti-slop-doctrine.md` and `docs/design/lessons-from-pos.md`.

## Direction

**Vibe:** Cool civic editorial - neighbourhood infrastructure with EU-grade seriousness. Paper that feels printed on stone-cool stock, not Apple gray and not warm-cream restaurant POS.

**Layout archetype:** Split-bias hero (copy + brand left / dominant visual or product proof right). Sections as editorial bands, not icon-tile grids.

**Inspiration structure (not pixels):** `/Repos/pos` landing split + token contract; Hallmark/Wayfare editorial confidence; Linear/Stripe argument pages without copying their chrome.

## Colors

| Token | Hex | Usage |
|-------|-----|-------|
| Ink | `#0B1220` | Primary text (legacy navy hex - keep for continuity) |
| Paper | `#EEF0F2` | Page background (cool stone - **not** `#F5F5F7`, **not** warm cream `#F7F4EF`/`#FAF9F7`) |
| Snow | `#FFFFFF` | Article canvas / elevated panels |
| Signal | `#0F766E` | Sole accent (teal - trust/EU/local digital). Hue outside purple 200–290° band; **not** terracotta twin of POS |
| Signal hover | `#0D9488` | Hover/focus |
| Mist | `#D8DCE0` | Hairlines, quiet bands |
| Ink muted | Ink @ 65–70% | Secondary text |

**Forbidden:** `#E040A0`, `#7B3FE4`, `#007BFF` brand chain; purple/indigo gradients; `bg-clip-text` rainbow headlines; terracotta-on-cream as the whole system.

## Typography

| Role | Face | Notes |
|------|------|-------|
| Display | **Bricolage Grotesque** | Distinctive, not Inter / Space Grotesk / Fraunces-default |
| Body (marketing) | **Source Serif 4** | Editorial reading; pairs with grotesque display |
| UI / labels / nav | **IBM Plex Sans** | Civic/technical UI voice |

**Forbidden as primary:** Inter, Roboto, Open Sans, Arial, system-ui-only.

## Motion

- Ease: `cubic-bezier(0.16, 1, 0.3, 1)`
- Max 2–3 intentional moments per page
- Always `prefers-reduced-motion`

## CTA canon (hero)

- **Primary:** Open KM0 Cloud → `https://cloud.km0digital.com` (product-led)
- **Secondary:** text link to Pricing (same locale path) - not a second equal pill
- Repeat primary after Offer / proof (including user counter band)

## Official copy seeds

- **Name:** Kilómetro 0 Digital (KM0 Digital)
- **Promise:** Servicios digitales cercanos, datos en la UE, sin vender tu perfil.
- Prefer one concrete line over stacked slogan walls.

## Assets

| Asset | Path |
|-------|------|
| Main logo | `public/brand/logo.png` / `logo.svg` |
| Email icon | `public/brand/logo-icon.png` |
| OG preview | `public/brand/og-preview.png` |
| Favicon | `public/favicon.svg` |

Refresh OG/favicon when Signal teal ships so shares do not still show purple gradient.
