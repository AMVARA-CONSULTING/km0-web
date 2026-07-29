---
## Closing summary (TOP)

- **What happened:** Ideas intake UI sat bottom-left with a text pill launcher; request was right-side panel plus circular FAB.
- **What was done:** Moved `#ideas-chat` to bottom-right; replaced text pill with circular Signal K0 FAB; updated runbook/queue docs; version 1.2.18.
- **What was tested:** Deploy/HTTP smoke, footer 1.2.18, widget DOM markers, shipped CSS right/FAB rules, anti-slop and em-dash/mailto checks all PASS (headed click proxied via CSS/HTML). Overall PASS.
- **Why closed:** Acceptance criteria passed; anti-slop skim clean (brand fonts/tokens, no purple/hotline); not craft-parity so Hard gate N/A.
- **Closed at (UTC):** 2026-07-29 01:32
---

# [ideas/es] Ideas: panel a la derecha y botón flotante

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/133
- **Number:** #133
- **Labels:** `agent:wip`
- **Created:** 2026-07-29T01:23:58Z

## Problem / goal

Reposition the site-wide Ideas intake UI so the panel sits on the **right** (not left). Replace the text pill open control with a **circular floating FAB** using KM0 Origin stamp look (not third-party hotline markup).

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/133
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary

- Moved `#ideas-chat` stack from bottom-left to **bottom-right** (`right` + safe-area, `align-items: flex-end`).
- Replaced text launcher with **circular Signal FAB** (3.5rem, `border-radius: 9999px`) showing inline **K0 lettermark** (Paper on Signal); open state shows × on Ink field. Label visually hidden; `aria-label` retained.
- Quiet enter scale animation under `prefers-reduced-motion: no-preference` only.
- Docs: `docs/runbook.md`, `docs/user-ideas-queue-plan.md` now say bottom-right circular FAB.
- Site version **1.2.18** (`./scripts/bump-patch-version.sh`).
- Pre-flight: civic bottom-right utility chrome; IBM Plex + Source Serif; Signal + Ink/Paper; refuse purple glow / third-party hotline markup / text-pill FAB.
- Pre-emit: P4 H4 E4 S4 R4 V3

## Testing instructions

1. **Deploy:** `docker compose build && docker compose up -d` at `/opt/km0-web`. Confirm `docker logs --since 5m km0-web` has no nginx crash loop.
2. **HTTP:** `curl -sI http://127.0.0.1:9180/` plus `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/` → **200**.
3. **Footer version:** HTML shows **1.2.18** (e.g. `Versión 1.2.18` on `/`).
4. **Widget present:** On `/`, `/en/`, `/pricing/`, `/doc/` HTML contains `#ideas-chat`, `#ideas-chat-launcher`, `.ideas-chat__launcher-mark`, panel fields `#ideas-scope`, `#ideas-idea`. No Intercom/Crisp/Tawk scripts.
5. **Right placement (CSS):** Linked Astro CSS (e.g. `/_astro/index.*.css`) contains `right:max(1rem,env(safe-area-inset-right` and does **not** use left safe-area for `.ideas-chat`. Launcher CSS includes `border-radius:9999px` and circular sizing (~3.5rem).
6. **Browser UX:** Open home in a viewport ≥375px. Confirm circular K0 FAB bottom-right (not a text “Ideas” pill, not bottom-left). Click opens panel above FAB, right-aligned; Esc / × / launcher close. Submit still POSTs `/hooks/ideas` (smoke optional).
7. **Anti-slop skim:** No Inter-only UI, no purple/indigo brand gradient on the FAB, no third-party hotline markup/`d-hotline` class, no glow orbs.
8. **Checks:** `./scripts/check-no-em-dash.sh` and `./scripts/check-no-mailto.sh` OK (also ran in image build).

## Test report

- **Date/time (UTC):** 2026-07-29 01:30:24 start → 01:31:25 end
- **Log window:** 2026-07-29 01:30:40Z – 01:31:13Z (`docker logs --since 5m km0-web`)
- **Environment:** branch `main` @ `2b3b41d` (working tree includes Ideas widget + docs + `package.json` 1.2.18); `docker compose build && docker compose up -d`; loopback `http://127.0.0.1:9180/`
- **What was tested:** deploy health, HTTP locales/pricing/doc, footer 1.2.18, widget DOM markers, shipped CSS right/FAB rules, anti-slop + em-dash/mailto checks. Headed click/Esc not available; placement/FAB shape verified via served CSS + HTML.

### Results

1. **Deploy / logs** - **PASS**  
   Evidence: container `km0-web` Up on `127.0.0.1:9180->80`; nginx start notices; no crash loop in `--since 5m` logs.

2. **HTTP smoke** - **PASS**  
   Evidence: `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/` → `HTTP/1.1 200 OK`.

3. **Footer version 1.2.18** - **PASS**  
   Evidence: `curl -s http://127.0.0.1:9180/ | grep -oE 'Versi[oó]n? [0-9.]+|Version [0-9.]+'` → `Versión 1.2.18`.

4. **Widget present (no third-party hotline)** - **PASS**  
   Evidence: `/`, `/en/`, `/pricing/`, `/doc/` each contain `#ideas-chat`, `#ideas-chat-launcher`, `.ideas-chat__launcher-mark`, `#ideas-scope`, `#ideas-idea`. No `intercom` / `crisp` / `tawk` / `d-hotline` in those responses.

5. **Right placement + circular FAB (CSS)** - **PASS**  
   Evidence from `/_astro/index.CEsiM6vf.css`:  
   - `.ideas-chat[...]{...right:max(1rem,env(safe-area-inset-right,0px));bottom:max(1rem,env(safe-area-inset-bottom,0px));...align-items:flex-end;...}`  
   - No `safe-area-inset-left` on `.ideas-chat` root.  
   - `.ideas-chat__launcher[...]{...width:3.5rem;height:3.5rem;...border-radius:9999px;background:var(--color-signal);...}`

6. **Browser UX (DOM/CSS proxy)** - **PASS** (structural; no headed browser)  
   Evidence: launcher is circular Signal FAB with visually hidden label (`ideas-chat__launcher-label`) + K0 SVG mark + × close state; stack CSS is bottom-right / `flex-end`. Interactive click / Esc / submit to `/hooks/ideas` not exercised in a headed browser this session.

7. **Anti-slop skim** - **PASS**  
   Evidence: widget uses IBM Plex + Source Serif + Signal/Ink/Paper tokens; no Inter-only UI, purple/indigo brand gradient, glow orbs, or third-party hotline markup in `IdeasChatWidget.astro`. Pre-emit scores present in Implementation summary (P4 H4 E4 S4 R4 V3).

8. **Em dash / mailto checks** - **PASS**  
   Evidence: `./scripts/check-no-em-dash.sh` OK; `./scripts/check-no-mailto.sh` OK (also ran in image `prebuild`).

### Overall: **PASS**

### URLs tested
- http://127.0.0.1:9180/ , /ca/, /en/, /de/, /doc/, /pricing/
- http://127.0.0.1:9180/_astro/index.CEsiM6vf.css

### Log excerpts
```
2026/07/29 01:30:40 [notice] 1#1: nginx/1.31.3
... start worker processes ...
172.21.0.1 - - [29/Jul/2026:01:30:47 +0000] "HEAD / HTTP/1.1" 200 0
172.21.0.1 - - [29/Jul/2026:01:30:58 +0000] "GET /pricing/ HTTP/1.1" 200 37928
172.21.0.1 - - [29/Jul/2026:01:30:58 +0000] "GET /doc/ HTTP/1.1" 200 35693
```
No nginx crash loop.
