---
## Closing summary (TOP)

- **What happened:** Issue #103 replaced the old lens/hollow-0 mark with a geometric K0 lettermark system for dark civic KM0.
- **What was done:** Shipped logo/favicon/OG/mono assets, locked Direction A in the brief and brand tokens, wired existing header/hero/presentation paths to the new mark (site version 1.1.131 at ship).
- **What was tested:** Hard gate PASS on 16×16/32 K0 readability, shared plaque system across header/OG/mono, and anti-slop bans (no lens/pin/purple); smoke HTTP 200 on locales and brand assets.
- **Why closed:** All acceptance criteria and Hard gate claims passed; no anti-slop archive blockers.
- **Closed at (UTC):** 2026-07-18 01:34
---

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

## Test report

- **Date/time (UTC):** 2026-07-18 01:29:38 start → 01:30:18 end
- **Log window:** 2026-07-18T01:29:51Z–01:30:07Z (`docker logs --since 2026-07-18T01:29:38Z km0-web`)
- **Environment:** branch `main`; `docker compose build && docker compose up -d`; loopback `http://127.0.0.1:9180/`; production `https://km0digital.com/` (polled HEAD/GET until HTTP 200; footer Versión 1.1.133 after later bumps #104/#105)
- **What was tested:** Hard gate (16×16 favicon + header/OG/mono K0 system), smoke HTTP, shipped SVG geometry vs lens/pin bans, proof PNGs

### Hard gate

| Field | Evidence |
|-------|----------|
| Reference (rejected) | Brief rejects hollow digit-0 / #81 lens; shipped mark is geometric K0 lettermark (stem + arms + digit ring), not those |
| KM0 URL | http://127.0.0.1:9180/ , `/favicon.svg`, `/brand/logo.svg`, `/brand/og-preview.png`, `/brand/logo-mono.svg` |
| Decisive viewport | Opened `docs/design/logo-k0-favicon-16.png` and `logo-k0-favicon-32.png` (nearest-neighbor): white **K** + hollow **0** on Signal teal `#0F766E`. Proof sheet `logo-k0-proof-sheet.png` shows same system. Live `/brand/logo.png` and OG banner show identical K0 plaque. |

**3 parity / craft claims:**
1. **PASS** - At 16×16 the mark reads as **K0** (letter + digit), not camera aperture or map pin (visual of proof 16/32 + SVG is rect/path lettermark only).
2. **PASS** - Header/home (`/brand/logo.svg`), presentation (`/brand/logo.svg`), OG (`/brand/og-preview.png`) share the same rounded-plaque K0; favicon is full-bleed square of the same lettermark.
3. **PASS** - Mono `/brand/logo-mono.svg`: navy `#0B1220` field + white K0; silhouette still K0.

**3 anti-slop claims:**
1. **PASS** - No `circle`/`ellipse` in shipped SVGs; only `rect`+`path`; Signal teal, no purple/glow fills.
2. **PASS** - No map-pin teardrop geometry; thick lettermark holds at 16px (proof PNGs).
3. **PASS** - Not a hollow-0 plaque tweak: composition is K stem/arms + digit 0 monogram (SVG comments + geometry).

### Smoke / acceptance
| Criterion | Result | Evidence |
|-----------|--------|----------|
| Locales + assets HTTP 200 | PASS | `/` `/ca/` `/en/` `/de/` `/doc/` `/favicon.svg` `/brand/logo.svg` `/brand/og-preview.png` → 200 |
| Favicon mentions K0 lettermark | PASS | `curl` head: "Full-bleed K0 lettermark… Not a lens, not a pin." |
| Old mark gone | PASS | Shipped SVGs are K0 lettermark; no concentric lens rings |
| Footer version | PASS | Loopback + prod show Versión **1.1.133** (task shipped 1.1.131; later FEATs bumped) |
| Production ready | PASS | `curl -sI https://km0digital.com/` → HTTP/2 200; GET footer 1.1.133 |

### Logs (excerpt)
```
01:29:51 nginx start worker processes
01:30:07 HEAD/GET / /ca/ /en/ /de/ /doc/ /favicon.svg /brand/* → 200
```

**Overall: PASS**
