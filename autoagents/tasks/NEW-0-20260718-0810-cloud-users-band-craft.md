# NEW-Task: Cloud registered-users band craft (align + loud count)

## Origin
- **Source:** Direct operator request (skip GitHub).
- **No GitHub issue** (`NEW-0`).
- **Sacred lock:** live Cloud user counter must stay; never invent or hardcode a fake number (`docs/design/remodel-epic.md`, anti-slop doctrine).

## Problem / goal
The home **Usuarios registrados / Registered cloud users** Ink band (`#cloud-users`, `CloudUserStats.astro` variant `band`) is **misaligned** and the **count looks bland** (“soso”). Rebuild the composition so the live number is a clear proof moment (peer energy to the 500 GB / pricing capacity craft) and the row lines up cleanly with the Cloud CTA on desktop and mobile.

## Current surface (coder starts here)
- Component: `src/components/CloudUserStats.astro` (`variant="band"` → `.cloud-proof`)
- Layout today: flex row, count + uppercase label on one baseline line, CTA `space-between`
- Count style: display face, Signal-hover color, clamp ~2.75–4.25rem, but reads flat; label capped at `max-width: 12rem` which often wraps awkwardly next to the digits
- Data: `fetchCloudUserCount()` from `src/lib/cloud-users` (keep)

## Locked requirements
| Rule | Detail |
|------|--------|
| Keep | Live count from API; `aria-live` / `countAria`; unavailable state |
| Keep | Ink earned band (`surface-ink`); Cloud primary CTA to `cloud.km0digital.com` |
| Keep | Section id `#cloud-users` (anchors / sacred counter) |
| Do not | Fake stats, vanity “10K+”, purple glow, equal icon-stat tiles |
| Do not | Remove the counter or hide it behind a soft decorative strip |

## Scope (only)
1. `src/components/CloudUserStats.astro` styles (+ markup if needed for hierarchy) for **`band`** variant used on the landing.
2. Optional thin motion: once-only count settle or opacity/transform when revealed (reuse hero/pricing capacity tokens if they fit; honor `prefers-reduced-motion`).
3. i18n only if label hierarchy needs a split (e.g. short kicker vs full label). Prefer keeping existing `cloudUsers.*` keys if layout alone fixes it.
4. `variant="section"` may get the same count typography for consistency, but **home band alignment is the acceptance target**.
5. Build; bump; Hard gate Testing instructions; `UNTESTED-`.

## Out of scope
- Changing `fetchCloudUserCount` backend / auth
- Inventing growth charts, avatars, or testimonial strips
- Full landing remodel; Offer sticky; hero QR

## Craft direction (must achieve)
1. **Alignment:** Desktop: count block and Cloud CTA share one clear horizontal rhythm (optical vertical center or shared baseline grid). Mobile: stacked order is deliberate (count first, CTA second), not a ragged wrap. Label must not collide with digits or look like a leftover caption.
2. **Loud number:** Count is the hero of the band (display scale / weight / Signal hierarchy). Label is secondary. Optional once-only entrance so the number is felt, not a muted flex item.
3. **Still Ink proof:** continuous Paper page → intentional Ink band → back; no zebra return.

## Acceptance (hard)
- [ ] `#cloud-users` on `/` and `/en/`: number reads loud; label and CTA no longer look “dealigned”
- [ ] Live count still real (API ok path); unavailable path still sane
- [ ] Desktop + mobile both intentional (tester narrates both)
- [ ] No fake metrics; no purple/glow; reduced-motion safe if motion added
- [ ] Version bumped; build green; locales 200

## Testing instructions
(filled by coder before UNTESTED-)

### Hard gate protocol (required)
| Item | Value |
|------|-------|
| Reference | Home hero **500 GB** proof and/or pricing capacity masthead (loud digits peer) |
| KM0 URL | http://127.0.0.1:9180/#cloud-users , `/en/#cloud-users` |
| Decisive viewport | Ink band: count + label + Cloud CTA at `lg` and at ~390px width |

**3 parity claims:** number is the band’s visual hero; alignment with CTA is clean; still reads as live community proof (not a marketing fake).

**3 anti-slop claims:** no fake 10K strip; no purple/glow; no equal three-stat icon row.

### Smoke
```bash
curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/en/
curl -s http://127.0.0.1:9180/ | grep -E 'id="cloud-users"|cloud-proof__count'
./scripts/check-no-em-dash.sh
```

## References
- src/components/CloudUserStats.astro
- src/lib/cloud-users.ts (or equivalent)
- docs/design/remodel-epic.md (sacred user counter)
- docs/design/anti-slop-doctrine.md
- docs/brand-tokens.md (display type, Signal, motion)
- docs/design/hero-500gb-motion.md / pricing-500gb-craft.md (loud capacity peer, not copy-paste)
