# FEAT-Task: Elevate 500 GB hero motion

## GitHub Issue
- **Number:** #104
- **Title:** Craft: elevate 500 GB hero motion (research-backed)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/104
- **Labels:** enhancement, agent:wip

## Problem / goal
Hero 500 GB proof needs a research-backed motion moment (capacity readout + abundance meter). Current thin `scaleX` stub is too weak.

## Spec (mandatory)
`docs/design/hero-500gb-motion.md`

## High-level instructions for coder
1. Read issue #104 + research brief. Follow motion budget, compositor-only, once-only, reduced-motion, a11y number rules.
2. Compose: primary **500 GB** readout motion + retuned meter as abundance cue; align with `tokens.css` motion tokens.
3. Do not fake metrics; do not add glow/bounce/confetti; do not break Cloud proof/QR path.
4. Locales: keep correct plan strings (es/ca/en/de).
5. Build; `./scripts/bump-patch-version.sh`; Testing instructions with Hard gate (motion on + reduced-motion narration).

## Acceptance (hard)
- Human notices the 500 GB story on first load
- Reduced-motion shows finals instantly
- Soft “animation exists” evidence = FAIL

## Implementation notes (coder)
- Plan row: large **500** + Signal **GB** + quiet localized plan label; `aria-label` keeps full `planName` for AT.
- Once-only count-up via `src/scripts/hero-capacity.ts` when `.hero__visual` gains `.is-visible`; expo ease, `--duration-hero-capacity` (480ms).
- Meter fill settles at `--hero-meter-fill` (0.72) with `scaleX` timed to the same moment (not the old 28% stub).
- `prefers-reduced-motion: reduce`: final 500 + full meter, no count-up / no fill animation.
- Live Cloud QR / proof links unchanged. Site version **1.1.132**.

## Testing instructions

### Hard gate protocol

1. **Reference URL(s):** https://stirling.com/ (first-viewport product confidence / capacity clarity) and/or https://satisfecho.de/ (live product proof energy). Open in the same session as KM0.
2. **KM0 URL(s):** http://127.0.0.1:9180/ and http://127.0.0.1:9180/en/ after `docker compose build && docker compose up -d` (footer Version 1.1.132).
3. **Three parity claims (human-visible):**
   - On first load with motion on, the plan row’s **500** digits visibly count toward 500 while **GB** stays stable; a non-dev can say “they’re selling 500 GB storage.”
   - The Signal meter fills once from empty to a calm mid/high band (~72%) in sync with the readout (≤ ~500ms), not a forgotten thin stub.
   - Cloud proof path still works: QR / “Open KM0 Cloud” → `cloud.km0digital.com`.
4. **Three anti-slop claims:**
   - No purple/glow/bounce/confetti; dark civic + Signal only.
   - No fake usage % or Fortune-500 vanity counters; capacity is the real plan size.
   - No infinite loop or motion spam; moment plays once with the proof reveal.
5. **Decisive viewport:** Home hero proof plan row (desktop `lg+` preferred). Narrate motion-on vs reduced-motion (DevTools → Rendering → emulate CSS `prefers-reduced-motion: reduce`): finals appear immediately, no count-up ticks.

### Smoke (not sufficient alone)
- `curl -sI http://127.0.0.1:9180/ /ca/ /en/ /de/ /doc/` → 200.
- HTML contains `data-hero-capacity` and `data-target="500"`; locales keep correct `aria-label` plan strings (es Plan 500 GB, en 500 GB plan, de 500-GB-Plan, ca Pla 500 GB).
- Soft fail: “keyframes exist” / class list without the narration above.

## References
- https://github.com/AMVARA-CONSULTING/km0-web/issues/104
- docs/design/hero-500gb-motion.md
- docs/design/craft-parity-phase.md
- src/components/Hero.astro
- src/scripts/hero-capacity.ts
