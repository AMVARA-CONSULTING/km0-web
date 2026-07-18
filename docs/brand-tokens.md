# Kilómetro 0 Digital - brand tokens

> **Locked for the remodel epic** (2026-07-17). See `docs/design/anti-slop-doctrine.md` and `docs/design/lessons-from-pos.md`.

## Direction

**Vibe:** Cool civic editorial - neighbourhood infrastructure with EU-grade seriousness. Paper that feels printed on stone-cool stock, not Apple gray and not warm-cream restaurant POS.

**Layout archetype:** Split-bias hero (copy + brand left / dominant visual or product proof right). Sections as editorial bands, not icon-tile grids.

**Inspiration structure (not pixels):** `/Repos/pos` landing split + token contract; Hallmark/Wayfare editorial confidence; Linear/Stripe argument pages without copying their chrome.

## Colors (dark only)

Locked **civic dark** as the only scheme. No light theme, no toggle, no `prefers-color-scheme` switch. CSS: `src/styles/tokens.css` (`:root`, `color-scheme: dark`).

| Token | Hex | Usage |
|-------|-----|-------|
| Ink | `#E6E9ED` | Primary text |
| Paper | `#0B1220` | Page canvas (navy field) |
| Snow | `#141B28` | Elevated panels / article bands |
| Signal | `#2DD4BF` | Sole accent (teal, lifted for contrast on dark) |
| Signal hover | `#5EEAD4` | Hover/focus |
| Mist | `#2A3344` | Hairlines, quiet bands |
| Surface ink | `#05080F` | Earned proof / deeper band |
| Ink muted | Ink @ 65–70% | Secondary text |

**Forbidden:** `#E040A0`, `#7B3FE4`, `#007BFF` brand chain; purple/indigo gradients; `bg-clip-text` rainbow headlines; terracotta-on-cream; purple glow / neon orbs; Nous underground as the only voice; reintroducing a light scheme or theme toggle without a new product decision.

Tailwind colors map to `rgb(var(--rgb-*) / <alpha-value>)` so utilities follow these tokens.

## Surfaces (opt-in only)

Default page canvas is **Paper**. Elevations are explicit classes - never `nth-child` zebra. Paint-phase locks: `docs/design/anti-slop-doctrine.md` + `docs/design/stirling-paint-phase.md`.

| Utility | Token | When |
|---------|-------|------|
| `.surface-paper` | `--surface-paper` | Rare explicit reset; body already Paper |
| `.surface-snow` | `--surface-snow` | Intentional elevated band (Contact, compare tables) |
| `.surface-ink` | `--surface-ink` | Earned proof / dark band only |
| `.surface-band` | Mist hairlines | Optional edge on a Snow/Ink band |

Spacing rhythm: `--space-section-y` / `--space-section-x` drive `.section-pad` and secondary page sections.

## Typography

| Role | Face | Notes |
|------|------|-------|
| Display | **Bricolage Grotesque** | Distinctive, not Inter / Space Grotesk / Fraunces-default |
| Body (marketing) | **Source Serif 4** | Editorial reading; pairs with grotesque display |
| UI / labels / nav | **IBM Plex Sans** | Civic/technical UI voice |

**Forbidden as primary:** Inter, Roboto, Open Sans, Arial, system-ui-only.

## Motion

Orchestrated in `src/styles/tokens.css` + `src/scripts/scroll-reveal.ts` (Stirling paint #92). Agent vocabulary: `docs/design/stirling-paint-phase.md` Motion; doctrine Paint-phase locks.

| Token | Role |
|-------|------|
| `--ease-out-expo` (`cubic-bezier(0.16, 1, 0.3, 1)`) | Shared ease (alias `--ease-apple`) |
| `--duration-reveal` (820ms) | Scroll reveal entrance (noticeable once) |
| `--duration-chrome` (280ms) | Masthead compact / border / elevate |
| `--duration-hero-capacity` (480ms) | Hero 500 GB readout + abundance meter (once) |
| `--hero-meter-fill` (0.72) | Meter settle width as capacity / abundance cue |
| `--reveal-distance` (2rem) | Reveal translateY |
| `--reveal-stagger` (90ms) | Sibling auto-stagger when `data-delay` omitted |
| `--masthead-offset` / `--masthead-offset-compact` | Sticky pin top under fixed nav |
| `--masthead-elevate` | Compact masthead hairline + soft lift (no glass) |

**Sitewide moments (cap):** (1) scroll reveals via `[data-reveal]` once (CSS-hidden until `.is-visible`), (2) masthead compact on scroll (solid Snow, hairline + elevate, no glass blur), (3) home Offer sticky pin (heading + Cloud CTA while rows scroll on `lg+`; stuck surface is visible), (4) hero 500 GB capacity readout + meter once when the proof reveal settles (`Hero.astro`, `hero-capacity.ts`). Reading TOC sticky stays as chrome, not a vanity animation.

Always honor `prefers-reduced-motion`: reveals show immediately; chrome transitions off. Sticky layout may remain.

## Signature atmosphere: Origin field

KM0’s quiet motif (phase 2 #84, drift #105). Not POS orbs, not purple glow, not zebra stripes.

| Piece | Token / class | Role |
|-------|---------------|------|
| Quiet civic grid | `--km0-motif-grid-*` + `.km0-motif` | Stone-cool paper that feels surveyed, not blank |
| SSW grid drift | `--km0-motif-drift-duration` + `km0-motif-grid-ssw` | Very slight continuous slide down + a bit left; seamless on cell size |
| Paper grain | `--km0-motif-grain*` via `::after` | Print-stock texture; multiply, very low opacity; stays static |
| Kilometer-zero geometry | `.km0-motif--origin` via `::before` | Biased cross + diamond (right/upper), Signal ink only; stays static |

**Usage:** hero (`.km0-motif.km0-motif--origin`) plus at most two intentional bands (e.g. Why, Contact). Continuous Paper elsewhere. Grid drift is ambient atmosphere only (does not move copy, CTA, QR, or grain). Under `prefers-reduced-motion: reduce`, the grid is fully static (today’s pre-drift look).

**Ban:** glow/bloom/soft radial orbs as brand atmosphere; repeating the motif on every section; busy/fast scrolling grids; content parallax tied to the motif.

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
| Main logo (plaque) | `public/brand/logo.svg` / `logo.png` (512) |
| Mono silhouette | `public/brand/logo-mono.svg` (navy field + white K0) |
| Email / compact icon | `public/brand/logo-icon.png` (256) |
| Cloud live QR | `public/brand/cloud-qr.png` (Paper modules on Ink quiet zone; Hero frames in Snow + Signal) |
| OG preview | `public/brand/og-preview.png` (1200×630) |
| Favicon | `public/favicon.svg` (full-bleed K0) |
| Apple touch | `public/apple-touch-icon.png` (180) |
| 16/32 proof (design) | `docs/design/logo-k0-favicon-16.png`, `logo-k0-favicon-32.png`, `logo-k0-proof-sheet.png` |

### Cloud QR (hero live proof)

- **Payload:** `https://cloud.km0digital.com` (same as primary CTA; do not change without operator approval).
- **Artwork:** Paper `#0B1220` modules on Ink `#E6E9ED` quiet zone (high contrast, scannable). Not a stock black/white sticker.
- **Chrome:** `Hero.astro` live strip frames the pad in Snow + Mist with a Signal left edge and Signal corner ticks, matching the product-proof panel. No purple glow, no neon.

### Mark: K0 lettermark (#103)

- **Motif:** Geometric **K0** monogram on a Signal plaque. One idea: Kilómetro 0 / KM0 as a lettermark (brief direction A). Designed 16×16 first, then scaled.
- **Why it is not a webcam:** No rings, iris, diamond, or nested ellipses. Asymmetric letterforms (K stem + arms + separate digit 0) break radial “lens” symmetry that plagued #81/#88 hollow-plaque marks.
- **Also not:** map-pin stem, purple gradient orb, thin-line icons, crowded multi-metaphor scenes.
- **Rejected:** #81 concentric origin stamp; #88 rectangular hollow digit-0 plaque (still read as aperture/gadget to the owner).
- **Colors:** Stamp field `#0F766E` + figure `#EEF0F2`. Mono uses navy `#0B1220` + white. Plaque carries its own field so it reads on Paper, Snow, and dark chrome.
- **Favicon:** Same K0, **edge-to-edge** square (no padding, no rounded crop) so tabs stay readable at 16×16.
- **Responsive tiers:** `logo.svg` (rounded tile for header/hero/footer) → `favicon.svg` (full-bleed micro) → `logo-mono.svg` → PNG/OG rasters.
- **Wordmark:** Live UI uses i18n brand mark in Header/Hero (Bricolage). OG card pairs the plaque with “Kilómetro 0 Digital”.
- **Do not** reintroduce concentric-lens stamps, hollow-only digit plaques that read as cameras, map-pins, or purple/magenta→blue gradient marks.
