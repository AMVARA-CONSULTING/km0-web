# FEAT-Task: Redesign logo from zero

## GitHub Issue
- **Number:** #103
- **Title:** Brand: redesign logo from zero (kill current mark)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/103
- **Labels:** enhancement, agent:wip

## Problem / goal
Replace the current mark entirely. Do not tweak webcam/origin leftovers from #81/#88. New mark system for dark civic KM0.

## High-level instructions for coder
1. Read issue #103 + `docs/design/logo-brief-it-services.md`. Update brief if direction choice needs locking.
2. Design **16×16 first**, then full lockup. Ship logo.svg/png, favicon (full-bleed), apple-touch, OG, mono if useful.
3. Bans: webcam/lens, map-pin, purple/glow, crowded metaphors, thin lines.
4. Wire header/hero/presentation/OG usages; update `docs/brand-tokens.md` Assets.
5. Build; bump; Testing instructions with 16px/32px visual evidence (Hard gate).

## Acceptance (hard)
- New mark, not a tweak
- Favicon reads at 16px; no camera/pin
- Old mark gone from shipped assets

## What shipped
- **Direction A locked:** geometric **K0** lettermark (not hollow digit plaque, not slashed-zero).
- Assets: `public/brand/logo.svg`, `logo.png`, `logo-icon.png`, `logo-mono.svg`, `public/favicon.svg`, `apple-touch-icon.png`, `og-preview.png`.
- Docs: `docs/brand-tokens.md` Assets, `docs/design/logo-brief-it-services.md`, doctrine mark lock, proof PNGs under `docs/design/logo-k0-*`.
- Header/Hero/Footer/Presentation already point at `/brand/logo.svg` (no path change).
- Site version: **1.1.131**.

## Testing instructions

### Hard gate protocol

| Item | Value |
|------|-------|
| Reference (rejected) | Prior hollow digit-0 / #81 lens stamp (do not ship); brief table in `docs/design/logo-brief-it-services.md` |
| KM0 URL | http://127.0.0.1:9180/ (also `/favicon.svg`, `/brand/logo.svg`) |
| Decisive viewport | Browser tab favicon at **16×16** + header logo ~36px on dark home; compare to `docs/design/logo-k0-favicon-16.png` and `logo-k0-favicon-32.png` |

**3 parity / craft claims (must hold):**
1. At 16×16 the mark reads as **K0** (letter + digit), not a camera aperture or map pin.
2. Header + presentation + OG (`/brand/og-preview.png`) show the **same** K0 system (rounded plaque in UI/OG; full-bleed square in favicon).
3. Mono (`/brand/logo-mono.svg`) is navy field + white K0; silhouette still reads as K0.

**3 anti-slop claims (must hold):**
1. No concentric rings / iris / nested ellipses; no purple or glow.
2. No classic map-pin teardrop; no thin-line icon that dies at 16px.
3. Not a “slight tweak” of the #88 hollow-0 plaque; composition is a lettermark monogram.

**Soft evidence = FAIL:** “SVG exists” / curl-200 / “no purple” without opening the 16px favicon and stating K0 vs camera/pin.

### Smoke
```bash
curl -sI http://127.0.0.1:9180/ /ca/ /en/ /de/ /doc/ /favicon.svg /brand/logo.svg /brand/og-preview.png
# expect 200; footer Versión/Version 1.1.131
curl -s http://127.0.0.1:9180/favicon.svg | head -8   # must mention K0 lettermark, not hollow digit-only
```

### Visual checklist
1. Open http://127.0.0.1:9180/ hard-refresh; tab icon + masthead logo = K0 on teal.
2. Open `docs/design/logo-k0-proof-sheet.png` and confirm 16/32 nearest-neighbor still looks like K0.
3. Confirm old lens/hollow-0 paths are gone from `public/brand/logo.svg` and `public/favicon.svg`.

## References
- https://github.com/AMVARA-CONSULTING/km0-web/issues/103
- docs/design/logo-brief-it-services.md
- docs/brand-tokens.md
