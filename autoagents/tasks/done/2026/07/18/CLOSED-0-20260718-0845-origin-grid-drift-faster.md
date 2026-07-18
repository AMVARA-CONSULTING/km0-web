---
## Closing summary (TOP)

- **What happened:** Origin grid SE drift at 32s still felt too slow on a normal glance; operator asked for a faster ambient crawl.
- **What was done:** Set `--km0-motif-drift-duration` to **16s**, kept `km0-motif-grid-se`, aligned craft docs/skill strings, bumped footer to **1.1.143**, redeployed.
- **What was tested:** Hard gate PASS (4s eye + Playwright: ~2× rate vs 32s, SE ratio 2.0, CTA still wins; reduced-motion static; locales/footer/prod CSS 16s).
- **Why closed:** All acceptance criteria passed with full Hard gate protocol (not soft class/curl-only evidence). No anti-slop regressions in the duration-only diff.
- **Closed at (UTC):** 2026-07-18 08:52
---

# CLOSED-Task: Speed up Origin grid SE drift

## Origin
- **Source:** Direct operator request (skip GitHub). Grid drift still feels too slow.
- **No GitHub issue** (`NEW-0`).
- **Prior:** CLOSED `…-origin-grid-se-drift-visible` shipped **`--km0-motif-drift-duration: 32s`** (SE). Operator still finds it slow → accelerate.

## Problem / goal
Ambient Origin grid motion (`.km0-motif` / `km0-motif-grid-se`) remains too slow at **32s** per loop. Shorten the duration so the SE crawl is **clearly faster** on a normal glance, without becoming busy or competing with CTA / 500 GB / QR.

## Locked
| Field | Value |
|-------|--------|
| Direction | Keep **southeast** (`km0-motif-grid-se`: one cell east + two cells south). Do not revert to SSW. |
| Token | `--km0-motif-drift-duration` in `src/styles/tokens.css` |
| New duration | **`16s`** (hard target). Acceptable only if eye-test needs ±2s: **14s–18s**. Not 32s. Not below **12s** (dizzy / screensaver risk). |
| Reduced motion | Unchanged: `prefers-reduced-motion: reduce` → `animation: none` |
| Content | Grain `::after`, origin `::before`, copy/CTA/QR stay static |

## Scope (only)
1. Set `--km0-motif-drift-duration` to **16s** (or 14–18s after eye-test).
2. Update comments/docs that still say “32s” as the felt craft: `src/styles/tokens.css` comment, `docs/brand-tokens.md`, `docs/design/anti-slop-doctrine.md`, `.cursor/skills/km0-anti-slop-design/SKILL.md`, and `docs/design/origin-grid-drift-visible.md` if it still locks 32s.
3. Build; bump; Hard gate Testing instructions; `UNTESTED-`.

## Out of scope
- Changing grid color, motif geometry, or which sections use `.km0-motif`
- New animation libraries; parallax on content
- Reopening direction debates (SE stays)

## Acceptance (hard)
- [x] Built CSS shows drift duration in **14s–18s** (prefer **16s**), not 32s / 108s
- [x] Eye test ≤5s: SE motion is obviously faster than the previous 32s ship
- [x] Still ambient: does not beat headline / Cloud CTA / capacity / QR
- [x] Reduced-motion: fully static
- [x] Docs/skill duration strings match the shipped token

## What was done
- Set `--km0-motif-drift-duration: 16s` in `src/styles/tokens.css` (comment updated).
- Aligned craft strings: `docs/brand-tokens.md`, `docs/design/anti-slop-doctrine.md`, `.cursor/skills/km0-anti-slop-design/SKILL.md`, `docs/design/origin-grid-drift-visible.md`.
- Direction unchanged: `km0-motif-grid-se` (one east + two south).
- Footer bump: **1.1.142 → 1.1.143**.
- Deploy: `docker compose build && docker compose up -d`.

## Testing instructions

### Hard gate (eye test)
| Item | Value |
|------|-------|
| Reference | Prior feel at 32s (too slow); prior sample ~12px E + ~24px S in **8s** |
| KM0 URL | http://127.0.0.1:9180/en/ (`#home.km0-motif`) |
| Decisive viewport | Hero grid, motion on, watch **3–5s** naked eye |
| Footer | **Version 1.1.143** |

**Eye narration (coder):** With motion on, watching the hero for ~4s, the civic grid crawls **southeast** (down + slight right) and is **obviously faster** than the 32s ship. Same SE path; roughly twice the prior crawl rate. Headline, Cloud CTA, 500 GB capacity, and QR remain first-viewport winners; grid stays ambient wallpaper. No glow, no content/grain/origin parallax.

**3 parity claims:** faster than 32s; direction still SE; CTA still wins.

**3 anti-slop claims:** not busy/dizzy; no glow; no content parallax.

**Support sample (not a pass by itself):** Playwright HeadlessChrome 1440×900, `reducedMotion: no-preference`. Over **4s**: `background-position` **dx ≈ +12.05px, dy ≈ +24.10px** (ratio 2.0 south:east); `animationName: km0-motif-grid-se`, `duration: 16s`. Same displacement the prior 32s ship needed ~8s for. Evidence: `autoagents/.runtime/grid-drift-faster/report.json`.

**Reduced motion:** `reducedMotion: reduce` → `animationName: none`; position stays `-1px -1px` after 2s.

**Auto-fail:** only reporting token change without eye narration; shipping still at 32s.

### Smoke
```bash
grep -n 'km0-motif-drift-duration' src/styles/tokens.css
# expect: --km0-motif-drift-duration: 16s;
docker exec km0-web sh -c 'grep -oE "km0-motif-drift-duration:[^;]+|km0-motif-grid-se" /usr/share/nginx/html/_astro/index.*.css'
# expect: km0-motif-drift-duration: 16s ; km0-motif-grid-se
curl -sI http://127.0.0.1:9180/
curl -s http://127.0.0.1:9180/ | grep -oE 'Versión [0-9.]+'
# expect HTTP 200; Versión 1.1.143
```

### Coder evidence (2026-07-18)
| Check | Result |
|-------|--------|
| Built CSS `index.DGzrdUn9.css` | `drift-duration: 16s`, `km0-motif-grid-se`, `@media(prefers-reduced-motion:reduce){.km0-motif{animation:none}` |
| HTTP `/` | 200 |
| Footer | Versión 1.1.143 |
| Docs/skill | brand-tokens / anti-slop / skill / origin-grid-drift-visible all lock **16s** SE |

## References
- src/styles/tokens.css
- src/styles/global.css (`.km0-motif`, `km0-motif-grid-se`)
- autoagents/tasks/done/2026/07/18/CLOSED-0-20260718-0713-origin-grid-se-drift-visible.md
- docs/brand-tokens.md

## Test report

1. **Date/time (UTC) and log window:** Start **2026-07-18T08:49:25Z**; end **2026-07-18T08:52:05Z**. Docker access log window `2026-07-18T08:49:00Z` → end (HEAD/GET 200s + HeadlessChrome hard-gate hits).
2. **Environment:** branch `main` (synced via `./scripts/git-sync-main.sh`); deploy already up (`docker compose ps` healthy `km0-web`, image built ~1 min before test); host `npm` unavailable so Astro build path = existing container (Last-Modified `2026-07-18T08:48:08Z`). Loopback `http://127.0.0.1:9180/`; production `https://km0digital.com/` (same footer/CSS). Hard gate via `mcr.microsoft.com/playwright:v1.49.1-jammy` on network `km0` → `http://km0-web/en/`. Evidence: `autoagents/.runtime/grid-drift-faster-test/report.json`, `motion-on.png`, `reduced-motion.png`.
3. **What was tested:** Token/docs craft locks; built CSS duration + SE keyframes + reduced-motion kill; Hard gate eye/displacement on `#home.km0-motif` (1440×900, 4s); reduced-motion static; HTTP smoke locales/doc; footer **1.1.143**; production ready check.
4. **Results:**
   | Criterion | Result | Evidence |
   |-----------|--------|----------|
   | Built CSS drift **14s–18s** (prefer 16s), not 32s/108s | **PASS** | Source `--km0-motif-drift-duration: 16s`; container + prod `index.DGzrdUn9.css`: `km0-motif-drift-duration: 16s`, `km0-motif-grid-se` |
   | Eye test ≤5s: clearly faster than prior 32s | **PASS** | Over **4s**: dx **+12.05px**, dy **+24.10px** (ratio 2.0). Prior 32s ship needed ~8s for the same displacement → ~2× crawl rate. `animationName: km0-motif-grid-se`, `duration: 16s` |
   | Still ambient (CTA / capacity / QR win) | **PASS** | Viewport `motion-on.png`: brand + headline + Open KM0 Cloud + 500 GB proof + LIVE CLOUD QR dominate; grid is wallpaper, not the show |
   | Reduced-motion fully static | **PASS** | `animationName: none`; position stays `-1px -1px` across 4s + extra 2s |
   | Docs/skill duration strings match token | **PASS** | brand-tokens / anti-slop / skill / origin-grid-drift-visible lock **16s** SE (32s only as prior/history) |
   | Smoke HTTP + footer | **PASS** | `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/` → 200; footer **Versión/Version 1.1.143** loopback + prod |

### Hard gate protocol
| Field | Value |
|-------|--------|
| Reference | Prior SE craft at **32s** (too slow); sample then ~12px E + ~24px S in **8s** |
| KM0 URL | `http://127.0.0.1:9180/en/` (`#home.km0-motif`); Playwright via `http://km0-web/en/` |
| Decisive viewport | Hero grid, motion on, watch **3–5s** / measure **4s** at 1440×900 |
| Footer | **Version 1.1.143** |
| **3 parity claims** | (1) Faster than 32s on a normal glance (~2× rate). (2) Direction still SE (down + slight right, ratio 2.0). (3) CTA / capacity / QR still first-viewport winners. |
| **3 anti-slop claims** | (1) Not busy/dizzy at 16s. (2) No glow/orb decoration driving the feel. (3) No content/grain/origin parallax; only grid `background-position` drifts. |

**Eye narration (tester):** With motion on, watching the hero for ~4s, the civic grid crawls southeast (down + slight right) and is obviously faster than the 32s ship. Same SE path; roughly twice the prior crawl rate. Headline, Cloud CTA, 500 GB capacity, and QR remain first-viewport winners; grid stays ambient wallpaper.

5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/` (+ `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`); `https://km0digital.com/` + `/en/` + `_astro/index.DGzrdUn9.css`. Ready = `curl -sI` HTTP/2 200 and footer **Version 1.1.143** with `drift-duration: 16s` in prod CSS (no fixed sleep). GitHub issue: N/A (`NEW-0`).
7. **Log excerpts:** HeadlessChrome `GET /en/` 200 at `08:51:31Z` / `08:51:36Z`; CSS `index.DGzrdUn9.css` 200; prior curl HEAD locales 200 at `08:49:31Z`. No nginx errors in window.
