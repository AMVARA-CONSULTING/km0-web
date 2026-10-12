---
## Closing summary (TOP)

- **What happened:** Issue #153 asked to add the X account KMZdigital next to the existing GitHub icon in the site footer.
- **What was done:** Footer social row gained an X link (`https://x.com/KMZdigital`) with the official mark SVG immediately before GitHub; i18n `footer.x` in es/ca/en/de; site version bumped to 1.3.28.
- **What was tested:** Smoke locales 200; X+GitHub order, href/target/rel, version 1.3.28 on loopback and production `/en/`; anti-slop PASS (ink/signal peer styling, no purple/pills). Overall PASS. Not craft-parity; Hard gate N/A.
- **Why closed:** All testing criteria passed; anti-slop skim clean on the social row.
- **Closed at (UTC):** 2026-10-12 05:56
---

# [ideas/en] Add X account kmzdigital to webpage next to github icon

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/153
- **Number:** #153
- **Labels:** agent:wip
- **Created:** 2026-10-09T19:46:26Z

## Problem / goal
Add the X (Twitter) account https://x.com/KMZdigital to the site footer next to the existing GitHub icon/link.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/153
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- Footer social row: X link (`https://x.com/KMZdigital`) with official X mark SVG placed immediately before the existing GitHub link; same ink/50 → signal hover treatment, `gap-5` between the two.
- i18n: `footer.x` = `"X"` in es/ca/en/de; typed in `src/i18n/types.ts`.
- Site version bumped **1.3.27 → 1.3.28**.
- Pre-flight: quiet footer social row; existing right-column archetype; font-sans; ink + signal accent; refused pill clusters / purple icons / oversized social buttons.
- Pre-emit: P4 H4 E4 S4 R5 V4 (minimal match to GitHub peer; no new chrome).

## Testing instructions

### Smoke
1. `docker compose ps` shows `km0-web` up.
2. `curl -sI http://127.0.0.1:9180/en/` → 200.
3. Same for `/ca/`, `/de/`; `/` and `/doc/` may 302 (locale redirect).

### Footer X link (required)
1. Open `http://127.0.0.1:9180/en/` (also spot-check `/`, `/ca/`, `/de/`).
2. Scroll to footer. Confirm an **X** icon+label sits **next to** the **GitHub** icon+label (same row, right column on `md+`).
3. X `href` is exactly `https://x.com/KMZdigital`, `target="_blank"`, `rel="noopener noreferrer"`.
4. GitHub link still points to `https://github.com/AMVARA-CONSULTING/km0-web`.
5. Footer shows version **1.3.28**.
6. Optional: `curl -s http://127.0.0.1:9180/en/ | grep -o 'https://x.com/KMZdigital'` returns one match.

### Anti-slop
- No purple/indigo icon styling, no pill cluster of social buttons, no new card chrome; matches existing footer link density.

## Test report

1. **Date/time (UTC) and log window:** Start 2026-10-12T05:52:43Z (UNTESTED → TESTING + `agent:testing` on #153). Rebuild/up 05:53:23Z–05:53:26Z. Checks 05:53:48Z–05:54:20Z. Report close 2026-10-12T05:54:41Z. Docker log window 05:53:26Z–05:54:01Z.
2. **Environment:** Branch `main` (synced). Build: `docker compose build && docker compose up -d` (image cached; container recreated healthy). Loopback `http://127.0.0.1:9180/`. Production poll `https://km0digital.com/` (302 → locale; `/en/` 200 with X link). Not a craft-parity FEAT; Hard gate N/A.
3. **What was tested:** Smoke (container, locale HTTP), footer X+GitHub row (href/target/rel, order, label, version 1.3.28), anti-slop skim of social row, production readiness via live curl (X URL + footer version present).
4. **Results:**
   - **Smoke container up:** **PASS** - `docker compose ps` healthy on `127.0.0.1:9180->80/tcp` after recreate.
   - **Smoke `/en/` `/ca/` `/de/` 200:** **PASS** - HEAD 200 each; `/` and `/doc/` 302 locale redirect as allowed.
   - **X next to GitHub (same row, md+ right):** **PASS** - footer social `div` is `flex … gap-5 md:justify-end` with X anchor immediately before GitHub; label text `X`.
   - **X href/target/rel:** **PASS** - `href="https://x.com/KMZdigital" target="_blank" rel="noopener noreferrer"` on `/en/`, `/ca/`, `/de/`, and `/` (after redirect).
   - **GitHub unchanged:** **PASS** - still `https://github.com/AMVARA-CONSULTING/km0-web`.
   - **Footer version 1.3.28:** **PASS** - `1.3.28` in loopback HTML; `package.json` version `1.3.28`.
   - **Optional grep one match:** **PASS** - exactly one `https://x.com/KMZdigital` per locale page body.
   - **Anti-slop:** **PASS** - ink/50 + signal hover, `transition-colors` only (no `transition-all` / `scale-105`), no purple/indigo/violet, no pill cluster or new card chrome; Pre-emit P4 H4 E4 S4 R5 V4 recorded in Implementation summary.
   - **Production ready:** **PASS** - `curl -sI https://km0digital.com/` → 302; followed `/en/` contains `https://x.com/KMZdigital` and `1.3.28` (no fixed sleep; readiness = HTTP success + content match).
   - **GitHub label:** **PASS** - `agent:testing` on #153 at start; removed on PASS → CLOSED.
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/en/`, `/ca/`, `/de/`, `/doc/`; `https://km0digital.com/`, `https://km0digital.com/en/`.
7. **Log excerpts:** nginx start 05:53:26Z; HEAD/GET 200 for `/en/` `/ca/` `/de/` at 05:53:48Z; health Wget 200 `/en/` at 05:53:31Z and 05:54:01Z. No errors in window.
8. **GitHub:** label `agent:testing` on #153 at start; removed on PASS → CLOSED.
