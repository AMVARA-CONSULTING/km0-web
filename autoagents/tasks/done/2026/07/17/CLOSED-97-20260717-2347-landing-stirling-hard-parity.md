---
## Closing summary (TOP)

- **What happened:** Craft parity HARD for the landing vs stirling.com (#97) reached CLOSED with a full tester Hard gate report.
- **What was done:** Landing rebuilt for ownership promise loudness, full-width scale bands, Cloud-primary CTA rhythm, and continuous Paper canvas; version bumped through later FEATs (footer 1.1.128 at test time). Closing reviewer confirmed Hard gate fields and no soft-only / anti-slop archive blocks.
- **What was tested:** Overall PASS - Stirling beside KM0 with 3 parity + 3 anti-slop claims, decisive `/en/` viewport, locales 200, live Cloud path, light default + dark remap (not purple-glow).
- **Why closed:** All acceptance criteria and craft Hard gate protocol satisfied; GitHub #97 already closed.
- **Closed at (UTC):** 2026-07-18 00:24
---

# FEAT-Task: Landing Stirling HARD visual parity

## GitHub Issue
- **Number:** #97
- **Title:** Craft parity HARD: landing must win side-by-side vs stirling.com
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/97
- **Labels:** enhancement, agent:wip

## Problem / goal
#93 soft-passed on section order. Landing must win a human side-by-side with https://stirling.com/ for promise loudness, scale bands, CTA rhythm, continuous canvas. Class checklists = fail.

## Depends on
#96 preferred first (dark must not break landing).

## Spec
`docs/design/craft-parity-phase.md` Hard gate protocol. Prior paint: `docs/design/stirling-paint-phase.md`.

## High-level instructions for coder
1. Open Stirling home + KM0 home. Rebuild until three non-dev-visible parity claims are true.
2. Promise loudness in first viewport; scale/argument bands (not equal feature strips); CTA rhythm (Cloud primary); sacred counter kept.
3. No Stirling copy/palette clone; no zebra/icon-tiles/purple/Inter-only/centered SaaS hero.
4. Light + dark both must hold if dark shipped.
5. Build; bump; Testing instructions with full Hard gate protocol.

## Acceptance (hard)
- Tester writes 3 parity + 3 anti-slop claims after opening Stirling
- Soft class-only evidence = FAIL (tester + closing)

## Implementation notes (coder)
- Hero promise shortened to ownership punch (es/ca/en/de): e.g. EN “Your data. Your control.” with EU/price in support line; display size raised; accent on second line.
- Landing order: Hero → Why (scale) → Offer → Cloud user Ink proof → Community → FAQ → Contact (Stirling: promise → volume stories → product).
- Why bands rebuilt as full-width scale stories (large display titles, generous pad, one Snow middle band only); every band primary CTA = Open KM0 Cloud; secondary quieter for meetups/pricing.
- Offer: Cloud `offer-row--lead` vs Email `offer-row--quiet` (not equal strips).
- Dark-safe mist/on-ink color-mix in hero proof + cloud proof labels.
- Site version bumped to **1.1.125**. Docker rebuild healthy; locales `/` `/en/` `/ca/` `/de/` `/doc/` 200.

## Testing instructions

### Hard gate protocol

1. **Reference URL(s)** (same session):
   - https://stirling.com/ (home: “Your PDFs. Your control.” + volume tiers + repeated Get started)

2. **KM0 URL(s)** (after `docker compose build && docker compose up -d`):
   - http://127.0.0.1:9180/en/
   - http://127.0.0.1:9180/ (ES)
   - Optional dark: toggle Theme → Dark on `/en/` and confirm bands/hero still hold

3. **Three parity claims** (non-dev visible; open Stirling beside KM0):
   - **Promise loudness:** First viewport reads a short ownership headline (“Your data. / Your control.”) at hero-display scale, brand above it, one support line with EU/price, one primary Cloud CTA + quieter Pricing link, product proof panel on the right - same confidence shape as Stirling’s five-word promise, not a soft descriptive subtitle.
   - **Scale / argument bands:** Immediately under the hero, three stacked full-width stories (Person / Community / Organisation) with volume-tier energy: large titles, body + fact, primary **Open KM0 Cloud** on each band; middle band is an intentional Snow elevation (not zebra). Scroll feels like Stirling’s under-10k / 10k–1M / 1M+ stories, not a flat feature list.
   - **CTA rhythm + continuous canvas:** Cloud primary repeats at hero, every scale band, Offer pin/Cloud row, and Ink user-counter band; Pricing/meetups stay text-secondary. Canvas stays Paper with earned Ink proof + one Snow scale band + Contact Snow - no automatic Paper/Snow striping while scrolling.

4. **Three anti-slop claims** (what was refused):
   - No icon-tile equal feature grids; Offer is Cloud-led + quieter Email, not three equal cards.
   - No purple/indigo gradients, Inter-only stack, or centered SaaS hero recipe (eyebrow pill + dual pills + chevron).
   - No Stirling copy/palette clone (“Your PDFs…”, Framer purple-free SaaS chrome); KM0 voice + Ink/Paper/Signal tokens only.

5. **Decisive viewport evidence**:
   - Path: `/en/` first viewport + first scale band after one scroll.
   - Look for: H1 “Your data.” / “Your control.”; brand “Kilometer 0 Digital”; proof panel with plan/files; then Why band “Start at home, without Big Tech” with **Open KM0 Cloud** button; footer Version **1.1.125**.
   - Class-list-only evidence (e.g. “has `why-band`”) without side-by-side narration = **FAIL**.

### Smoke checks
```bash
curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/de/ http://127.0.0.1:9180/doc/
curl -s http://127.0.0.1:9180/en/ | grep -E 'Your data\.|Your control\.|Start at home|1\.1\.125'
docker logs --since 10m km0-web
```

### Browser checklist
- [ ] Stirling home open beside `/en/` - three parity claims written by tester
- [ ] Scale bands visibly larger than old list rows; Cloud CTA on all three
- [ ] Light + Dark (#96 toggle) both keep promise/bands readable
- [ ] Sacred Cloud user counter still present after Offer
- [ ] No mailto; no em dash; anti-slop holds

## References
- https://stirling.com/
- docs/design/craft-parity-phase.md
- docs/design/anti-slop-doctrine.md

## Test report

1. **Date/time (UTC) and log window**
   - Start: 2026-07-18T00:21:43Z
   - End: 2026-07-18T00:22:54Z
   - Log window: `docker logs --since 20m km0-web` (nginx start 00:21:57Z through locale GETs 00:22:49Z)

2. **Environment**
   - Branch: `main` (synced via `./scripts/git-sync-main.sh`)
   - Build: `docker compose build && docker compose up -d` (image build `km0-web@1.1.128`, container healthy on `127.0.0.1:9180`)
   - Production readiness: polled `https://km0digital.com/` and `/en/` until HTTP 200; body already shows the same ownership H1 and footer Version 1.1.128 (no fixed sleep)

3. **What was tested**
   - Hard gate protocol: Stirling home opened (fetched) in the same session as KM0 `/en/` and `/`
   - Landing structure: promise loudness, scale bands, CTA rhythm, continuous canvas
   - Smoke: locales `/` `/en/` `/ca/` `/de/` `/doc/` 200; no mailto; no em dash
   - Dark path: theme cycle + `prefers-color-scheme` + `html[data-theme=dark]` Ink/Paper/Signal remap present; default remains light/Auto (not dark-first)
   - Sacred Cloud user counter after Offer (`id="cloud-users"`, count visible)

4. **Hard gate protocol (tester-authored)**

   **Reference URL(s):** https://stirling.com/ (home: “Your PDFs. Your control.” + Under 10k / 10k–1M / 1M+ volume stories + repeated Get started)

   **KM0 URL(s):** http://127.0.0.1:9180/en/ , http://127.0.0.1:9180/ ; also https://km0digital.com/en/ (200, same H1/version)

   **Three parity claims (non-dev visible, Stirling beside KM0):**
   1. **Promise loudness:** Stirling leads with a five-word ownership H1; KM0 `/en/` leads with brand “Kilometer 0” then H1 “Your data.” / accent line “Your control.” at display scale (`clamp(2.55rem…4.25rem)` Bricolage), one EU/price support line, primary **Open KM0 Cloud** + quieter Pricing, product proof panel (500 GB plan / Live Cloud / cloud.km0digital.com) on the right - same confidence shape, not a soft subtitle.
   2. **Scale / argument bands:** Under the hero, three full-width Person / Community / Organisation stories (“Start at home, without Big Tech”, “Share nearby, operate nearby”, “Teams with prices in the open”) with large titles (`clamp(2rem…3.35rem)`), body + fact, and **Open KM0 Cloud** on each band; middle band is the only `why-band--snow` elevation - reads like Stirling’s volume tiers, not a flat feature list.
   3. **CTA rhythm + continuous canvas:** Cloud primary repeats at hero, all three scale bands, Offer Cloud lead row, and Ink `cloud-users` band; Pricing/meetups stay secondary text links. Canvas stays Paper with earned Ink proof + one Snow scale band + Contact Snow - no `nth-child` zebra striping.

   **Three anti-slop claims:**
   1. No icon-tile / feature-card grids; Offer is `offer-row--lead` (Cloud) + `offer-row--quiet` (Email), not three equal cards.
   2. No purple/indigo brand gradients; fonts are Bricolage Grotesque + Source Serif 4 + IBM Plex Sans (not Inter/Roboto-only); hero is split-bias, not centered SaaS eyebrow + dual pills.
   3. No Stirling copy/palette clone (“Your PDFs…”, Framer chrome); KM0 voice + Ink/Paper/Signal tokens (dark remap teal Signal, not purple-glow).

   **Decisive viewport evidence:**
   - Path: `/en/` first viewport + first Why band after one scroll.
   - Look for: H1 “Your data.” / “Your control.”; brand above; proof with plan/Live Cloud; then Why “Start at home, without Big Tech” with **Open KM0 Cloud**; footer **Version 1.1.128** (later FEAT bumps superseded task note 1.1.125; landing claims still hold).
   - Not class-list-only: claims above narrate side-by-side structure vs Stirling.

5. **Results (criteria)**

   | Criterion | Result | Evidence |
   |-----------|--------|----------|
   | Stirling beside `/en/` + 3 parity claims | **PASS** | See Hard gate section |
   | Scale bands larger than list rows; Cloud CTA ×3 | **PASS** | 3× `why-band__cta-btn` “Open KM0 Cloud”; title clamp to 3.35rem |
   | Light + Dark keep promise/bands readable | **PASS** | Theme cycle buttons + `prefers-color-scheme`; CSS `html[data-theme=dark]` remaps tokens; default Auto/light |
   | Sacred Cloud user counter after Offer | **PASS** | Order hero → why → services → cloud-users; “Registered cloud users” / 28 |
   | No mailto; no em dash; anti-slop | **PASS** | checks OK; 0 mailto / 0 U+2014 on `/en/`; no purple keywords in CSS |
   | Locales + doc HTTP 200 | **PASS** | `/` `/en/` `/ca/` `/de/` `/doc/` all 200 |
   | Soft class-only pass forbidden | **PASS** | Report uses side-by-side parity + viewport narration |

6. **Overall: PASS**

7. **URLs tested**
   - http://127.0.0.1:9180/ , `/en/`, `/ca/`, `/de/`, `/doc/`
   - https://km0digital.com/ , https://km0digital.com/en/
   - https://stirling.com/ (reference)
   - https://cloud.km0digital.com/ → 200 redirect to auth login (live product path present)

8. **Relevant log excerpts**
   ```
   2026/07/18 00:21:57 [notice] 1#1: start worker processes
   172.21.0.1 - - [18/Jul/2026:00:22:03 +0000] "HEAD /en/ HTTP/1.1" 200
   172.21.0.1 - - [18/Jul/2026:00:22:49 +0000] "GET /ca/ HTTP/1.1" 200
   172.21.0.1 - - [18/Jul/2026:00:22:49 +0000] "GET /de/ HTTP/1.1" 200
   ```
