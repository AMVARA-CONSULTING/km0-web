# KM0 logo redesign brief (post-#81)

Issue #81 shipped a teal “origin stamp,” but the concentric ellipses + center diamond still read as a **webcam / camera lens**. Product owner rejects it. This brief drives the next mark.

## What failed

Current `public/brand/logo.svg`: rounded Signal tile + nested ellipses + diamond + plaque bar → silhouette of a lens, not “kilómetro 0 / local digital.”

## Research: logos for IT / digital-service companies (2025–2026)

Sources: responsive logo systems (Brainy Papers), favicon/scalability tests, tech logo guides.

| Principle | Implication for KM0 |
|-----------|---------------------|
| **Responsive system** | Full lockup + primary mark + simplified mark + favicon monogram  -  not one SVG shrunk everywhere |
| **Design the 16×16 first** | If it fails as favicon, redesign; do not “hope shrink works” |
| **Geometric simplicity** | Thick strokes, closed shapes, no hairlines, no tiny counters that clog |
| **One focal idea** | One gesture people remember  -  not nested metaphors |
| **Avoid generic tech tropes** | No circuit boards, wifi fans, clouds-with-arrows, abstract “nodes,” **camera/lens**, chatbot bubbles |
| **Silhouette test** | Recognisable in pure black on white and white on Ink |
| **Color with contrast** | Signal teal OK as field or accent; must also work mono |
| **Distinct from SaaS clones** | No Inter wordmark + purple orb; pair with KM0 type (Bricolage / Plex) when lockup exists |

Successful IT marks tend to be: lettermark (Notion N, Linear L), bold abstract geometry with unusual proportion, or a single custom glyph  -  **not** literal gadgets.

## KM0 meaning (keep)

- **Kilómetro 0 / origin**  -  start point, local, near people
- **Digital services**  -  Cloud, Email, community infra (EU)
- **Civic / trust**  -  not venture hype, not consumer gadget

## Explicit bans for the next mark

1. Concentric circles / ellipses that read as **camera, webcam, iris, or speaker**
2. Classic **map-pin** teardrop
3. Purple gradients, glow, skeuomorphic chrome
4. Crowded multi-element scenes (nodes + waves + pin + text in 32px)
5. Thin line icons that vanish at 16px

## Direction options (coder/designer picks ONE and commits)

Propose 2–3 SVG candidates, then ship one system:

**A. Lettermark “0” or “KM”**  -  bold custom zero / KM monogram; origin without a pin. Favicon = the glyph alone.  
**B. Geometric origin plaque**  -  single solid shape (square/shield/tablet) with a clear **“0”** cutout or emboss; no rings.  
**C. Signal bar / milestone**  -  horizontal “km marker” or single chevron/milestone glyph (roadside, not camera).

All must pass: 16×16, 32×32, header ~40px, mono Ink-on-Paper and Paper-on-Ink.

## Deliverables

- `logo.svg` (color + mono variants or CSS-friendly single SVG)
- `favicon.svg` (dedicated micro mark; full-bleed, minimal padding  -  idea #72)
- Header / Hero / Footer / OG refresh if needed
- Short usage notes in `docs/brand-tokens.md`
- Side-by-side note in PR/task: why it does **not** look like a webcam

## Related

- Closed attempt: #81  
- Favicon padding idea: #72  
- Tokens: `docs/brand-tokens.md`  
- Anti-slop: `docs/design/anti-slop-doctrine.md`
