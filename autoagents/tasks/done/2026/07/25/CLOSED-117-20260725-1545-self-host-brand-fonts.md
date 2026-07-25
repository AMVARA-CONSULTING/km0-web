---
## Closing summary (TOP)

- **What happened:** PageSpeed refused the Google Fonts stylesheet on production (MIME `text/html`), so brand faces failed under strict checking.
- **What was done:** Vendored OFL woff2 under `public/fonts/`, added local `@font-face` in `src/styles/fonts.css`, removed Google Fonts CDN from `Layout.astro`, bumped site to **1.2.11**. Brand pairing (Bricolage / Source Serif 4 / IBM Plex) unchanged.
- **What was tested:** Tester PASS: locale HTTP 200; zero `fonts.googleapis` / `fonts.gstatic` hits; woff2 `Content-Type: font/woff2`; CSS `/fonts/` urls; footer 1.2.11; computed stacks still brand faces; production spot-check matched.
- **Why closed:** All testing criteria passed; anti-slop skim OK (no Inter-only swap, no purple/SaaS hero regressions; font plumbing only, not craft parity).
- **Closed at (UTC):** 2026-07-25 15:56
---

# Self-host brand fonts (fix Google Fonts MIME / PageSpeed)

## GitHub Issue
- **Number:** #117
- **Title:** Self-host brand fonts (fix Google Fonts MIME / PageSpeed)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/117
- **Labels:** agent:wip → agent:untested → agent:testing → CLOSED (pass)

## Problem / goal

PageSpeed Insights refuses the Google Fonts stylesheet on `https://km0digital.com/` because the response MIME type is `text/html` (not CSS), so brand fonts fail to apply under strict MIME checking.

**Goal:** self-host Bricolage Grotesque, IBM Plex Sans, and Source Serif 4 locally; remove Google Fonts CDN links from the public site. Keep brand pairing from `docs/brand-tokens.md`. Do not replace with Inter or system-only as the design fix.

## High-level instructions for coder

- Read full issue: https://github.com/AMVARA-CONSULTING/km0-web/issues/117
- Current remote load: `src/layouts/Layout.astro` (`fonts.googleapis.com` / `fonts.gstatic.com` preconnect + CSS link for the three brand families).
- Prefer **vendored woff2** under something like `public/fonts/` or `src/assets/fonts/` plus `@font-face` in CSS (`src/styles/` / tokens), wired to existing Tailwind `fontFamily.display` / `body` / `sans` names. Avoid new host OS packages. Prefer no new npm font packages unless clearly simpler than vendoring; if you add npm deps, keep them minimal and justified.
- Remove all Google Fonts `<link>` and preconnect from marketing layouts. Confirm built HTML / network has zero `fonts.googleapis.com` / `fonts.gstatic.com` on home and locale pages.
- Keep weights already used (400/500/600/700; variable/optical axes only if already relied on). License: OFL faces are fine to self-host; keep attribution if required by the font license files.
- Do **not** change brand faces to Inter / Roboto / generic stacks. Email templates (`email-templates/**`) are out of scope unless a one-line note is useful.
- Follow anti-slop / brand tokens: `docs/brand-tokens.md`, `docs/design/anti-slop-doctrine.md`.
- Run `./scripts/bump-patch-version.sh` once before UNTESTED-.
- Verify: `npm run build`, `docker compose build && docker compose up -d`, curl locales on `127.0.0.1:9180`, check footer version, spot-check computed `font-family` still Bricolage / Source Serif / IBM Plex.

## Implementation summary

- Vendored OFL woff2 under `public/fonts/` (latin + latin-ext): Bricolage Grotesque variable wght, Source Serif 4 variable wght + italic, IBM Plex Sans static 400/500/600/700. Attribution in `public/fonts/README.md`. No new npm deps.
- Added `src/styles/fonts.css` with `@font-face` using Tailwind family names (`Bricolage Grotesque`, `Source Serif 4`, `IBM Plex Sans`); imported from `global.css`.
- Removed Google Fonts preconnect + stylesheet from `src/layouts/Layout.astro`; added preload for the three primary latin files.
- Site version bumped **1.2.10 → 1.2.11**.
- Email templates left unchanged (out of scope).
- Pre-flight: civic editorial type fix only; layout unchanged; type = Bricolage + Source Serif + IBM Plex; Signal teal; refused Inter/system-only and CDN fallback as the fix.
- Pre-emit: P5 H5 E5 S5 R5 V4 (delivery is font plumbing; visual pairing unchanged).

## Testing instructions

1. **HTTP smoke (local container):**
   ```bash
   for p in / /ca/ /en/ /de/ /doc/; do curl -sI -o /dev/null -w "%{http_code} $p\n" "http://127.0.0.1:9180$p"; done
   ```
   Expect **200** on all.

2. **No Google Fonts CDN in marketing HTML:**
   ```bash
   for p in / /ca/ /en/ /de/; do
     echo -n "$p "; curl -s "http://127.0.0.1:9180$p" | grep -cE 'fonts\.googleapis|fonts\.gstatic' || true
   done
   ```
   Expect **0** hits on each locale home.

3. **Self-hosted fonts serve with font MIME:**
   ```bash
   curl -sI http://127.0.0.1:9180/fonts/bricolage-grotesque-latin-wght-normal.woff2 | tr -d '\r' | grep -iE 'HTTP/|content-type'
   curl -sI http://127.0.0.1:9180/fonts/source-serif-4-latin-wght-normal.woff2 | tr -d '\r' | grep -iE 'HTTP/|content-type'
   curl -sI http://127.0.0.1:9180/fonts/ibm-plex-sans-latin-400-normal.woff2 | tr -d '\r' | grep -iE 'HTTP/|content-type'
   ```
   Expect **200** and **Content-Type: font/woff2** (not text/html).

4. **CSS wires local @font-face:**
   ```bash
   css=$(curl -s http://127.0.0.1:9180/ | grep -oE '/_astro/[^"]+\.css' | while read u; do curl -s "http://127.0.0.1:9180$u" | grep -q '@font-face' && echo "$u" && break; done)
   echo "bundle=$css"
   curl -s "http://127.0.0.1:9180$css" | grep -oE 'url\(/fonts/[^)]+\)' | sort -u
   ```
   Expect urls under `/fonts/` for all three families (latin + latin-ext; Source Serif italic included).

5. **Footer version:** footer shows **1.2.11** (e.g. `curl -s http://127.0.0.1:9180/ | grep -oE 'Versión [0-9.]+'`).

6. **Browser / DevTools eye-check (required):**
   - Open `http://127.0.0.1:9180/en/` (or production after deploy).
   - Network: zero requests to `fonts.googleapis.com` / `fonts.gstatic.com`.
   - Computed style on hero brand/H1 → **Bricolage Grotesque**; body copy → **Source Serif 4**; nav/CTA → **IBM Plex Sans**.
   - No console MIME refusal for a Google Fonts stylesheet.

7. **Anti-slop:** brand faces unchanged (not Inter/Roboto/system-only). Email-templates Google Inter links remain out of scope.

Coder evidence (2026-07-25): locale HTTP 200; google-hits=0 on /,/ca/,/en/,/de/; woff2 Content-Type font/woff2; footer Versión 1.2.11; docker build green.

## References
- Runbook: docs/runbook.md
- Brand tokens: docs/brand-tokens.md
- Anti-slop: docs/design/anti-slop-doctrine.md
- Layout: src/layouts/Layout.astro
- Fonts CSS: src/styles/fonts.css
- Site: https://km0digital.com

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-25 15:54:32 UTC; end 2026-07-25 15:55:32 UTC. Docker window from container start 15:54:54Z through access checks ~15:55:14Z.
2. **Environment:** Branch `main` (working tree with self-host fonts ship). Build: `docker compose build && docker compose up -d` (host has no npm; build inside image `km0-web@1.2.11`, prebuild em-dash/mailto OK). Container `km0-web` healthy on `http://127.0.0.1:9180/`. Production `https://km0digital.com/` HEAD **200** on first poll (ready via immediate 200 + footer **Versión 1.2.11** + local `/fonts/*.woff2` MIME).
3. **What was tested:** Testing instructions 1–7 (HTTP smoke, zero Google Fonts CDN, woff2 MIME, CSS `@font-face` `/fonts/` urls, footer 1.2.11, computed font stacks / preload eye-check via HTML+CSS, anti-slop brand faces). Hallmark skim on ship diff. Production spot-check.
4. **Results:**
   - HTTP smoke `/` `/ca/` `/en/` `/de/` `/doc/`: **PASS** - all **200**. Also `/en/doc/day-0/` **200**.
   - No Google Fonts CDN in marketing HTML: **PASS** - grep hits **0** on `/` `/ca/` `/en/` `/de/`. Layout source has zero `fonts.googleapis` / `fonts.gstatic`. `/en/` head uses local preloads only (no google stylesheet/preconnect).
   - Self-hosted fonts MIME: **PASS** - `bricolage-grotesque-latin-wght-normal.woff2`, `source-serif-4-latin-wght-normal.woff2`, `ibm-plex-sans-latin-400-normal.woff2` all **HTTP/1.1 200** and **Content-Type: font/woff2**. Magic bytes `77 4f 46 32` (wOF2).
   - CSS `@font-face` wires `/fonts/`: **PASS** - bundle `/_astro/index.4ZffvgqE.css` lists 14 `url(/fonts/…)` covering Bricolage latin+latin-ext, Source Serif 4 normal+italic latin+latin-ext, IBM Plex Sans 400/500/600/700 latin+latin-ext.
   - Footer version **1.2.11**: **PASS** - loopback `Versión 1.2.11`; EN `Version 1.2.11`.
   - Browser / DevTools eye-check (HTML+CSS; no Chromium on host): **PASS** - zero CDN requests in HTML; body `font-family:"Source Serif 4",Georgia,serif`; `.hero__brand` / `.hero__headline` → `Bricolage Grotesque`; `.font-sans` / nav utilities → `IBM Plex Sans`. Preloads for three primary latin woff2 present. No Google stylesheet MIME refusal possible (link absent).
   - Anti-slop: **PASS** - brand faces unchanged (Bricolage / Source Serif 4 / IBM Plex); CSS has **0** Inter/Roboto; ship diff no `transition-all` / `scale-105`. Pre-emit P5 H5 E5 S5 R5 V4 recorded. Email-templates out of scope.
   - Production spot-check: **PASS** - `https://km0digital.com/` **200**, footer **Versión 1.2.11**, google-hits **0**, `/fonts/bricolage-….woff2` **200** `content-type: font/woff2`, same three preloads on `/en/`.
   - Docker logs: **PASS** - nginx start clean; tested paths **200**; no 5xx in window.
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` `/en/doc/day-0/`; `/fonts/*.woff2` (three); `/_astro/index.4ZffvgqE.css`; `https://km0digital.com/` `/en/` and production font URL.
7. **Log excerpts:**
   ```
   2026/07/25 15:54:54 [notice] 1#1: nginx/1.31.3
   172.21.0.1 - - [25/Jul/2026:15:55:03 +0000] "HEAD / HTTP/1.1" 200
   172.21.0.1 - - [25/Jul/2026:15:55:04 +0000] "HEAD /ca/ … /en/ … /de/ … /doc/" 200
   172.21.0.1 - - [25/Jul/2026:15:55:04 +0000] "HEAD /fonts/bricolage-…woff2" 200
   172.21.0.1 - - [25/Jul/2026:15:55:04 +0000] "GET /_astro/index.4ZffvgqE.css" 200
   ```
8. **GitHub:** label `agent:testing` on #117 at start; removed on PASS → CLOSED.
