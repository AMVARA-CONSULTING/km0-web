---
## Closing summary (TOP)

- **What happened:** Issue #108 asked to study Nutlope/hallmark and encode anti-slop practices into km0-web agents, rules, and skills without product UI churn.
- **What was done:** Added `docs/design/hallmark-adaptations.md` and wired pre-emit critique, Hallmark-adapted locks, and refuse-theme-catalog rules into doctrine, Cursor skills/rules, and autoagents prompts.
- **What was tested:** Tester PASS: adaptations doc + doctrine/skill/rule/prompt greps, em-dash OK, HTTP 200 smoke on loopback locales, bump N/A, Hard gate fields complete for docs-encode.
- **Why closed:** All Testing instructions and Hard gate claims passed; no `src/` churn or soft-pass evidence.
- **Closed at (UTC):** 2026-07-19 00:27
---

# [ideas/es] Mejorar agents con prácticas anti-slop de Hallmark

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/108
- **Number:** #108
- **Labels:** agent:wip
- **Created:** 2026-07-18T14:57:28Z

## Problem / goal

Study Nutlope/hallmark (skill + references) and adapt anti-slop practices into km0-web agents, Cursor rules, and skills. No package installs. Agent tooling only (not product/`src/` UI churn).

Human note: check if already implemented; if yes, dismiss. Partial overlap with #73 (tokens + early doctrine) and #101 (craft Hard gate). Gap was the published Hallmark skill disciplines (pre-emit critique, italic headers, fake chrome, token improvisation, structural fingerprint, microinteraction tells) not fully encoded into agents.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/108
- Study https://github.com/Nutlope/hallmark/blob/main/skills/hallmark/SKILL.md and references (no npm install)
- Adapt into doctrine / skills / rules / autoagents prompts; do not replace locked KM0 brand with Hallmark theme catalog
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md
- Upstream: https://github.com/Nutlope/hallmark
- Prior encode pattern: CLOSED-101 (docs/agents only; bump N/A)

## Done by coder

- Studied Nutlope/hallmark `SKILL.md` + key references (`anti-patterns.md`, `slop-test.md`, `structure.md`, `motion.md`, `copy.md`) via raw GitHub (no packages installed).
- Added **`docs/design/hallmark-adaptations.md`**: adopt vs refuse table; pre-emit P/H/E/S/R/V; honest proof; token lock; italic headers ban; fake chrome ban; structural fingerprint; microinteraction tells; card discipline; one-line clickables; optional audit verb; agent wiring.
- Doctrine: Hallmark source row → Nutlope skill + adaptations path; Hard ban items 14-18; **Hallmark-adapted locks**; Agent enforcement pointer.
- Skill `km0-anti-slop-design`: read path includes adaptations; **Pre-emit self-critique**; **Hallmark-adapted locks** table; self-audit includes pre-emit ≥ 3.
- Skill `km0-web-copy`: honest proof + short clickable labels.
- Rule `anti-slop-frontend.mdc`: new auto-fails + Required Hallmark adaptations.
- Prompts: `010-feature-coder.md`, `002-coder/CODER.md`, `020-test.md`; `docs/agent-loop.md` pointer.
- **No `src/` product churn. Site version bump: N/A** (`site-version-bump.mdc` skip for `.cursor/` + `docs/` + `autoagents/`).
- Pre-emit (this encode): `Pre-emit: P5 H5 E5 S5 R5 V4` (variety = structural fingerprint ban under locked brand, not theme rotation).

## Testing instructions

1. Confirm adaptations doc exists and names upstream: `test -f docs/design/hallmark-adaptations.md` and `grep -n 'Nutlope/hallmark\|Pre-emit self-critique\|Do \*\*not\*\* adopt' docs/design/hallmark-adaptations.md`.
2. Confirm doctrine wiring: `grep -n 'hallmark-adaptations\|Hallmark-adapted locks\|Italic display\|Re-drawn\|Mid-render\|Invented metrics\|transition-all' docs/design/anti-slop-doctrine.md` - expect Primary references row, Hard ban 14-18, Hallmark-adapted locks section, Agent enforcement bullet.
3. Confirm skill: `grep -n 'hallmark-adaptations\|Pre-emit self-critique\|Hallmark-adapted locks' .cursor/skills/km0-anti-slop-design/SKILL.md`.
4. Confirm copy skill honest proof: `grep -n 'Honest proof\|hallmark-adaptations' .cursor/skills/km0-web-copy/SKILL.md`.
5. Confirm always-applied rule: `grep -n 'Italic display\|Invented metrics\|hallmark-adaptations\|structural fingerprint' .cursor/rules/anti-slop-frontend.mdc`.
6. Confirm agent prompts + loop: `grep -n 'hallmark-adaptations\|pre-emit\|Pre-emit' autoagents/010-feature-coder.md autoagents/002-coder/CODER.md autoagents/020-test.md docs/agent-loop.md`.
7. Confirm refuse list excludes theme catalog install: `grep -n 'theme catalog\|npm install\|No Hallmark theme' docs/design/hallmark-adaptations.md docs/design/anti-slop-doctrine.md`.
8. Em dash: `./scripts/check-no-em-dash.sh` → OK.
9. Smoke only (no rebuild required): `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` → 200.
10. No `package.json` version change expected (bump N/A).

### Hard gate protocol (encode / docs alignment)

This FEAT encodes agent gates rather than shipping UI. Claims verify documentation matches the Hallmark adaptation bar.

1. **Reference URL(s):** https://github.com/Nutlope/hallmark/blob/main/skills/hallmark/SKILL.md and https://github.com/Nutlope/hallmark/tree/main/skills/hallmark/references (studied; no install). Live examples named at https://www.usehallmark.com/.
2. **KM0 URL(s):** `http://127.0.0.1:9180/` (smoke only; no UI churn). Docs under test: `docs/design/hallmark-adaptations.md` + doctrine Hallmark-adapted locks.
3. **Three parity claims (docs):**
   - Pre-emit six-axis critique from Hallmark slop-test is required on UI work and recorded in Implementation summary (not production CSS stamps).
   - Hallmark anti-patterns adapted as hard bans: italic headers, re-drawn chrome, mid-render token improvisation, invented metrics, microinteraction median tells.
   - Adopt vs refuse table keeps locked KM0 brand (no 20-theme catalog / npm hallmark).
4. **Three anti-slop claims:**
   - No product UI churn / no new Inter-only or purple guidance.
   - Structural fingerprint (hero → 3 icon cards → dual pills) explicitly refused.
   - Craft Hard gate and paint-phase locks remain authoritative; Hallmark adaptations do not soften them.
5. **Decisive viewport evidence:** Grep/read paths in Testing instructions 1-7; HTTP smoke item 9. Class lists of site CSS alone would be FAIL for UI craft FEATs - this encode proves the **gate text** exists.

## Test report

1. **Date/time (UTC) and log window**
   - Start: 2026-07-19T00:26:30Z
   - End: 2026-07-19T00:26:43Z
   - Docker log window: 2026-07-19T00:26:00Z onward (HEAD smoke at 00:26:37Z and 00:26:41Z)

2. **Environment**
   - Branch: `main` @ `e8d4800`
   - Build method: N/A (docs/agents encode; smoke against running `km0-web` container, healthy, `127.0.0.1:9180->80`)
   - URLs: loopback only per Testing instructions (no production redeploy required)

3. **What was tested**
   - Existence and content of `docs/design/hallmark-adaptations.md` (upstream Nutlope/hallmark, adopt vs refuse, pre-emit)
   - Doctrine wiring (Primary references, Hard ban 14-18, Hallmark-adapted locks, Agent enforcement)
   - Skills `km0-anti-slop-design` and `km0-web-copy`, always-applied rule `anti-slop-frontend.mdc`
   - Agent prompts (`010-feature-coder`, `002-coder/CODER`, `020-test`) and `docs/agent-loop.md`
   - Refuse list: theme catalog / npm install / No Hallmark theme
   - Em-dash check; HTTP smoke `/` `/ca/` `/en/` `/de/` `/doc/`; no `package.json` bump; no `src/` churn
   - Hard gate protocol fields for docs-encode FEAT (parity + anti-slop claims)

4. **Results**
   - **1. Adaptations doc exists + upstream names:** PASS - file present; greps hit Nutlope/hallmark (L4, L91-92), Pre-emit self-critique (L13, L22), Do **not** adopt (L11).
   - **2. Doctrine wiring:** PASS - hallmark-adaptations Primary row (L17); Hard ban 14-18 italic/re-drawn/mid-render/invented metrics/transition-all (L59-63); Hallmark-adapted locks (L65-67); Agent enforcement (L222).
   - **3. Anti-slop skill:** PASS - read path + Pre-emit section + Hallmark-adapted locks table + self-audit ≥ 3.
   - **4. Copy skill honest proof:** PASS - Honest proof bullet + hallmark-adaptations pointer (L35).
   - **5. Always-applied rule:** PASS - italic display, invented metrics, hallmark-adaptations Required, structural fingerprint auto-fail.
   - **6. Agent prompts + loop:** PASS - all four files reference hallmark-adaptations and/or pre-emit.
   - **7. Refuse theme catalog / npm:** PASS - adaptations adopt-vs-refuse table; doctrine "No Hallmark theme catalog / npm install" (L72).
   - **8. Em dash:** PASS - `check-no-em-dash: OK`.
   - **9. HTTP smoke:** PASS - `/` `/ca/` `/en/` `/de/` `/doc/` all HTTP 200 via `curl -sI` on 127.0.0.1:9180; docker logs show matching HEAD 200.
   - **10. package.json bump N/A:** PASS - `package.json` unchanged in working tree (`version` remains 1.2.6); no `src/`/`public/`/`nginx` churn for this task.
   - **Hard gate - Reference URL(s):** PASS - Nutlope skill + references documented; usehallmark.com named in doctrine Primary row.
   - **Hard gate - KM0 URL(s):** PASS - loopback smoke 200; docs under test present.
   - **Hard gate - 3 parity claims:** PASS
     1. Pre-emit six-axis required on UI work; coder recorded `Pre-emit: P5 H5 E5 S5 R5 V4` (not CSS stamps).
     2. Hard bans 14-18 encode italic headers, re-drawn chrome, mid-render tokens, invented metrics, microinteraction tells.
     3. Adopt vs refuse keeps locked KM0 brand; refuses 20-theme catalog / npm hallmark.
   - **Hard gate - 3 anti-slop claims:** PASS
     1. No product UI churn (`git status` clean under `src/`); no new Inter-only or purple guidance in encode.
     2. Structural fingerprint explicitly refused (adaptations L17/L33/L57; rule auto-fail).
     3. Craft Hard gate / paint-phase remain authoritative (adaptations L20; doctrine L67).
   - **Hard gate - Decisive evidence:** PASS - grep/read paths 1-7 prove gate text; HTTP smoke proves site still healthy. Class-only CSS lists not used as sole evidence.

5. **Overall: PASS**

6. **URLs tested**
   - http://127.0.0.1:9180/ → 200
   - http://127.0.0.1:9180/ca/ → 200
   - http://127.0.0.1:9180/en/ → 200
   - http://127.0.0.1:9180/de/ → 200
   - http://127.0.0.1:9180/doc/ → 200
   - Production redeploy: N/A (docs/agents only)

7. **Relevant log excerpts**
   ```
   km0-web Up (healthy) 127.0.0.1:9180->80/tcp
   172.21.0.1 - - [19/Jul/2026:00:26:37 +0000] "HEAD / HTTP/1.1" 200
   172.21.0.1 - - [19/Jul/2026:00:26:37 +0000] "HEAD /ca/ HTTP/1.1" 200
   172.21.0.1 - - [19/Jul/2026:00:26:37 +0000] "HEAD /en/ HTTP/1.1" 200
   172.21.0.1 - - [19/Jul/2026:00:26:37 +0000] "HEAD /de/ HTTP/1.1" 200
   172.21.0.1 - - [19/Jul/2026:00:26:37 +0000] "HEAD /doc/ HTTP/1.1" 200
   check-no-em-dash: OK (zero U+2014 matches in text files)
   ```

