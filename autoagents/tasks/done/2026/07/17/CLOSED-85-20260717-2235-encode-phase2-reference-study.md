---
## Closing summary (TOP)

- **What happened:** Phase-2 remodel decisions (#80–#84) were encoded into agent doctrine, skill, epic, and always-applied rules so future agents train on them permanently.
- **What was done:** Updated anti-slop doctrine (Hard bans #12–#13, Phase-2 locks), `km0-anti-slop-design` skill, remodel epic (Phase 2 closed), reference study status, and `anti-slop-frontend.mdc`; docs/cursor only, no site version bump.
- **What was tested:** Tester PASS on study/doctrine/skill/epic/rule alignment, em dash, HTTP smoke (200), no package.json change.
- **Why closed:** All acceptance criteria and testing instructions passed; no anti-slop UI regressions (docs strengthen bans).
- **Closed at (UTC):** 2026-07-17 21:08
---

# FEAT-Task: Encode phase-2 reference study into doctrine

## GitHub Issue
- **Number:** #85
- **Title:** Encode phase-2 reference study into doctrine
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/85
- **Labels:** agent:wip → agent:untested

## Problem / goal
Phase-2 study and bans must train agents permanently.

## High-level instructions for coder
1. Update `docs/design/anti-slop-doctrine.md` with zebra ban + mark/favicon expectations + pointers to reference study.
2. Update `.cursor/skills/km0-anti-slop-design/SKILL.md` references.
3. Refresh `docs/design/remodel-epic.md` phase-2 table (#80–#85).
4. No runtime UI required unless docs-only change still needs version bump per repo rules when user-facing - docs-only: bump only if project convention requires; prefer bump if any public page copy changes.
5. gh #85.

## Acceptance
- Doctrine/skill/epic aligned with phase-2
- Study file linked

## Done by coder
- Doctrine: fixed legacy Inter/purple “current tokens” wording; added phase-2 study to primary references; expanded Hard ban #12–#13; new **Phase-2 locks** (#80 zebra, #81 Origin stamp/favicon/OG, #82 hero proof, #83 scale bands, #84 Origin field); positive rule for mark system.
- Skill `km0-anti-slop-design`: study in read path; Phase-2 locks table; self-audit includes locks.
- Epic: Phase 2 marked **closed** with status column for #80–#85; locked decisions list updated.
- Always-applied rule `anti-slop-frontend.mdc`: zebra + map-pin/favicon auto-fails; study pointer.
- Study file: anti-patterns marked resolved by #80–#84; theme table shows closed status.
- **No site version bump** (docs + `.cursor/` only; `site-version-bump.mdc` skip).

## Testing instructions

1. Confirm study is linked from doctrine: `grep -n 'reference-study-stirling-satisfecho-nous' docs/design/anti-slop-doctrine.md` - expect Primary references table + Phase-2 locks + Agent enforcement.
2. Confirm zebra + mark bans: doctrine Hard ban **#12** (zebra / `nth-child`) and **#13** (map-pin / padded favicon); section **Phase-2 locks** covers #80–#84 with Origin stamp paths (`logo.svg`, full-bleed `favicon.svg`, apple-touch, OG).
3. Confirm skill points at study: `.cursor/skills/km0-anti-slop-design/SKILL.md` opens the study after doctrine/tokens and has a **Phase-2 locks** table (zebra, mark, hero, bands, atmosphere).
4. Confirm epic refresh: `docs/design/remodel-epic.md` heading **Phase 2 (closed)**; table rows #80–#84 status `closed`; #85 listed; locked decisions mention no zebra, Origin stamp, Origin field, agent training.
5. Confirm no contradictory “current Inter + purple gradient” as live tokens: doctrine **Why this exists** must call that a **legacy** attractor exited by phase 1.
6. Confirm study footer matches closed FEATs: `docs/design/reference-study-stirling-satisfecho-nous.md` anti-patterns section says resolved in phase 2.
7. Confirm always-applied rule: `.cursor/rules/anti-slop-frontend.mdc` lists zebra and generic map-pin/favicon as auto-fails.
8. Em dash: `./scripts/check-no-em-dash.sh` → OK.
9. Smoke only (docs-only, no rebuild required): `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` → 200.
10. No `package.json` version change expected for this task.

## References
- Runbook: docs/runbook.md
- Study: docs/design/reference-study-stirling-satisfecho-nous.md
- Doctrine: docs/design/anti-slop-doctrine.md
- Tokens: docs/brand-tokens.md
- Site: https://km0digital.com

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-17 21:06:45 UTC; end 2026-07-17 21:07:17 UTC. Docker log window from 21:06:00Z.
2. **Environment:** Branch `main` @ `5c85df8`. Docs/cursor-only change (no rebuild). Loopback `http://127.0.0.1:9180/` via healthy `km0-web` container. No production deploy required for this task.
3. **What was tested:** Testing instructions 1-10 (doctrine/skill/epic/study/rule alignment, em dash, HTTP smoke, no version bump).
4. **Results:**
   - Study linked from doctrine: **PASS** - `reference-study-stirling-satisfecho-nous` at Primary references (L28), Phase-2 locks (L60), Agent enforcement (L124).
   - Hard bans #12/#13 + Phase-2 locks: **PASS** - zebra/`nth-child` (#12), map-pin/padded favicon (#13); locks cover #80-#84 with Origin stamp paths (`logo.svg`, full-bleed `favicon.svg`, apple-touch, OG).
   - Skill points at study + Phase-2 locks table: **PASS** - read path after doctrine/tokens; table rows Rhythm/Mark/Hero/Bands/Atmosphere.
   - Epic Phase 2 closed: **PASS** - heading `Phase 2 (closed)`; #80-#84 `closed`; #85 listed; locked decisions include no zebra, Origin stamp, Origin field, agent training.
   - Legacy Inter/purple wording: **PASS** - Why this exists calls Inter + purple gradient chain a **legacy** attractor exited by phase 1.
   - Study footer / anti-patterns: **PASS** - "resolved in phase 2"; theme table #80-#84 `closed`.
   - Always-applied rule: **PASS** - zebra + map-pin/favicon auto-fails; study pointer present.
   - Em dash: **PASS** - `./scripts/check-no-em-dash.sh` OK.
   - HTTP smoke: **PASS** - `/` `/ca/` `/en/` `/de/` `/doc/` → 200.
   - No package.json version change: **PASS** - still `1.1.113`; no `package.json` diff.
   - GitHub label `agent:testing` on issue #85: **PASS**.
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`. Production N/A (docs-only; no deploy).
7. **Log excerpts:** `km0-web` healthy; HEAD 200 for smoke paths at 21:07:04Z (and earlier 21:06:10Z).
8. **GitHub:** label `agent:testing` applied on issue #85 at test start.

