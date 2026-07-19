---
## Closing summary (TOP)

- **What happened:** QR codes in the hero live strip and Contact WhatsApp block looked soft/blurry when scaled.
- **What was done:** Applied crisp/pixelated image-rendering on hero and Contact QR images; site version bumped through the stack to 1.2.6.
- **What was tested:** Hard gate PASS: computed image-rendering pixelated, sharp module edges in screenshots, assets 200, live Cloud/WhatsApp paths intact.
- **Why closed:** All acceptance and Hard gate criteria passed with eye-test evidence.
- **Closed at (UTC):** 2026-07-19 00:18
---

# [ideas/es] QRs borrosos: falta clase o etiqueta pixelada

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/109
- **Number:** #109
- **Labels:** agent:wip → agent:untested
- **Created:** 2026-07-18T18:33:34Z

## Problem / goal
QR codes on the site look somewhat blurry when scaled in the hero live strip and Contact WhatsApp block. Default browser smoothing softens module edges. Apply crisp/pixelated `image-rendering` so modules stay sharp.

## What was done
- `src/components/Hero.astro` (`.hero__proof-qr-img`): `image-rendering: -moz-crisp-edges` / `crisp-edges` / `pixelated`
- `src/components/Contact.astro` (`.contact__qr-img`): same stack
- Site version bumped `1.2.2` → `1.2.3` via `./scripts/bump-patch-version.sh`
- No asset regeneration; PNG payloads unchanged (`/brand/cloud-qr.png`, `/contact/whatsapp-group-qr.png`)

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/109
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md
- Peer craft: CLOSED Cloud QR / WhatsApp QR civic restyle tasks

## Testing instructions

### Hard gate protocol
| Item | Value |
|------|-------|
| Reference | Prior QRs with default bilinear smoothing (soft module edges when scaled) |
| KM0 URL | http://127.0.0.1:9180/ (hero Cloud QR) and `#contact` WhatsApp QR; also `/en/` |
| Decisive viewport | Hero first-viewport live strip QR at ~108px CSS size; Contact QR at 11.25rem |

**Parity claims:**
1. **Crisp modules:** Cloud and WhatsApp QR module edges read sharp/pixelated, not soft-blurred gray.
2. **Both surfaces:** Hero `.hero__proof-qr-img` and Contact `.contact__qr-img` both carry the rendering stack in shipped CSS (`/_astro/index.*.css`).
3. **Still scannable / live path:** Assets unchanged; Cloud QR still opens Cloud; WhatsApp QR still joins the group URL.

**Anti-slop claims:**
1. No QR chrome redesign, glow, or purple.
2. No new sticker/card treatment; only `image-rendering` on existing imgs.
3. No light-theme or asset palette churn.

### Smoke (coder evidence)
1. `./scripts/git-sync-main.sh` then implement; `./scripts/bump-patch-version.sh` → **1.2.3**
2. `docker compose build && docker compose up -d` (Astro build inside image; local `npm` not on host)
3. HTTP HEAD 200: `/` `/ca/` `/en/` `/de/` `/doc/` `/brand/cloud-qr.png` `/contact/whatsapp-group-qr.png`
4. Shipped CSS contains `image-rendering:pixelated` on both QR img rules (bundle `/_astro/index.CuWWFRzf.css` at deploy time; hash may change)
5. Footer shows **Version 1.2.3** on `/en/`
6. `./scripts/check-no-em-dash.sh` + `./scripts/check-no-mailto.sh` OK
7. `docker logs --since 10m km0-web` shows clean nginx start + 200s for smoke paths

### Tester checklist
- [ ] Eye-test hero Cloud QR vs memory of soft blur: modules look crisp
- [ ] Eye-test Contact WhatsApp QR: same
- [ ] Confirm computed/style `image-rendering: pixelated` (DevTools on both imgs)
- [ ] Optional: phone scan still reaches Cloud / WhatsApp invite
- [ ] Locales `/` `/ca/` `/en/` `/de/` still 200; footer version ≥ 1.2.3

## Test report

1. **Date/time (UTC) and log window:** Start `2026-07-19T00:16:45Z`, end `2026-07-19T00:16:53Z`. `docker logs --since 2026-07-19T00:16:45Z km0-web`.
2. **Environment:** Branch `main`, `http://127.0.0.1:9180` (footer **1.2.6** ≥ 1.2.3). Playwright → `autoagents/.runtime/tester-109/`. Production previously **200** / Versión 1.2.6.
3. **What was tested:** Hard gate eye-test of hero Cloud QR + Contact WhatsApp QR; computed `image-rendering`; shipped CSS rules; asset HTTP; locale smoke; live paths (Cloud surface href + QR assets).
4. **Results:**
   - Crisp modules (eye-test + computed): **PASS** - Playwright `imageRendering: "pixelated"` on `.hero__proof-qr-img` (108px) and `.contact__qr-img` (180px); crop shots `01-hero-qr.png`, `02-contact-qr.png` show hard module edges (not soft bilinear haze).
   - Both surfaces in shipped CSS: **PASS** - `/_astro/index.CuWWFRzf.css` contains `-moz-crisp-edges` / `crisp-edges` / `pixelated` for both `.hero__proof-qr-img` and `.contact__qr-img`.
   - Still scannable / live path: **PASS** - assets `/brand/cloud-qr.png` and `/contact/whatsapp-group-qr.png` HTTP 200; hero proof surface links to `https://cloud.km0digital.com`; Contact QR markup still WhatsApp invite path (unchanged assets).
   - Anti-slop (3): **PASS** - rendering-only change; no QR chrome redesign / purple / glow; no light-theme or asset palette churn.
   - Locales / version / checks: **PASS** - `/` `/ca/` `/en/` `/de/` `/doc/` 200; Version 1.2.6 on `/en/`; em-dash/mailto OK.
5. **Overall: PASS**
6. **URLs:** `http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` `/brand/cloud-qr.png` `/contact/whatsapp-group-qr.png`.
7. **Logs:** Asset + page GETs **200** in window (including `/brand/cloud-qr.png`, `/contact/whatsapp-group-qr.png`).

