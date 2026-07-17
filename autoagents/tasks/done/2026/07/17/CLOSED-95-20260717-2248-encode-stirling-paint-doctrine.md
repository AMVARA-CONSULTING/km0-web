---
## Closing summary (TOP)

- **What happened:** Issue #95 encoded Stirling paint/motion locks into agent doctrine so zebra and motion spam do not return.
- **What was done:** Cross-linked doctrine, skill, remodel epic, paint spec, always-applied rule, and brand tokens with Paint-phase locks for surfaces, reveal/sticky motion, and secondary chrome.
- **What was tested:** Tester PASS on alignment checks (doctrine/skill/epic/spec/rule/tokens), em dash, HTTP smoke; docs-only so no site version bump.
- **Why closed:** All acceptance criteria passed; no anti-slop regressions in the docs (bans reinforced, not introduced).
- **Closed at (UTC):** 2026-07-17 23:18
---

# FEAT-Task: Encode Stirling paint + motion into doctrine

## GitHub Issue
- **Number:** #95
- **Title:** Encode Stirling paint + motion into doctrine
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/95
- **Labels:** agent:untested → agent:testing → CLOSED (verified)

## Problem / goal
Train agents on paint-phase rules so zebra/motion-spam do not return.

## High-level instructions for coder
1. Cross-link doctrine + stirling-paint-phase + skill `km0-anti-slop-design`.
2. Update remodel-epic with #91–#95 table.
3. gh #95.

## Acceptance
- Docs/skills/epic aligned

## Done by coder
- Doctrine: paint phase mentioned in Why; Primary references row for `stirling-paint-phase.md`; new **Paint-phase locks** (#91 surfaces, #92 motion, #93/#94 chrome); positive rules for motion vocabulary + surfaces; Agent enforcement lists paint spec.
- Skill `km0-anti-slop-design`: paint spec in read path; **Paint-phase locks** table (surfaces / reveal / sticky / motion budget / secondary chrome); self-audit includes paint locks.
- Epic: **Paint phase (closed)** table with FEAT names + status for #91–#95; locked decisions for surfaces/motion/secondary chrome; #85 marked closed.
- Spec `stirling-paint-phase.md`: status banner + cross-links to doctrine/skill/epic; Agent training footer.
- Always-applied rule `anti-slop-frontend.mdc`: motion-spam auto-fail; paint-phase surfaces/motion required pointer.
- Tokens: Surfaces + Motion sections point at doctrine/paint spec.
- **No site version bump** (docs + `.cursor/` only; `site-version-bump.mdc` skip).

## Testing instructions

1. Confirm paint spec linked from doctrine: `grep -n 'stirling-paint-phase' docs/design/anti-slop-doctrine.md` - expect Primary references table + Paint-phase locks + Agent enforcement.
2. Confirm Paint-phase locks cover #91–#94: section **Paint-phase locks** with Surfaces (`.surface-snow` / `.surface-ink` / `.surface-band`), Motion (`[data-reveal]`, masthead compact, `offer__pin`, `prefers-reduced-motion`), Landing + secondary chrome (`.page-shell` / `.page-masthead` / `.page-closer`).
3. Confirm skill points at paint: `.cursor/skills/km0-anti-slop-design/SKILL.md` opens `stirling-paint-phase.md` after the phase-2 study and has a **Paint-phase locks** table (Surfaces, Reveal, Sticky, Motion budget, Secondary chrome).
4. Confirm epic refresh: `docs/design/remodel-epic.md` heading **Paint phase (closed)**; table rows #91–#94 status `closed`; #95 listed as this task; locked decisions mention surfaces, motion, secondary chrome.
5. Confirm cross-links on paint spec: `docs/design/stirling-paint-phase.md` status banner points at doctrine + skill + epic; Agent training section present.
6. Confirm always-applied rule: `.cursor/rules/anti-slop-frontend.mdc` lists motion spam as auto-fail and requires `stirling-paint-phase.md` for chrome work.
7. Confirm tokens pointers: `docs/brand-tokens.md` Surfaces + Motion mention paint-phase / doctrine locks.
8. Em dash: `./scripts/check-no-em-dash.sh` → OK.
9. Smoke only (docs-only, no rebuild required): `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` → 200.
10. No `package.json` version change expected for this task.

## References
- docs/design/stirling-paint-phase.md
- https://stirling.com/
- docs/design/anti-slop-doctrine.md
- docs/brand-tokens.md
- Runbook: docs/runbook.md

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-17 23:18:05 UTC; end 2026-07-17 23:18:20 UTC. Docker log window from 23:18:00Z.
2. **Environment:** Branch `main` @ `3f6a0e7`. Docs/cursor-only change (no rebuild). Loopback `http://127.0.0.1:9180/` via healthy `km0-web` container. No production deploy required for this task.
3. **What was tested:** Testing instructions 1-10 (doctrine/skill/epic/paint-spec/rule/tokens alignment, em dash, HTTP smoke, no version bump).
4. **Results:**
   - Paint spec linked from doctrine: **PASS** - `stirling-paint-phase` in Primary references (L30), Paint-phase locks (L95), Agent enforcement (L150).
   - Paint-phase locks cover #91-#94: **PASS** - section present; Surfaces (`.surface-snow` / `.surface-ink` / `.surface-band`); Motion (`[data-reveal]`, masthead compact, `offer__pin`, `prefers-reduced-motion`); Landing + secondary chrome (`.page-shell` / `.page-masthead` / `.page-closer`).
   - Skill points at paint + Paint-phase locks table: **PASS** - read path opens paint spec after phase-2 study; table rows Surfaces / Reveal / Sticky / Motion budget / Secondary chrome.
   - Epic Paint phase closed: **PASS** - heading `Paint phase (closed)`; #91-#94 `closed`; #95 listed as this task; locked decisions mention surfaces, motion, secondary chrome; #85 marked closed in Phase 2.
   - Paint spec cross-links: **PASS** - status banner points at doctrine + skill + epic; Agent training section present.
   - Always-applied rule: **PASS** - motion spam auto-fail; `stirling-paint-phase.md` required for chrome work.
   - Tokens pointers: **PASS** - Surfaces + Motion cite paint-phase / doctrine locks.
   - Em dash: **PASS** - `./scripts/check-no-em-dash.sh` OK.
   - HTTP smoke: **PASS** - `/` `/ca/` `/en/` `/de/` `/doc/` → 200.
   - No package.json version change: **PASS** - still `1.1.122`; no `package.json` diff.
   - GitHub label `agent:testing` on issue #95: **PASS**.
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`. Production N/A (docs-only; no deploy).
7. **Log excerpts:** `km0-web` healthy; HEAD 200 for smoke paths at 23:18:14Z.
8. **GitHub:** label `agent:testing` applied on issue #95 at test start.
