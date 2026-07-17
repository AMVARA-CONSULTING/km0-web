---
## Closing summary (TOP)

- **What happened:** Secondary pages needed the same professional paint and motion language as the landing.
- **What was done:** Shared page-closer chrome, Presentation Origin motif hero, light reveals on Pricing/Meeting/Ideas/Security/Legal/errors; Snow bands only where intentional; version 1.1.122.
- **What was tested:** Tester PASS - HTTP 200 on secondary routes (es+en), page-closer/data-reveal/surfaces, ZERO_NTH_CHILD, CTA hierarchy/no mailto, anti-slop OK.
- **Why closed:** All acceptance criteria passed.
- **Closed at (UTC):** 2026-07-17 23:09
---

# FEAT-Task: Secondary pages professional chrome

## GitHub Issue
- **Number:** #94
- **Title:** Secondary pages professional chrome
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/94
- **Labels:** agent:wip → agent:untested

## Problem / goal
Pricing, Presentation, Meeting, Ideas, Security, Legal, errors get the same professional paint + motion language.

## Depends on
#91, #92.

## High-level instructions for coder
1. Shared masthead/band/CTA patterns.
2. Sticky header consistent; light reveals.
3. No mailto; anti-slop.
4. Build; bump; gh #94.

## Acceptance
- Listed routes on-system (es+en spot-check)
- Build green

## What was done
- Shared chrome in `global.css`: `.page-closer` / `__actions` / `__secondary`; TOC restyled as hairline (no Snow card box).
- Pricing: `data-reveal` on sections; custom closer = `surface-snow surface-band` + contact primary / Cloud secondary.
- Presentation: Origin motif hero (dropped one-off grid); Cloud primary + PDF secondary; closer Snow band; locale home link; kept page-shell masthead clearance.
- Meeting / Ideas / Security / Legal / Error: light `data-reveal`; Error uses closer actions.
- Spec note: `docs/design/stirling-paint-phase.md` secondary chrome table (#94).
- Version **1.1.122**.

## Testing instructions

1. **Build / deploy:** `docker compose build && docker compose up -d` already green (Astro build Complete; container `km0-web` up).
2. **HTTP smoke:** `curl -sI` → `200` for `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/en/pricing/`, `/presentation/`, `/en/presentation/`, `/meeting/`, `/ideas/`, `/security/`, `/legal/`, `/403/`, `/en/404/`. Footer shows **1.1.122**.
3. **Shared chrome:** Pricing/Presentation HTML include `page-closer` and `data-reveal`. Presentation hero has `km0-motif` + Cloud `btn-primary` (PDF is `page-closer__secondary`).
4. **Surfaces (no zebra):** Pricing compare + custom closer Snow; Presentation compare + closer Snow; Ideas form Snow; continuous Paper elsewhere. Built CSS: `ZERO_NTH_CHILD` for `nth-child(odd|even)`.
5. **Motion:** Sticky masthead compact still from #92; secondary mastheads/bands use `data-reveal` (reduced-motion safe via existing system).
6. **CTA hierarchy:** Pricing hero Cloud primary; Presentation hero/closer Cloud primary, PDF secondary; no `mailto:`.
7. **Locales:** Spot-check `/pricing/` + `/en/pricing/`, `/presentation/` + `/en/presentation/` headings and Cloud CTAs.
8. **Anti-slop:** Ink/Paper/Signal only; no purple gradients; no Inter-only; no icon-tile grids.
9. **Logs:** `docker logs --since 10m km0-web` - nginx 200s on smoke paths, no 5xx.

## References
- docs/design/stirling-paint-phase.md
- https://stirling.com/
- docs/design/anti-slop-doctrine.md
- docs/brand-tokens.md
- Runbook: docs/runbook.md

## Test report

1. **Date/time (UTC):** start 2026-07-17T23:07:53Z; evidence ~23:07:53Z–23:07:56Z; end 2026-07-17T23:08:06Z.
2. **Environment:** branch `main`; Docker `km0-web` loopback; footer **1.1.122**.
3. **What was tested:** HTTP on secondary routes (es+en); page-closer / data-reveal / surfaces; Presentation motif + CTA hierarchy; Ideas Snow; ZERO_NTH_CHILD; anti-slop; logs.
4. **Results:**
   - HTTP smoke → **PASS** (200 for `/` locales `/doc/` `/pricing/` `/en/pricing/` `/presentation/` `/en/presentation/` `/meeting/` `/ideas/` `/security/` `/legal/` `/403/` `/en/404/`). Footer 1.1.122.
   - Shared chrome → **PASS** (Pricing/Presentation have `page-closer` + `data-reveal`; Presentation `km0-motif`; Cloud `btn-primary` + PDF `page-closer__secondary`; Error pages use `page-closer`).
   - Surfaces / no zebra → **PASS** (Pricing compare+closer Snow; Presentation compare+closer Snow; Ideas form Snow; built CSS `ZERO_NTH_CHILD`).
   - Motion → **PASS** (`data-reveal` on Pricing 7, Presentation 12, Meeting/Ideas/Security/Legal/errors present; masthead compact system from #92 unchanged).
   - CTA / no mailto → **PASS** (Cloud primary on Pricing + Presentation; no `mailto:` on tested pages).
   - Locales → **PASS** (`/pricing/` + `/en/pricing/`, `/presentation/` + `/en/presentation/` structure + Cloud CTAs).
   - Anti-slop → **PASS** (NO_PURPLE in CSS; Ink/Paper/Signal; no mailto).
5. **Overall: PASS**
6. **URLs:** paths listed above on `http://127.0.0.1:9180`.
7. **Logs:** HEAD/GET 200 on pricing/presentation/403 at 23:07:56; **0** 5xx in last 20m.
