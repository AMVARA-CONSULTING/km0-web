---
## Closing summary (TOP)

- **What happened:** Runtime tokens and agent training still encoded Inter + purple/pink brand gradients despite doctrine docs.
- **What was done:** Swapped tokens.css, Tailwind, layout fonts, and global accents to Ink/Paper/Signal with Bricolage + Source Serif 4 + IBM Plex Sans; removed brand-gradient and Inter. Doctrine/skills/rules confirmed and referenced from agent-loop.
- **What was tested:** PASS - Docker build, HTTP 200 locales/doc, fonts without Inter, no purple hex/brand-gradient, Signal present, em dash OK, footer 1.1.106.
- **Why closed:** All acceptance criteria passed; no anti-slop regressions on skim.
- **Closed at (UTC):** 2026-07-17 18:50
---

# FEAT-Task: Anti-slop agent training sync + design system tokens

## GitHub Issue
- **Number:** #73
- **Title:** (see issue)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/73
- **Labels:** agent:untested
- **Depends / notes:** see body; run remodel epic in order

## Problem / goal

Agents and the live site still encode the Tailwind/AI median look (Inter + multi-stop pink/purple/blue gradient). Doctrine, skills, and rules now live under `.cursor/` and `docs/design/`, but **runtime tokens** (`tokens.css`, `tailwind.config.mjs`, layout font loading) must match `docs/brand-tokens.md` so later FEATs do not keep shipping slop.

## High-level instructions for coder

1. Read **`docs/design/anti-slop-doctrine.md`**, **`docs/brand-tokens.md`**, skills **`km0-anti-slop-design`** + **`km0-web-copy`**.
2. Confirm `.cursor/skills/km0-anti-slop-design/`, `.cursor/skills/km0-web-copy/`, `.cursor/rules/anti-slop-frontend.mdc`, `.cursor/rules/web-copy.mdc` exist in this repo. If this checkout is production `km0-web` without them, copy from stage/`docs` as needed - do not invent a second doctrine.
3. Implement **target tokens** in:
   - `src/styles/tokens.css` (Ink / Paper / Snow / Signal / Mist; retire gradient-brand chain)
   - `tailwind.config.mjs` (font families display/body/ui; Signal color; **remove** `brand-gradient` purple chain)
   - Layout font loading (`src/layouts/`): Bricolage Grotesque + Source Serif 4 + IBM Plex Sans per brand-tokens
   - `src/styles/global.css`: replace `.text-gradient`, `.btn-primary` pill-gradient, Inter assumptions with Signal solid / new type roles
4. Do **not** remodel every landing section yet - only shared foundation so the site still builds and is not more broken than before. Temporary visual inconsistency is OK if documented in the task Implementation summary.
5. Update README brand/colors pointers if they still praise Inter + rainbow gradient.
6. `npm run build` (or docker build per runbook). `./scripts/bump-patch-version.sh` once before UNTESTED.
7. Comment on #73; label agent:planned already / agent:wip when starting.

## Acceptance

- No Inter as `fontFamily.sans` sole stack
- No `#7B3FE4` / `#E040A0` / indigo brand gradient utilities left as primary accents
- Doctrine + skills + rules present and referenced from `docs/agent-loop.md` / coder prompts
- Build green

## Implementation summary

- Confirmed doctrine/skills/rules present; extended `docs/agent-loop.md` with brand-tokens + rule paths.
- Runtime tokens: Ink/Paper/Snow/Signal/Mist in `src/styles/tokens.css`; legacy `navy`/`surface` aliases kept.
- Tailwind: `font-display` (Bricolage), `font-body` (Source Serif 4), `font-sans` (IBM Plex); Signal colors; **removed** `brand-gradient`.
- Layout loads Bricolage + Source Serif 4 + IBM Plex Sans (no Inter).
- Global: `.text-gradient` -> solid Signal; `.btn-primary` -> Signal `rounded-md` (no pill gradient); doc accents/steps/callouts use Signal.
- Replaced leftover purple/orange brand-chain accents in Hero, Services, CloudUserStats (counter kept, Signal solid), Meaning icons, Meeting calendar/cards, Pricing, Presentation, favicon, `logo.svg`.
- README no longer praises rainbow gradient.
- Em dashes scrubbed from remodel docs/skills/tasks so `check-no-em-dash` passes.
- Version bump: **1.1.101 -> 1.1.102**.
- **Temporary inconsistency (OK for this FEAT):** landing IA/layout still centered SaaS-ish; full remodel is FEAT-74/75+. Raster `logo.png` / OG assets may still look old until a later asset pass.

## Testing instructions

1. `docker compose build && docker compose up -d` (or confirm container already on 1.1.102).
2. HTTP 200: `curl -sI http://127.0.0.1:9180/` and `/ca/`, `/en/`, `/de/`, `/doc/`.
3. Footer shows **Versión 1.1.102** (or locale equivalent).
4. Home HTML includes Google Fonts for Bricolage / Source Serif / IBM Plex; **no** `Inter:wght` stylesheet.
5. Grep deployed home (or `dist/`) for `#7B3FE4`, `#E040A0`, `brand-gradient`: zero matches in CSS/HTML; Signal `#0F766E` present on accents/CTAs.
6. Visual smoke: primary buttons and accent "0" / headings use teal, not rainbow gradient; Cloud user counter still visible and teal (not animated purple gradient).
7. `./scripts/check-no-em-dash.sh` exits 0.

## References
- `docs/design/anti-slop-doctrine.md`
- `docs/brand-tokens.md`
- https://www.usehallmark.com/
- https://prg.sh/ramblings/Why-Your-AI-Keeps-Building-the-Same-Purple-Gradient-Website

## Test report

1. **Date/time (UTC):** 2026-07-17T18:46:43Z – 2026-07-17T18:47:39Z. Log window: nginx access from 18:46:59Z (container start) through 18:47:26Z.
2. **Environment:** branch `main` @ `6edfc07`; build via `docker compose build && docker compose up -d` (`km0-web@1.1.106`, 124 pages). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** Docker build/deploy, HTTP smoke (locales + doc), footer version, Google Fonts (Bricolage / Source Serif 4 / IBM Plex Sans vs Inter), purple/brand-gradient purge + Signal `#0f766e` in CSS, btn-primary / cloud-users smoke, doctrine/skills/rules + agent-loop refs, em dash check, production parity.
4. **Results:**
   - Docker build & deploy: **PASS** (`124 page(s) built`, container Up on `127.0.0.1:9180`)
   - Em dash check: **PASS** (`check-no-em-dash: OK`)
   - HTTP smoke (`/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`): **PASS** (all 200)
   - Footer version: **PASS** (`Versión 1.1.106`; task noted 1.1.102, later remodel FEATs bumped further)
   - Fonts: **PASS** (Google Fonts CSS loads Bricolage + IBM Plex Sans + Source Serif 4; no `Inter:wght`; Tailwind `sans` = IBM Plex)
   - No Inter as sole `fontFamily.sans`: **PASS**
   - No `#7B3FE4` / `#E040A0` / `brand-gradient` in src or deployed CSS: **PASS** (zero matches)
   - Signal `#0f766e` present in deployed `_astro/*.css` (30 hits): **PASS**; home uses `btn-primary` / `text-signal` / `.text-gradient` → solid Signal
   - Cloud user counter (`#cloud-users` / `#cloud-users-heading`): **PASS** (present on home)
   - Doctrine + skills + rules present; referenced from `docs/agent-loop.md`: **PASS**
   - Production readiness: **PASS** (`https://km0digital.com/` HTTP 200 on first poll; footer `Versión 1.1.106`; Bricolage present; Signal in CSS; no Inter / purple hex)
   - GitHub label `agent:testing` on issue #73: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`, `/_astro/*.css`; `https://km0digital.com/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.106 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   18:46:57 [build] 124 page(s) built in 4.06s
   2026/07/17 18:46:59 [notice] 1#1: start worker processes
   172.21.0.1 - - [17/Jul/2026:18:47:11 +0000] "HEAD / HTTP/1.1" 200 0
   172.21.0.1 - - [17/Jul/2026:18:47:11 +0000] "HEAD /ca/ HTTP/1.1" 200 0
   172.21.0.1 - - [17/Jul/2026:18:47:11 +0000] "HEAD /en/ HTTP/1.1" 200 0
   172.21.0.1 - - [17/Jul/2026:18:47:11 +0000] "HEAD /de/ HTTP/1.1" 200 0
   172.21.0.1 - - [17/Jul/2026:18:47:11 +0000] "HEAD /doc/ HTTP/1.1" 200 0
   ```
8. **GitHub:** label `agent:testing` applied on issue #73 at test start.
