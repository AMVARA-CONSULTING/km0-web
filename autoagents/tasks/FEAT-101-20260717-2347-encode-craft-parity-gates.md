# FEAT-Task: Encode craft-parity hard gates into doctrine + agents

## GitHub Issue
- **Number:** #101
- **Title:** Craft parity: encode hard gates into doctrine + agent prompts
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/101
- **Labels:** enhancement, agent:planned

## Problem / goal
Run **last**. Encode Hard gate protocol so agents cannot soft-close craft FEATs again.

## Depends on
#96–#100 closed (or operator waiver).

## Spec
`docs/design/craft-parity-phase.md`

## High-level instructions for coder
1. Add Craft-parity locks to `docs/design/anti-slop-doctrine.md` + `.cursor/skills/km0-anti-slop-design/SKILL.md`.
2. Confirm remodel epic lists #96–#101; sharpen `autoagents/010-feature-coder.md`, `020-test.md`, `030-closing-reviewer.md` if gaps remain after earlier operator edits.
3. Optional dark + live proof + side-by-side fails must be explicit auto-fails.
4. No product UI churn unless docs need a tiny example. Bump only if required by pipeline; docs-only ok if bump script still expected - follow task convention (bump once if any package touch, else note N/A).

## Acceptance
- Doctrine/skill/prompts name Hard gate protocol and reject class-only passes
- Encode does not precede unfinished craft FEATs

## Testing instructions
(to be filled by coder before UNTESTED-)

## References
- docs/design/craft-parity-phase.md
- docs/design/remodel-epic.md
