# KM0 logo redesign brief

Drives the mark system for dark civic KM0. Issue **#103** shipped the current mark; earlier passes (#81, #88) are historical failures below.

## What failed (do not revive)

| Pass | What shipped | Why rejected |
|------|--------------|--------------|
| #81 | Teal “origin stamp”: concentric ellipses + center diamond | Read as **webcam / camera lens** |
| #88 | Rectangular hollow digit-0 on Signal plaque (no rings) | Still read as aperture/gadget; owner asked for a from-zero redesign (#103) |

## Research: logos for IT / digital-service companies (2025–2026)

Sources: responsive logo systems (Brainy Papers), favicon/scalability tests, tech logo guides.

| Principle | Implication for KM0 |
|-----------|---------------------|
| **Responsive system** | Full lockup + primary mark + simplified mark + favicon monogram, not one SVG shrunk everywhere |
| **Design the 16×16 first** | If it fails as favicon, redesign; do not “hope shrink works” |
| **Geometric simplicity** | Thick strokes, closed shapes, no hairlines, no tiny counters that clog |
| **One focal idea** | One gesture people remember, not nested metaphors |
| **Avoid generic tech tropes** | No circuit boards, wifi fans, clouds-with-arrows, abstract “nodes,” **camera/lens**, chatbot bubbles |
| **Silhouette test** | Recognisable in pure black on white and white on navy |
| **Color with contrast** | Signal teal OK as field or accent; must also work mono |
| **Distinct from SaaS clones** | No Inter wordmark + purple orb; pair with KM0 type (Bricolage / Plex) when lockup exists |

Successful IT marks tend to be: lettermark (Notion N, Linear L), bold abstract geometry with unusual proportion, or a single custom glyph, **not** literal gadgets.

## KM0 meaning (keep)

- **Kilómetro 0 / origin** - start point, local, near people
- **Digital services** - Cloud, Email, community infra (EU)
- **Civic / trust** - not venture hype, not consumer gadget

## Explicit bans

1. Concentric circles / ellipses that read as **camera, webcam, iris, or speaker**
2. Classic **map-pin** teardrop
3. Purple gradients, glow, skeuomorphic chrome
4. Crowded multi-element scenes (nodes + waves + pin + text in 32px)
5. Thin line icons that vanish at 16px
6. “Slight tweak” of a failed hollow-0 / lens mark

## Direction locked (#103)

**A. Lettermark K0** - geometric **K** + rectilinear digit **0** on a Signal plaque. Favicon = the same monogram, full-bleed.

Not shipped: B (hollow digit plaque alone), C (milestone/chevron), slashed-zero experiments (lost the “0” read at 16px when the slash ate the counter).

## What shipped (#103)

| Asset | Path |
|-------|------|
| Primary mark | `public/brand/logo.svg` / `logo.png` |
| Mono | `public/brand/logo-mono.svg` |
| Favicon | `public/favicon.svg` (full-bleed) |
| Apple touch / icon / OG | `apple-touch-icon.png`, `logo-icon.png`, `og-preview.png` |
| 16/32 evidence | `docs/design/logo-k0-favicon-16.png`, `logo-k0-favicon-32.png`, `logo-k0-proof-sheet.png` |

**Why it is not a webcam:** Asymmetric letterforms (K stem/arms + separate 0), no rings, no iris, no nested ellipses. Silhouette is a monogram, not an aperture.

**Colors:** Field `#0F766E` + figure `#EEF0F2`. Mono: navy `#0B1220` + white.

## Related

- Shipped: #103
- Superseded attempts: #81, #88
- Favicon padding idea: #72 (addressed by full-bleed favicon)
- Tokens: `docs/brand-tokens.md`
- Anti-slop: `docs/design/anti-slop-doctrine.md`
