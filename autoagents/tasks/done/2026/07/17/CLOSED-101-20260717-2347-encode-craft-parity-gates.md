---
## Closing summary (TOP)

- **What happened:** Encode FEAT wired Hard gate protocol and soft-close bans into doctrine, skill, epic, rules, and agent prompts; CLOSED after docs Hard gate PASS.
- **What was done:** Added Craft-parity locks across anti-slop doctrine/skill/rule, refreshed remodel epic #96–#101, sharpened coder/tester/closing prompts; no product UI churn (bump N/A).
- **What was tested:** Grep/read verification of locks and Hard gate fields in doctrine/skill/epic/prompts; em-dash OK; HTTP smoke 200; encode Hard gate (Stirling/Satisfecho named; docs parity claims).
- **Why closed:** Documentation and agent gates match craft-parity bar; soft class-only / curl-only / missing-field closes explicitly rejected; craft FEATs #96–#100 complete before encode.
- **Closed at (UTC):** 2026-07-18 00:52
---

# FEAT-Task: Encode craft-parity hard gates into doctrine + agents

## GitHub Issue
- **Number:** #101
- **Title:** Craft parity: encode hard gates into doctrine + agent prompts
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/101
- **Labels:** enhancement, agent:wip

## Problem / goal
Run **last**. Encode Hard gate protocol so agents cannot soft-close craft FEATs again.

## Depends on
#96–#100 closed (or operator waiver).
**Coder note:** #96 closed; #97–#100 coder-shipped as UNTESTED (implementation complete; tester queue). Encode runs after those ships, per phase order.

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

## Done by coder
- Doctrine: craft-parity mentioned in Why; Primary references epic range #73–#101; new **Craft-parity locks** (Hard gate protocol; #96 optional dark; #97 landing; #98 live proof; #99 pricing/secondary; #100 motion; Soft-evidence auto-fails); Agent enforcement lists craft-parity + tester/closing soft-close ban.
- Skill `km0-anti-slop-design`: craft-parity spec in read path; **Craft-parity locks** table; self-audit includes craft locks.
- Epic: **Craft parity phase** table with FEAT names + status for #96–#101; #95 paint encode marked closed; locked decisions for optional dark, live proof, craft soft-close ban; doctrine/skill pointers.
- Spec `craft-parity-phase.md`: status banner + doctrine/skill cross-links; Agent training auto-fail list.
- Always-applied rule `anti-slop-frontend.mdc`: craft soft-close / dark-first / static-proof auto-fails; Hard gate required for craft FEATs.
- Tokens: Color schemes section points at craft-parity / doctrine locks.
- Agent prompts: `010-feature-coder.md`, `020-test.md`, `030-closing-reviewer.md` sharpened with explicit auto-fails (dark-first, static proof, HTML-only motion, missing Hard gate fields).
- **No site version bump** (docs + `.cursor/` + `autoagents/` only; `site-version-bump.mdc` skip).

## Testing instructions

1. Confirm craft-parity linked from doctrine: `grep -n 'craft-parity-phase\|Craft-parity locks' docs/design/anti-slop-doctrine.md` - expect Primary references, Craft-parity locks section, Soft-evidence auto-fails, Agent enforcement.
2. Confirm Craft-parity locks cover #96–#100 + encode: section **Craft-parity locks** with Hard gate protocol (5 fields), Optional dark, Landing Stirling hard parity, Satisfecho live product proof, Pricing + secondary, Motion you can feel, Soft-evidence auto-fails (class-only / curl / missing fields / dark-first / static proof).
3. Confirm skill points at craft: `.cursor/skills/km0-anti-slop-design/SKILL.md` opens `craft-parity-phase.md` and has a **Craft-parity locks** table (Hard gate, Optional dark, Landing, Live proof, Pricing/secondary, Motion).
4. Confirm epic refresh: `docs/design/remodel-epic.md` heading **Craft parity phase (hard)**; table rows #96–#101 with issue links; #96 `closed`; #101 listed as this task; locked decisions mention optional dark, live proof, craft soft-close ban; paint #95 marked `closed`.
5. Confirm cross-links on craft spec: `docs/design/craft-parity-phase.md` status banner points at doctrine + skill + epic; Agent training auto-fail list present.
6. Confirm always-applied rule: `.cursor/rules/anti-slop-frontend.mdc` lists craft soft-close / dark-first / static-proof as auto-fail and requires Hard gate protocol for craft FEATs.
7. Confirm tokens pointer: `docs/brand-tokens.md` Color schemes mentions craft-parity / doctrine locks.
8. Confirm agent prompts name Hard gate + soft-pass reject:
   - `grep -n 'Hard gate\|soft pass\|Craft-parity' autoagents/010-feature-coder.md autoagents/020-test.md autoagents/030-closing-reviewer.md`
   - Expect explicit FAIL for class-only evidence; dark-first; static proof; HTML-only motion; missing Hard gate fields → WIP / do not archive.
9. Em dash: `./scripts/check-no-em-dash.sh` → OK.
10. Smoke only (docs-only, no rebuild required): `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` → 200.
11. No `package.json` version change expected for this task (bump N/A).

### Hard gate protocol (encode task - docs alignment)

This FEAT encodes gates rather than shipping UI. Side-by-side claims below verify the **documentation** matches the craft-parity bar (not a landing redesign).

1. **Reference URL(s):** https://stirling.com/ and https://satisfecho.de/ (named in craft-parity spec + doctrine locks as the peer bar agents must open).
2. **KM0 URL(s):** `http://127.0.0.1:9180/` (smoke only; no UI churn this task). Doctrine path under test: `docs/design/anti-slop-doctrine.md` Craft-parity locks.
3. **Three parity claims (docs):**
   - Hard gate protocol fields (reference, KM0, 3+3 claims, decisive viewport) appear in doctrine, skill, and tester/closing prompts.
   - Optional dark / live proof / motion soft-fails are named as auto-fails (not only “looks professional”).
   - Remodel epic lists #96–#101 in sequence with encode last.
4. **Three anti-slop claims:**
   - No product UI churn / no new Inter-only or purple guidance introduced.
   - Soft class-only / curl-200 / four-locales passes explicitly rejected.
   - Dark-first marketing and purple-glow dark remain forbidden.
5. **Decisive viewport evidence:** Grep/read paths in Testing instructions 1–8; HTTP smoke item 10. Class lists of site CSS alone would be FAIL for UI craft FEATs - this encode task proves the **gate text** exists.

## References
- docs/design/craft-parity-phase.md
- docs/design/remodel-epic.md
- docs/design/anti-slop-doctrine.md
- .cursor/skills/km0-anti-slop-design/SKILL.md

## Test report

1. **Date/time (UTC):** start 2026-07-18 00:51:27 UTC; end 2026-07-18 00:51:33 UTC. Log window: `docker logs --since 2026-07-18T00:51:27Z km0-web`.
2. **Environment:** branch `main` (synced); docs/agent/skill verification on working tree; HTTP smoke against already-running `http://127.0.0.1:9180/` (no rebuild; docs-only task). Reference sites opened: https://stirling.com/ (session for #100) and https://satisfecho.de/ (this task).
3. **What was tested:** Testing instructions 1–11 + encode Hard gate (docs alignment). Dependency: #96 closed; #97–#99 archived under `done/2026/07/17/`; #100 `CLOSED-100-…` in `tasks/` (just verified PASS).
4. **Results:**

| Criterion | Result | Evidence |
|-----------|--------|----------|
| 1. Doctrine links craft-parity | PASS | Primary references row `craft-parity-phase.md`; section **Craft-parity locks**; Soft-evidence auto-fails; Agent enforcement cites Hard gate |
| 2. Locks cover #96–#100 + encode | PASS | Hard gate (5 fields); Optional dark; Landing Stirling; Satisfecho live proof; Pricing + secondary; Motion; Soft-evidence (class-only / curl / missing fields / dark-first / no live path) |
| 3. Skill Craft-parity locks table | PASS | Opens `craft-parity-phase.md`; table rows Hard gate, Optional dark, Landing, Live proof, Pricing/secondary, Motion |
| 4. Epic craft table | PASS | Heading **Craft parity phase (hard)**; rows #96–#101 with issue links; #96 `closed`; #95 paint `closed`; #101 this task; locked decisions: optional dark, live proof, craft soft-close ban |
| 5. Craft spec cross-links | PASS | Status banner → doctrine + skill + epic; Agent training auto-fail list present |
| 6. `anti-slop-frontend.mdc` | PASS | Craft soft-close / dark-first / static-proof auto-fails; Hard gate required for craft FEATs |
| 7. Tokens pointer | PASS | Color schemes → craft-parity / doctrine locks |
| 8. Agent prompts | PASS | `010` / `020` / `030` name Hard gate; reject class-only; dark-first; static proof; HTML-only motion; missing fields → WIP / do not archive |
| 9. Em dash | PASS | `./scripts/check-no-em-dash.sh` OK |
| 10. HTTP smoke | PASS | `/` `/ca/` `/en/` `/de/` `/doc/` → 200 |
| 11. Bump N/A | PASS | No `package.json` change for this task (docs + `.cursor/` + `autoagents/` only) |
| Encode precedes unfinished craft? | PASS | #97–#99 done/; #100 CLOSED; #96 closed per epic |

### Hard gate protocol (encode / docs)

| Field | Evidence |
|-------|----------|
| Reference URL(s) | https://stirling.com/ and https://satisfecho.de/ named in craft-parity + doctrine locks; both opened this tester session |
| KM0 URL(s) | Smoke `http://127.0.0.1:9180/`; doctrine under test `docs/design/anti-slop-doctrine.md` Craft-parity locks |
| Parity 1 | Hard gate fields present in doctrine, skill table, and tester/closing prompts |
| Parity 2 | Optional dark / live proof / motion soft-fails named as auto-fails |
| Parity 3 | Remodel epic lists #96–#101 with encode last |
| Anti-slop 1 | No product UI churn this task; no new Inter-only or purple guidance |
| Anti-slop 2 | Soft class-only / curl-200 / four-locales passes explicitly rejected in Soft-evidence |
| Anti-slop 3 | Dark-first marketing and purple-glow dark remain forbidden |
| Decisive viewport | Grep/read paths for items 1–8; HTTP smoke item 10 (gate **text** existence, not UI redesign) |

5. **Overall: PASS**
6. **URLs:** http://127.0.0.1:9180/ , /ca/, /en/, /de/, /doc/; https://stirling.com/; https://satisfecho.de/; N/A production redeploy (docs-only)
7. **Log excerpts:**
```
172.21.0.1 - - [18/Jul/2026:00:51:29 +0000] "HEAD / HTTP/1.1" 200
172.21.0.1 - - [18/Jul/2026:00:51:29 +0000] "HEAD /en/ HTTP/1.1" 200
172.21.0.1 - - [18/Jul/2026:00:51:29 +0000] "HEAD /doc/ HTTP/1.1" 200
```

