---
## Closing summary (TOP)

- **What happened:** Footer top border used Ink (near-white) instead of brand Signal on the civic dark theme.
- **What was done:** Swapped Footer.astro top border from border-ink to border-signal (border-t-2 kept).
- **What was tested:** Hard gate PASS: computed borderTopColor rgb(45,212,191) on home and /en/pricing/; thin 2px rule; no redesign.
- **Why closed:** All criteria and Hard gate eye-test passed.
- **Closed at (UTC):** 2026-07-19 00:18
---

# FEAT-Task: Footer top rule - Signal primary, not Ink white

## GitHub Issue
- **Number:** #111
- **Title:** Footer top rule: use Signal (primary), not Ink white
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/111
- **Labels:** (agent:planned after sync)

## Origin
- **Source:** Direct operator request + GitHub #111.
- **Brief:** The horizontal line just above the footer looks white; it should be the primary brand color (Signal).

## Problem / goal
`Footer.astro` uses `border-t-2 border-ink` on `.site-footer`. On the locked civic dark theme, Ink is the light text token (`#E6E9ED` per `docs/brand-tokens.md`), so the top rule reads as a white line. Primary / accent in this system is **Signal** (`#2DD4BF`, same family as `.btn-primary`). Change the footer top rule to Signal.

## Locked decisions
1. Footer outer top border uses **Signal** (`border-signal` / `var(--color-signal)`), not Ink.
2. Keep current thickness (`border-t-2`) unless a one-step craft tweak clearly improves contrast; do not thicken into a loud stripe.
3. Internal footer divider under the nav grid (`border-mist`) stays unless it becomes wrong after the Signal top rule; do not restyle the whole footer.
4. Dark-only tokens; no light theme, no purple, no new decoration.

## Scope
1. `src/components/Footer.astro` (top border class).
2. Visual check on home + one secondary page (e.g. `/en/pricing/` or `/en/doc/`).
3. `./scripts/bump-patch-version.sh` once; `npm run build`; Testing instructions; `UNTESTED-`.

## Out of scope
- Footer layout / columns / powered-by copy
- Global token remaps for Ink
- Masthead or section hairlines elsewhere

## Acceptance (hard)
- [ ] Footer top edge color is Signal (teal primary), not white/Ink
- [ ] Visible on Paper canvas above footer on home and at least one secondary page
- [ ] No em dash; no mailto; site version bumped
- [ ] Hard gate eye-test (below); soft class-only alone = fail

## High-level instructions for coder
- Read issue #111 and `docs/brand-tokens.md` (Ink vs Signal).
- Prefer the smallest class change (`border-ink` → `border-signal`).
- Skills: `km0-anti-slop-design` if any craft judgment beyond the utility swap.
- Deploy verification per `docs/runbook.md`.

## Testing instructions

### Change shipped
- `src/components/Footer.astro`: `.site-footer` top border `border-ink` → `border-signal` (keep `border-t-2`).
- Site version bumped to **1.2.4** via `./scripts/bump-patch-version.sh`.
- Built and redeployed: `docker compose build && docker compose up -d`.

### Hard gate protocol
| Item | Value |
|------|-------|
| Reference | Prior footer top rule (Ink / near-white `#E6E9ED`) |
| KM0 URL | http://127.0.0.1:9180/ and http://127.0.0.1:9180/en/pricing/ |
| Decisive viewport | Bottom of page, thin rule between last section and footer |

**Parity claims:**
1. **Primary color:** Top rule uses Signal (`border-signal` → `rgb(var(--rgb-signal))` / `#2DD4BF`), same family as `.btn-primary`, not Ink white.
2. **Still a rule:** Remains `border-t-2` only; not a fat banner; not Mist-invisible.
3. **Sitewide footer:** Same markup on home and `/en/pricing/` (shared `Footer.astro`).

**Anti-slop claims:**
1. No purple / glow / gradient border.
2. No footer redesign beyond the border token (layout, columns, mist internal divider unchanged).
3. No light-theme reintroduction.

### Automated / deploy evidence (coder)
```bash
# Locales + secondary page
curl -sI http://127.0.0.1:9180/          # 200
curl -sI http://127.0.0.1:9180/ca/       # 200
curl -sI http://127.0.0.1:9180/en/       # 200
curl -sI http://127.0.0.1:9180/de/       # 200
curl -sI http://127.0.0.1:9180/doc/      # 200
curl -sI http://127.0.0.1:9180/en/pricing/  # 200

# Footer class (home + pricing)
curl -s http://127.0.0.1:9180/ | grep -oE 'class="site-footer[^"]*"'
# → class="site-footer surface-paper border-t-2 border-signal px-6 py-14 md:px-12"
curl -s http://127.0.0.1:9180/en/pricing/ | grep -oE 'class="site-footer[^"]*"'
# → same border-signal

# Built CSS maps utility to Signal RGB
# .border-signal { border-color: rgb(var(--rgb-signal) / …) }

# Footer version
curl -s http://127.0.0.1:9180/ | grep -oE 'Versión [0-9.]+'
# → Versión 1.2.4

./scripts/check-no-em-dash.sh   # OK
./scripts/check-no-mailto.sh    # OK
```

### Tester eye-test
1. Open http://127.0.0.1:9180/ and scroll to the footer. Confirm the top edge is teal/Signal, not white/Ink.
2. Open http://127.0.0.1:9180/en/pricing/ and confirm the same Signal rule.
3. Confirm thickness still reads as a thin rule (not a loud stripe).
4. Confirm footer layout/copy otherwise unchanged.

## References
- Issue: https://github.com/AMVARA-CONSULTING/km0-web/issues/111
- `src/components/Footer.astro` (`border-t-2 border-signal`)
- `docs/brand-tokens.md` (Ink vs Signal)
- `src/styles/tokens.css`
- docs/runbook.md

## Test report

1. **Date/time (UTC) and log window:** Start `2026-07-19T00:13:31Z`, end `2026-07-19T00:13:39Z`. `docker logs --since 2026-07-19T00:13:31Z km0-web`.
2. **Environment:** Branch `main`, container `km0-web` on `http://127.0.0.1:9180` (footer **1.2.6** ≥ 1.2.4). Playwright → `autoagents/.runtime/tester-111/`. Production already **200** / Versión 1.2.6 from prior poll.
3. **What was tested:** Footer top border token/color on home + `/en/pricing/`; thickness; class presence on locales; hard gate eye-test; em-dash/mailto.
4. **Results:**
   - Footer top edge Signal not Ink: **PASS** - computed `borderTopColor: rgb(45, 212, 191)` (#2DD4BF) on home and pricing (`report.json`); class `border-signal` (not `border-ink`).
   - Visible thin rule sitewide: **PASS** - `borderTopWidth: 2px`; screenshots `01-home-footer.png`, `02-pricing-footer.png`.
   - No em dash / mailto / version: **PASS** - scripts OK; Versión 1.2.6.
   - Hard gate parity (3): **PASS** - Signal primary family; still `border-t-2` only; same markup home + pricing.
   - Hard gate anti-slop (3): **PASS** - no purple/glow/gradient border; no footer redesign; dark tokens only.
5. **Overall: PASS**
6. **URLs:** `http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` `/en/pricing/`.
7. **Logs:** HEAD/GET home + pricing **200** in window.

