---
## Closing summary (TOP)

- **What happened:** Craft FEAT #102 restyled the hero Cloud QR so it reads as part of the dark civic product-proof strip, not a stock white sticker.
- **What was done:** Recolored `cloud-qr.png` (Paper modules on Ink quiet zone), framed it in Hero with Snow/Mist/Signal chrome + Ink pad, and documented the asset in brand tokens (site version bumped; stacked tree footer showed 1.1.133).
- **What was tested:** Hard gate vs Satisfecho passed (parity + anti-slop + decisive viewport screenshots); click-through and QR decode to Cloud; locale HTTP 200; no purple glow / no stock-sticker look.
- **Why closed:** All acceptance and Hard gate criteria passed; GitHub #102 already CLOSED.
- **Closed at (UTC):** 2026-07-18 01:22
---

# FEAT-Task: Restyle Cloud QR to match dark civic UI

## GitHub Issue
- **Number:** #102
- **Title:** Craft: restyle Cloud QR so it matches the dark civic UI
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/102
- **Labels:** enhancement, agent:wip

## Problem / goal
Hero Cloud QR (`/brand/cloud-qr.png` + `Hero.astro` live strip) must look like part of the dark civic product proof, not a generic white QR sticker. Keep Cloud URL unless operator changes it.

## High-level instructions for coder
1. Read issue #102 fully. Tokens: `docs/brand-tokens.md` (dark only).
2. Restyle QR artwork/chrome to match Paper/Snow/Signal proof panel; keep scan quiet zone + contrast.
3. Desktop click + mobile scan still open same Cloud destination.
4. Do not redesign the logo here (#103). WhatsApp QR only if cheap alignment.
5. Build; `./scripts/bump-patch-version.sh`; Hard gate protocol in Testing instructions.

## Acceptance (hard)
- Visual integration with dark UI (tester narrates)
- Scan/link still works
- Generic white-square QR with no chrome work = FAIL

## What shipped
- `public/brand/cloud-qr.png`: recolored in place to Paper `#0B1220` modules on Ink `#E6E9ED` quiet zone (matrix unchanged; payload still Cloud).
- `Hero.astro` live strip: Snow frame, Signal left edge + Signal corner ticks, Ink pad around the bitmap (matches proof panel language).
- `docs/brand-tokens.md`: Assets + Cloud QR chrome notes.
- Site version **1.1.130**.

## Testing instructions

### Build / deploy evidence (coder)
- `./scripts/check-no-em-dash.sh` + `./scripts/check-no-mailto.sh`: OK
- `docker compose build && docker compose up -d`: OK
- `curl -sI http://127.0.0.1:9180/` → 200; `/ca/`, `/en/`, `/de/`, `/doc/` → 200
- `/brand/cloud-qr.png` → 200; palette Paper + Ink only
- Footer on `/en/`: Version 1.1.130
- HTML includes `hero__proof-qr-pad`, `hero__proof-qr-corner`, `cloud.km0digital.com` hrefs

### Hard gate protocol (mandatory)

1. **Reference URL(s)** (same session):
   - https://satisfecho.de/ (live QR / product-door energy on a dark-or-product proof surface)
   - Optional: https://stirling.com/ (proof-panel restraint, not QR pixels)

2. **KM0 URL(s)** after rebuild:
   - http://127.0.0.1:9180/
   - http://127.0.0.1:9180/en/

3. **Three parity claims** (side-by-side; narrate, do not only list classes):
   - The hero QR sits inside the same Snow / Mist / Signal-left language as the Cloud proof panel above it, not as a floating stock tile.
   - Desktop click on the QR (and live CTA) opens `https://cloud.km0digital.com` (same destination as primary hero CTA).
   - Quiet zone remains a deliberate light Ink pad with dark Paper modules so a phone scan remains viable (contrast + quiet zone preserved).

4. **Three anti-slop claims**:
   - No purple/indigo glow, neon orb, or glassmorphic QR halo.
   - No generic pure-white sticker QR with black modules and zero chrome work.
   - No logo redesign / webcam-lens mark work in this task (#103 stays separate).

5. **Decisive viewport evidence**:
   - Path: `/` and `/en/` hero, first viewport, right-hand proof column, **live strip** under the product surface.
   - Look for: Signal left accent on QR frame, four Signal corner ticks, Ink pad, Paper-module QR (cool navy on cool light), copy host `cloud.km0digital.com`.
   - Soft FAIL if evidence is only “QR still present” / class list / curl-200 without the visual narration above.

### Tester checklist
- [ ] Open `/` and `/en/`; describe frame/pad/colors vs proof chrome
- [ ] Click QR + live CTA; confirm Cloud URL
- [ ] Phone scan of `/brand/cloud-qr.png` (or on-page QR) still opens Cloud
- [ ] Hard gate fields above filled in Test report (parity + anti-slop + decisive viewport)
- [ ] Footer shows 1.1.130

## References
- https://github.com/AMVARA-CONSULTING/km0-web/issues/102
- docs/brand-tokens.md
- docs/design/craft-parity-phase.md
- src/components/Hero.astro


## Test report

1. **Date/time (UTC):** start 2026-07-18T01:18:56Z; end 2026-07-18T01:21:14Z. Log window: `docker logs --since 2026-07-18T01:18:56Z km0-web`.
2. **Environment:** branch `main` (synced); `docker compose build && docker compose up -d` (Astro build inside image, package `1.1.133` in stacked working tree); loopback `http://127.0.0.1:9180/`; production `https://km0digital.com/` polled until HTTP 200 (ready = 200 on HEAD, no fixed sleep). Headless Chromium via `mcr.microsoft.com/playwright:v1.49.1-jammy` (1280x800). Evidence: `autoagents/.runtime/qr-evidence/` (`01-hero-en.png`, `02-qr-chrome.png`, `03-proof-live.png`, `report.json`).
3. **What was tested:** Hard gate vs Satisfecho live-QR / product-door energy; hero live-strip chrome (Snow/Mist/Signal + Ink pad); QR bitmap palette + decode; desktop click through to Cloud auth; locale HTTP smoke; footer version; nginx logs; anti-slop (no purple glow / no stock sticker).
4. **Results:**

### Hard gate protocol

| Field | Evidence |
|-------|----------|
| Reference URL | https://satisfecho.de/ opened same session (WebFetch + HEAD 200). Live "Your menu, one scan away" / QR table-ordering product door is the peer bar for KM0 Cloud live strip. |
| KM0 URL(s) | `http://127.0.0.1:9180/` and `/en/` after rebuild; footer **Version 1.1.133** (coder claimed 1.1.130 for this task; stacked UNTESTED #103-#105 bumps advanced the working-tree semver). Production `https://km0digital.com/` → 200. |
| Parity 1 | Live strip QR sits in Snow frame `rgb(20,27,40)` with Mist border `rgb(42,51,68)` and Signal left edge `rgb(45,212,191)` at 2px, plus four Signal corner ticks - same civic chrome language as the Cloud proof panel above, not a floating stock tile (`03-proof-live.png`, `report.json`). |
| Parity 2 | Desktop click on `.hero__proof-qr` navigates `https://cloud.km0digital.com` → `https://auth.km0digital.com/login?service=cloud` (real Cloud login surface). Live CTA href identical. Host copy `cloud.km0digital.com` (`report.json` afterUrl/ctaHref). |
| Parity 3 | Bitmap quiet zone is Ink `#E6E9ED` / `rgb(230,233,237)` with Paper `#0B1220` / `rgb(11,18,32)` modules only (PIL palette exact match). zbar + qrcode-reader both decode payload `https://cloud.km0digital.com`. Ink pad in chrome wraps the bitmap (`padBg` in report). |
| Anti-slop 1 | QR chrome `boxShadow: none`, `filter: none`; no purple/indigo hex on `/en/`; no neon orb / glass halo (`report.json` + hero screenshot). |
| Anti-slop 2 | Not a pure-white sticker with black modules: cool Ink pad + Paper modules + Signal ticks/left accent (`02-qr-chrome.png`). |
| Anti-slop 3 | This task's deliverable is QR artwork + live-strip chrome only; logo redesign remains #103 (not required for #102 pass). |
| Decisive viewport | First viewport `/en/` proof column live strip: `01-hero-en.png` + crop `03-proof-live.png` show Signal left + corner ticks, Ink pad, Paper-module QR, LIVE CLOUD copy, host `cloud.km0digital.com`. |

### Functional criteria

| Criterion | Result | Evidence |
|-----------|--------|----------|
| Build + deploy | PASS | Docker build Astro complete; nginx workers up; container on 9180 |
| HTTP `/` `/ca/` `/en/` `/de/` `/doc/` `/en/doc/day-0/` `/brand/cloud-qr.png` | PASS | all HEAD 200 |
| Visual integration (narrated) | PASS | Hard gate parity 1 + screenshots |
| Click QR + live CTA → Cloud | PASS | Playwright click → auth Cloud login; hrefs `https://cloud.km0digital.com` on ES/EN/CA/DE |
| Scan payload → Cloud | PASS | zbarimg + qrcode-reader: `https://cloud.km0digital.com` |
| Hard gate fields complete | PASS | table above |
| Footer version (bump present) | PASS | Loopback `/en/` shows **Version 1.1.133** (>= coder 1.1.130; stacked bumps) |
| Em dash / mailto | PASS | prebuild hooks OK in docker build |
| Logs no 5xx | PASS | access 200 only in window for tested paths |

### Tester checklist

- [x] Open `/` and `/en/`; describe frame/pad/colors vs proof chrome
- [x] Click QR + live CTA; confirm Cloud URL
- [x] Decode/scan of `/brand/cloud-qr.png` still opens Cloud
- [x] Hard gate fields filled (parity + anti-slop + decisive viewport)
- [x] Footer shows bumped version (1.1.133 in stacked tree)

5. **Overall: PASS**
6. **URLs:** http://127.0.0.1:9180/ , /ca/, /en/, /de/, /doc/, /en/doc/day-0/, /brand/cloud-qr.png; https://km0digital.com/; https://cloud.km0digital.com/ (302→auth); https://satisfecho.de/ (reference)
7. **Log excerpts:**
```
2026/07/18 01:19:10 [notice] 1#1: start worker process ...
172.21.0.1 - - [18/Jul/2026:01:19:30 +0000] "HEAD / HTTP/1.1" 200
172.21.0.1 - - [18/Jul/2026:01:19:30 +0000] "HEAD /en/ HTTP/1.1" 200
172.21.0.1 - - [18/Jul/2026:01:19:30 +0000] "HEAD /brand/cloud-qr.png HTTP/1.1" 200
172.21.0.1 - - [18/Jul/2026:01:20:55 +0000] "GET /en/ HTTP/1.1" 200 ... HeadlessChrome/...
172.21.0.1 - - [18/Jul/2026:01:20:55 +0000] "GET /brand/cloud-qr.png HTTP/1.1" 200 1593
```
No 5xx in window.
