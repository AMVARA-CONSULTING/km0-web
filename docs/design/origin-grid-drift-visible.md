# Origin grid drift - visible SE (follow-up to #105)

**Status:** brief for NEW task (2026-07-18).  
**Surface:** `.km0-motif` civic grid on hero (+ up to two bands).  
**Supersedes craft bar of:** CLOSED `#105` / `CLOSED-105-…-origin-grid-ssw-drift` (shipped, but not felt).

## Diagnosis (why the owner does not see it)

| Fact | Evidence |
|------|----------|
| Code **is** deployed | Prod footer **1.1.133**; built CSS includes `km0-motif-grid-ssw` + `--km0-motif-drift-duration: 108s` |
| Motion **exists** on paper | `.km0-motif { animation: km0-motif-grid-ssw … infinite }` in `src/styles/global.css` |
| Motion is **imperceptible** | One grid cell (~48px) over **108s** ≈ **0.44 px/s**. In a normal 8–12s glance the grid moves ~4–5px - easy to miss; headless `background-position` sampling passed Hard gate without a human noticing |
| Direction mismatch vs ask | Owner asked **southeast** (down + right). #105 shipped **SSW** (down + slight left) |

Also check: OS/browser **prefers-reduced-motion: reduce** disables the animation entirely (`animation: none`). If the machine has “reduce motion” on, the grid is correctly static.

## Goal

Make the Origin grid drift **noticeable to a human in ~5–10 seconds** without becoming busy, dizzy, or competing with CTA / 500 GB / QR. Direction: **southeast** (dominant down + slight right / east).

## Recommended craft package

1. **Retune speed** - Target roughly **one cell every 24–40s** (or equivalent perceived speed), not 108s. Still ambient; not a screensaver. Lock the chosen duration in `--km0-motif-drift-duration`.
2. **Direction SE** - Keyframes: down + slight east (e.g. one cell right + two cells down, or 1:2 east:south). Rename keyframes if needed (`km0-motif-grid-se`) and update docs/skill strings that say SSW.
3. **Visibility without tricks** - Prefer keeping tiled `background-position` if it reads; if still weak, move the grid onto a dedicated `::` layer with `transform: translate3d(…)` (compositor-friendly) while content / grain / origin mark stay fixed.
4. **Reduced motion** - Unchanged: `prefers-reduced-motion: reduce` → fully static (pre-drift look).
5. **Hard gate must be eye-test** - Tester narrates after watching with **naked eye** for ≤10s. Pixel-delta-only / class-list / curl-200 = **FAIL** (that is how #105 soft-closed on perception).

## Explicit bans

- Glow orbs, purple bloom, content parallax
- Fast / busy scrolling grids; durations that feel like a loading spinner
- Claiming “subtle” when a colleague cannot name direction after 10s with motion enabled
- Re-closing on headless `bgPos` samples alone

## Doc touchpoints after ship

- `docs/brand-tokens.md` Signature atmosphere (SE + new duration)
- `docs/design/anti-slop-doctrine.md` Signature atmosphere line
- `.cursor/skills/km0-anti-slop-design/SKILL.md` Atmosphere lock (SSW → SE)

## References

- `autoagents/tasks/done/2026/07/18/CLOSED-105-20260718-0105-origin-grid-ssw-drift.md`
- `src/styles/global.css` (`.km0-motif`)
- `src/styles/tokens.css` (`--km0-motif-drift-duration`)
- `docs/design/craft-parity-phase.md` (motion you can feel)
