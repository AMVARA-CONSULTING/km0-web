# Mission and vision block - restore with craft

**Status:** implemented (WIP → UNTESTED, 2026-07-18).  
**Skills:** `km0-anti-slop-design`, `km0-web-copy`, Hallmark (honest framing, no fake KPI strip, editorial structure).  
**Stakeholder:** Boss **requires** Mission and Vision on the marketing home. The conversion FEAT removed `#purpose`; this task restores it on purpose.

## Context
- CLOSED `landing-conversion-gather` dropped Purpose from `Landing.astro` to tighten the join funnel.
- i18n keys `purpose.*` still exist in es/ca/en/de (including the 2030 ambition line).
- `Purpose.astro` may still be on disk or must be restored from git history (`b794092` / pre-conversion).

## Goal
Reimplement a **Mission + Vision** home block that the boss can point to, with civic editorial craft (not a manifesto dump, not icon tiles, not a fake “10M users” stat bar).

## Locked content policy
| Item | Rule |
|------|------|
| Block required | Yes - Mission and Vision on home (`#purpose`) |
| Labels | Mission / Vision (localized `purpose.missionLabel` / `visionLabel`) |
| Vision body | Keep the honest local-infrastructure / anti-harvest meaning (existing `purpose.visionBody` or light km0-web-copy polish) |
| Mission “10.000.000 / 2030” | **Keep the number** (boss-facing ambition). Frame it as a **declared goal**, not a live metric or proof bar. Prefer copy shape: “Goal: connect … by 2030.” / equivalent in es/ca/de. Do **not** turn it into a counting animation or “Trusted by 10M” strip (Hallmark invented-metrics ban). |
| Heading | `purpose.heading` (“Mission and vision” / localized) |

## Placement (locked)
Restore after **Contact**, before **Footer**:

`… → Community → FAQ → Contact → **Purpose** → Footer`

Rationale: keeps the gather funnel (Community/Contact) intact; Purpose is the intentional closer the stakeholder wants visible.

## Craft bar (skills)
1. **Structure:** biased editorial two-column Mission | Vision (existing Purpose pattern is fine if restyled quietly). One section, one job: state purpose. No third “values” column.
2. **Type:** display/section heading + serif or body for statements; UI labels uppercase sans. Tokens only.
3. **Surface:** continuous Paper or one intentional Snow band; no zebra; Signal rail OK.
4. **CTA:** none required inside Purpose (Cloud stays primary elsewhere). Optional quiet text link to `/presentation/` only if it already exists in i18n.
5. **Refuse:** purple, Inter-only, equal icon cards, fake testimonials, animated fake counters.

## Hard gate
Open `/en/` and `/`: `#purpose` visible after Contact; Mission and Vision both readable; 2030 line reads as goal/ambition, not as a live user KPI; gather links in Community still present.
