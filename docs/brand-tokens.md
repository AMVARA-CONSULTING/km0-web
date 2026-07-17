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

## Signature atmosphere: Origin field

KM0’s quiet motif (phase 2 #84). Not POS orbs, not purple glow, not zebra stripes.

| Piece | Token / class | Role |
|-------|---------------|------|
| Quiet civic grid | `--km0-motif-grid-*` + `.km0-motif` | Stone-cool paper that feels surveyed, not blank |
| Paper grain | `--km0-motif-grain*` via `::after` | Print-stock texture; multiply, very low opacity |
| Kilometer-zero geometry | `.km0-motif--origin` via `::before` | Biased cross + diamond (right/upper), Signal ink only |

**Usage:** hero (`.km0-motif.km0-motif--origin`) plus at most two intentional bands (e.g. Why, Contact). Continuous Paper elsewhere. Motif is **static** (no animation to disable under `prefers-reduced-motion`).

**Ban:** glow/bloom/soft radial orbs as brand atmosphere; repeating the motif on every section.

CSS: `src/styles/tokens.css` + `.km0-motif` in `src/styles/global.css`.

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
| Main logo (stamp) | `public/brand/logo.svg` / `logo.png` (512) |
| Email / compact icon | `public/brand/logo-icon.png` (256) |
| OG preview | `public/brand/og-preview.png` (1200×630) |
| Favicon | `public/favicon.svg` (full-bleed) |
| Apple touch | `public/apple-touch-icon.png` (180) |

### Mark: Origin stamp

- **Motif:** Kilometer-zero plaque on a Signal field: geometric **0**, origin diamond, short milestone baseline. Not a map-pin clone.
- **Colors:** Signal `#0F766E` field + Paper `#EEF0F2` figure. Works on Paper/Snow chrome; stamp carries its own field so it also reads on Ink.
- **Favicon:** Same motif, **edge-to-edge** (no padding, no rounded crop) so tabs stay readable at 16×16.
- **Wordmark:** Live UI uses i18n brand mark in Header/Hero (Bricolage). OG card pairs the stamp with “Kilómetro 0 Digital”.
- **Do not** reintroduce purple/magenta→blue gradient pins in SVG or raster exports.
