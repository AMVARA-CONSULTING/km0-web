---
## Closing summary (TOP)

- **What happened:** Optional civic dark theme (system + Light/Dark toggle, light Paper default) shipped and verified under craft-parity hard gate.
- **What was done:** Semantic light/dark token remap, FOUC-safe boot + header Theme cycle with persistence, reading surfaces included; site version advanced with sequential craft bumps (footer **1.1.128** at test).
- **What was tested:** Hard gate PASS vs Stirling discipline: Theme cycle remaps canvas, Auto follows OS without dark-first on light OS, Dark/Light persists on home/doc/tutorials/pricing; anti-slop (no purple glow / Inter-only / SaaS hero) held; HTTP 200 + Theme markers on loopback and prod.
- **Why closed:** All hard-gate parity and anti-slop claims passed with side-by-side / computed-style evidence (not class-only).
- **Closed at (UTC):** 2026-07-18 00:11
---

# FEAT-Task: Optional dark theme (system + toggle, light default)

## GitHub Issue
- **Number:** #96
- **Title:** Craft parity: optional dark theme (system + toggle, light default)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/96
- **Labels:** enhancement, agent:untested → agent:testing → CLOSED (verified)

## Problem / goal
Ship optional civic dark theme. Light Paper remains default for light OS preference. No purple-glow AI lab. Cover marketing + reading surfaces.

## Spec
- `docs/design/craft-parity-phase.md` (Hard gate protocol)
- `docs/brand-tokens.md`
- `docs/design/anti-slop-doctrine.md` ban #11 (optional dark allowed; dark-first banned)

## High-level instructions for coder
1. Add semantic light/dark tokens (Ink/Paper/Snow/Signal remap). One brand, two schemes.
2. `prefers-color-scheme` when no user override; header Light/Dark/System (or equivalent); persist preference.
3. Apply sitewide including `reading.css` blog/tutorials.
4. `color-scheme`, focus-visible, contrast; i18n control labels es/ca/en/de.
5. No dark default for light-OS visitors; no neon/orbs/Nous-only look.
6. Build; `./scripts/bump-patch-version.sh`; gh #96.

## Acceptance (hard)
- Toggle works on home + `/doc/` + `/tutorials/` + pricing
- Persistence survives reload
- System preference respected until override
- Hard gate protocol in Testing instructions (not class-only)

## Implementation notes (coder)
- Semantic remap in `src/styles/tokens.css` via `html[data-theme='dark']` (Ink/Paper/Snow/Signal/Mist + surface-ink/code).
- Tailwind colors now use `rgb(var(--rgb-*) / <alpha-value>)` so utilities follow the scheme.
- FOUC-safe boot script in `Layout.astro`; controller `src/scripts/theme.ts`; header Theme cycle System → Light → Dark (`localStorage` key `km0-theme`).
- i18n theme strings in es/ca/en/de; brand-tokens Color schemes table updated.
- Site version bumped to **1.1.124**.

## Testing instructions

### Hard gate protocol

1. **Reference URL(s)** (same session):
   - https://stirling.com/ (discipline for optional calm dark / product chrome confidence, not pixel clone)
   - Optional: OS Settings → Appearance dark/light to validate System mode

2. **KM0 URL(s)** (after `docker compose build && docker compose up -d`):
   - http://127.0.0.1:9180/en/ (home)
   - http://127.0.0.1:9180/en/doc/ (blog reading)
   - http://127.0.0.1:9180/en/tutorials/ (tutorials reading)
   - http://127.0.0.1:9180/en/pricing/

3. **Three parity claims** (non-dev visible):
   - Header **Theme** control cycles **Auto → Light → Dark → Auto**; label updates; page canvas and masthead remaps immediately (Paper navy canvas + cool light Ink text in Dark).
   - With preference **Auto/System** and no `localStorage` override, a light-OS visitor stays on light Paper; a dark-OS visitor resolves to dark without forcing dark on light OS.
   - Choosing **Dark** (or **Light**) persists across reload (`localStorage` `km0-theme`) on home, `/doc/`, `/tutorials/`, and `/pricing/` - same scheme, not a second brand.

4. **Three anti-slop claims** (what was refused):
   - No purple/indigo glow, neon orbs, or Nous-underground-only dark.
   - No dark-mode-first default for light-OS visitors (light Paper remains default under System + light OS).
   - No Inter-only / centered SaaS hero / zebra bands introduced by the theme work.

5. **Decisive viewport evidence** (screenshot or HTML inspection + narration):
   - Path: `/en/` first viewport with Theme set to **Dark**.
   - Look for: `html[data-theme="dark"]`, cool navy Paper canvas (`#0B1220` family), light Ink text, Signal teal still the sole accent, masthead Theme short label **Dark**, footer Version **1.1.124**.
   - Also open `/en/doc/` and `/en/tutorials/` in Dark and confirm reading column (body text, code blocks via `--surface-code`) stays readable without purple bloom.
   - Class-list-only evidence (e.g. “has `data-theme-cycle`”) without side-by-side / visual narration = **FAIL**.

### Smoke checks
```bash
curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/doc/ http://127.0.0.1:9180/tutorials/ http://127.0.0.1:9180/pricing/
curl -s http://127.0.0.1:9180/en/ | grep -E 'data-theme-cycle|km0-theme|1\.1\.124'
docker logs --since 10m km0-web
```

### Browser checklist
- [ ] Light OS + System: page is light Paper
- [ ] Cycle to Dark: home remaps; reload keeps Dark
- [ ] `/doc/`, `/tutorials/`, `/pricing/` respect same preference
- [ ] Cycle to Light: forced light even if OS is dark
- [ ] Cycle to Auto: follows OS again
- [ ] Focus-visible on Theme button uses Signal outline
- [ ] No mailto / no em dash regressions

## References
- docs/design/craft-parity-phase.md
- https://stirling.com/ (discipline, not pixels)
- docs/runbook.md

## Test report

1. **Date/time (UTC) and log window**
   - Start: 2026-07-18 00:08:50 UTC
   - End: 2026-07-18 00:10:52 UTC
   - Log window: `docker logs --since 15m km0-web` (nginx up at 00:09:11 UTC; 200s for tested paths)

2. **Environment**
   - Branch: `main` (synced via `./scripts/git-sync-main.sh`)
   - Build: `docker compose build && docker compose up -d` (Astro build inside image; package version **1.1.128**)
   - Loopback: `http://127.0.0.1:9180/`
   - Production: `https://km0digital.com/` (HTTP/2 200; Theme markers present; footer Version 1.1.128)
   - Ready signal: polled loopback until GET `/` returned 200; prod HEAD/GET also 200 with `data-theme-cycle` + `km0-theme` in HTML (no fixed sleep)

3. **What was tested**
   - Hard gate protocol vs Stirling discipline + Playwright computed-style / screenshot evidence on KM0
   - Theme cycle, system preference, persistence, reading surfaces, anti-slop, smoke HTTP, i18n labels, no-mailto / no-em-dash

4. **Results**

### Hard gate protocol

| Item | Result | Evidence |
|------|--------|----------|
| Reference URL(s) | **PASS** | Opened https://stirling.com/ in session (calm product chrome discipline; not pixel clone) |
| KM0 URL(s) | **PASS** | `/en/`, `/en/doc/`, `/en/tutorials/`, `/en/pricing/` all 200 on loopback; prod `/en/` 200 with Theme control |
| Parity 1: Theme cycles Auto → Light → Dark → Auto; canvas remaps | **PASS** | Playwright on light OS: click cycle → `Light` (Paper `#EEF0F2` / ink navy) → `Dark` (Paper `rgb(11,18,32)`, ink `rgb(230,233,237)`, Signal `rgb(45,212,191)`) → `Auto` again. Masthead short label updates. Screenshot `autoagents/.runtime/theme-dark-en-home.png`: navy canvas, Theme **Dark**, teal Signal CTA, no purple bloom |
| Parity 2: Auto/System follows OS; light OS stays light | **PASS** | `colorScheme:light` + no storage → `theme=light`, `themePref=system`, body `rgb(238,240,242)`. `colorScheme:dark` + no storage → `theme=dark`, body `rgb(11,18,32)`. Forced `light` overrides dark OS; forced `dark` overrides light OS |
| Parity 3: Dark/Light persists across reload on home + reading + pricing | **PASS** | After setting Dark, reload keeps `storage=dark`, `theme=dark`, short **Dark**. Same scheme on `/en/doc/`, `/en/tutorials/`, `/en/pricing/`, `/en/doc/day-0/` (`--surface-code` `rgb(5 8 15)`, readable ink on navy Paper) |
| Anti-slop 1: no purple/indigo glow / neon orbs | **PASS** | Served CSS: 0 matches for purple/indigo/violet/#7c3aed; dark Signal is teal `45 212 191`; screenshot shows teal accent only |
| Anti-slop 2: not dark-first for light OS | **PASS** | Default with empty `localStorage` + light OS = light Paper; boot script defaults catch → light |
| Anti-slop 3: no Inter-only / centered SaaS hero / zebra from theme | **PASS** | Fonts still Bricolage + IBM Plex + Source Serif; hero remains brand + headline + support + CTA + product proof; doctrine comments forbid nth-child zebra; theme work remaps tokens only |
| Decisive viewport | **PASS** | Dark `/en/` first viewport: `html[data-theme=dark]`, Paper navy `#0B1220` family, light Ink text, Signal teal accent, masthead Theme **Dark**, footer Version **1.1.128** (task note said 1.1.124; sequential craft bumps #97–#100 advanced patch in same tree; theme feature present) |

### Smoke / checklist

| Criterion | Result | Evidence |
|-----------|--------|----------|
| HTTP 200 home/locales/doc/tutorials/pricing | **PASS** | curl HEAD all 200 on :9180 |
| Theme markers in HTML | **PASS** | `data-theme-cycle`, `km0-theme` boot, short labels Auto/Light/Dark (es/ca/en/de localized) |
| Focus-visible Theme uses Signal | **PASS** | Built CSS `.masthead__theme:focus-visible{outline:2px solid var(--color-signal` |
| No mailto / no em dash | **PASS** | prebuild checks OK; re-ran both scripts OK |
| GitHub label `agent:testing` | **PASS** | Applied on issue #96 at test start |

5. **Overall: PASS**

6. **URLs tested**
   - https://stirling.com/ (reference)
   - http://127.0.0.1:9180/ , `/en/`, `/ca/`, `/de/`, `/doc/`, `/en/doc/`, `/en/doc/day-0/`, `/en/tutorials/`, `/en/pricing/`, `/tutorials/`, `/pricing/`
   - https://km0digital.com/ , https://km0digital.com/en/

7. **Log excerpts** (`km0-web`, UTC)
```
2026/07/18 00:09:11 [notice] 1#1: nginx/1.31.3
127.0.0.1 - - [18/Jul/2026:00:09:16 +0000] "GET / HTTP/1.1" 200
172.21.0.1 - - [18/Jul/2026:00:09:21 +0000] "HEAD /en/ HTTP/1.1" 200
172.21.0.1 - - [18/Jul/2026:00:09:22 +0000] "HEAD /en/doc/ HTTP/1.1" 200
172.21.0.1 - - [18/Jul/2026:00:09:22 +0000] "HEAD /en/tutorials/ HTTP/1.1" 200
172.21.0.1 - - [18/Jul/2026:00:09:22 +0000] "HEAD /en/pricing/ HTTP/1.1" 200
```

8. **GitHub:** label `agent:testing` applied on issue #96 at test start.
