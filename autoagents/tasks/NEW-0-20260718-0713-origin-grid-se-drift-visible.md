# NEW-Task: Origin grid SE drift must be human-visible

## Origin
- **Source:** Direct operator request (skip GitHub). Follow-up: yesterday’s #105 drift is not felt on the live site.
- **Brief:** `docs/design/origin-grid-drift-visible.md`
- **No GitHub issue** (`NEW-0`).
- **Prior:** `CLOSED-105-…-origin-grid-ssw-drift` (code shipped at 1.1.133; perception failed).

## Problem / goal
#105 deployed a continuous grid animation, but **`--km0-motif-drift-duration: 108s`** makes ~0.44 px/s movement - effectively invisible in a normal glance. Owner also asked for **southeast** drift; #105 shipped **SSW**. Retune so a human can see and name **SE** motion in about 5–10s, still ambient, still reduced-motion safe.

## Diagnosis (do not “re-add” missing CSS)
- Prod already contains `km0-motif-grid-ssw` and `108s` (footer 1.1.133).
- Failure mode: **too subtle + wrong compass** / Hard gate passed on instrumented pixel deltas.
- If the viewer has `prefers-reduced-motion: reduce`, animation is correctly off - document that in Testing notes.

## Scope (only)
1. `src/styles/global.css` - `.km0-motif` keyframes + animation (SE; visible speed)
2. `src/styles/tokens.css` - `--km0-motif-drift-duration` (and any related tokens)
3. Docs/skill strings that still say “SSW” / “108s static subtle”: `docs/brand-tokens.md`, `docs/design/anti-slop-doctrine.md`, `.cursor/skills/km0-anti-slop-design/SKILL.md`
4. Brief `docs/design/origin-grid-drift-visible.md` (already written; amend only if duration/direction locks change)

## Out of scope
- New motif artwork, glow orbs, content parallax
- Remodeling hero layout / 500 GB / QR
- Re-opening #105 on GitHub unless operator asks

## High-level instructions for coder
1. Read `docs/design/origin-grid-drift-visible.md` and the CLOSED-105 file (what not to repeat).
2. Change direction to **southeast** (down + slight right). Rename keyframes if needed.
3. Shorten duration into the **24–40s per cell** band (or prove an equivalent that a colleague notices in ≤10s). Update the CSS variable.
4. Keep grain `::after`, origin `::before`, and content fixed. No purple/glow.
5. `prefers-reduced-motion: reduce` → static.
6. Build; `./scripts/bump-patch-version.sh`; Testing instructions with **eye-test** Hard gate (not bgPos-only); `UNTESTED-`.

## Acceptance (hard)
- [ ] Colleague with motion enabled can name **southeast** after watching the hero ≤10s
- [ ] Drift still ambient (does not beat CTA / capacity / QR)
- [ ] Reduced-motion: fully static
- [ ] Docs/skill no longer claim SSW-only / 108s as the felt craft
- [ ] Soft instrument-only pass without eye narration = FAIL

## Testing instructions
(filled by coder before UNTESTED-)

### Hard gate protocol (required - eye test)
| Item | Value |
|------|-------|
| Reference | Calm peer (e.g. Stirling): atmosphere does not steal the CTA |
| KM0 URL | http://127.0.0.1:9180/ (`#home.km0-motif`) + https://km0digital.com/ after deploy |
| Decisive viewport | Hero first paint, motion **on**, watch **5–10s with naked eye** |

**3 parity claims (must include eye narration):**
1. Direction named as **southeast** (down + right), not SSW.
2. Motion noticed within ~10s without zooming or sampling tools.
3. Loop seamless; no flash at cycle boundary.

**3 anti-slop claims:**
1. No glow/orbs/purple.
2. No content/grain/origin parallax.
3. Not busy/dizzy; CTA still wins.

**Auto-fail:** only reporting `getComputedStyle` / bgPos deltas / “keyframes exist” without a human saying they saw SE drift.

### Smoke
```bash
curl -sI http://127.0.0.1:9180/ /en/ /ca/ /de/
# built CSS: new duration token + SE keyframe name; reduce-motion still animation:none
```

## References
- docs/design/origin-grid-drift-visible.md
- autoagents/tasks/done/2026/07/18/CLOSED-105-20260718-0105-origin-grid-ssw-drift.md
- docs/design/craft-parity-phase.md
- src/styles/global.css
- src/styles/tokens.css
