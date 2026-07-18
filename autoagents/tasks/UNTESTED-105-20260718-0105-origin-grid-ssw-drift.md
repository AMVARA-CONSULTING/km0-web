# FEAT-Task: Subtle SSW drift on Origin grid motif

## GitHub Issue
- **Number:** #105
- **Title:** Craft: subtle SSW drift on Origin grid motif
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/105
- **Labels:** enhancement, agent:wip

## Problem / goal
Add a very slight continuous grid drift toward south-southwest on `.km0-motif` (hero Origin field). Atmospheric only; reduced-motion stays static.

## High-level instructions for coder
1. Read issue #105. Implement seamless tiled drift (down + slight left) via CSS on `.km0-motif` grid (`global.css` / tokens). Prefer compositor-friendly approach.
2. Speed must stay subtle; no content parallax; grain can remain static.
3. `prefers-reduced-motion: reduce` → static (today’s look).
4. Update `docs/brand-tokens.md` Signature atmosphere (was “static only”).
5. Build; bump; Testing instructions with Hard gate (direction + subtlety + reduced-motion).

## Acceptance (hard)
- Human can name direction as SSW / down-left and call it subtle
- Reduced-motion static
- Busy/dizzy grid or glow = FAIL

## What was done
- Added `--km0-motif-drift-duration: 108s` in `src/styles/tokens.css`.
- Added `@keyframes km0-motif-grid-ssw` on `.km0-motif`: seamless loop of one grid cell left + two cells down (SSW); grain `::after` and origin `::before` stay still.
- `@media (prefers-reduced-motion: reduce)` sets `.km0-motif { animation: none; }`.
- Documented in `docs/brand-tokens.md`, doctrine Signature atmosphere, and anti-slop skill Atmosphere lock.
- Site version bumped to **1.1.133**. Deployed via `docker compose build && docker compose up -d`.

## Testing instructions

### Hard gate protocol

1. **Reference URL(s):** Open https://www.stirling.com/ (or any calm editorial landing) as the motion-budget peer: atmosphere stays quiet; nothing competes with primary CTA.
2. **KM0 URL(s):** http://127.0.0.1:9180/ (hero `#home.km0-motif.km0-motif--origin`). Optional: `/en/`, `/ca/`, `/de/` (same CSS).
3. **Three parity claims (must narrate in Test report):**
   - With motion enabled, watch the hero civic grid for ~8–15s: direction is **south-southwest** (dominant down + slight left / west). Name that direction in the report.
   - Speed is **subtle**: noticed after a beat; does not compete with headline, Cloud CTA, 500 GB readout, or QR.
   - Seam never pops: loop is on grid cell size (`--km0-motif-grid-size`); no flash or jump at cycle boundary.
4. **Three anti-slop claims:**
   - No purple glow / neon orbs / radial bloom added for this motion.
   - No content parallax: copy, CTA, QR, grain, and origin cross stay fixed while only the grid slides.
   - Not a busy/dizzy scrolling grid; not a new hero “show” beyond ambient Origin field.
5. **Decisive viewport evidence:** First viewport of `/` with motion on. Screenshot or timed observation of `#home` grid. Also toggle OS/browser **prefers-reduced-motion: reduce** and confirm grid is fully static (pre-drift look). Soft evidence only (class list / curl-200 / “no purple”) = **FAIL**.

### Smoke (supporting, not sufficient alone)
1. `curl -sI http://127.0.0.1:9180/` and `/ca/`, `/en/`, `/de/`, `/doc/` → 200.
2. Built CSS contains `km0-motif-grid-ssw`, `--km0-motif-drift-duration: 108s`, and `.km0-motif{animation:none}` under `prefers-reduced-motion:reduce`.
3. Footer shows version **1.1.133** (or current after this task’s bump).
4. Home HTML: `#home` has `km0-motif km0-motif--origin`; `#why` / `#contact` may inherit the same grid drift (acceptable).

## References
- https://github.com/AMVARA-CONSULTING/km0-web/issues/105
- src/styles/global.css (`.km0-motif`)
- src/styles/tokens.css (`--km0-motif-drift-duration`)
- docs/brand-tokens.md
- docs/design/craft-parity-phase.md
