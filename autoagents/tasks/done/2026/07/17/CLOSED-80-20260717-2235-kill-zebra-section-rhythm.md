---
## Closing summary (TOP)

- **What happened:** Landing zebra (nth-child Snow/Paper alternation) was removed so section rhythm is continuous Paper with intentional opt-in surfaces only.
- **What was done:** Deleted `main:has(#home)` zebra rules in `global.css`; Contact opts into `bg-snow`; Offer/Why/Community/FAQ inherit body Paper; secondary pages left unchanged.
- **What was tested:** Tester PASS - zero zebra in source/built CSS; continuous Paper rhythm; Contact Snow; HTTP 200s; footer version present; nginx clean.
- **Why closed:** All acceptance criteria and test report PASS; no anti-slop regressions.
- **Closed at (UTC):** 2026-07-17 20:57
---
# FEAT-Task: Kill zebra section rhythm

## GitHub Issue
- **Number:** #80
- **Title:** Kill zebra section rhythm
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/80
- **Labels:** agent:wip

## Problem / goal
Home still applies automatic Snow/Paper zebra via `nth-child` in `src/styles/global.css`. That is a template tell. Stirling/Nous use continuous canvas + intentional bands only.

## High-level instructions for coder
1. Read `docs/design/reference-study-stirling-satisfecho-nous.md` and anti-slop skill.
2. **Delete** the zebra rules (`main:has(#home) > section…nth-child(odd/even)`).
3. Default section backgrounds to Paper (body already Paper) unless a section opts in.
4. Give **explicit** surface classes only where earned (e.g. CloudUserStats ink band, Contact closer). No mechanical alternation.
5. Check secondary pages do not rely on zebra.
6. `npm run build` / docker per runbook; bump patch; gh comment + `agent:wip` → then UNTESTED.

## Acceptance
- Zero nth-child zebra on landing
- Rhythm still readable; contrast OK
- Build green

## Done by coder
- Removed `main:has(#home) > section…nth-child(odd/even)` Snow/Paper zebra from `src/styles/global.css`.
- Landing sections (Offer, Why, Community, FAQ) inherit continuous Paper from `body`.
- Contact closer opts in with explicit `bg-snow` (`src/components/Contact.astro`).
- Cloud user proof remains the intentional proof moment inside Offer (band variant); standalone `bg-navy` section variant unchanged.
- Secondary pages never used the zebra selector; left as-is.
- Cleared U+2014 em dashes in sibling FEAT task files + phase-2 design docs so `check-no-em-dash` / Docker build could pass.
- Site version bumped to **1.1.109**.

## Testing instructions
1. Confirm CSS has no landing zebra: search `src/styles/global.css` (and built `_astro/*.css`) for `nth-child(odd` / `nth-child(even` under `main:has(#home)` - expect zero.
2. Open `http://127.0.0.1:9180/` (and `/ca/`, `/en/`, `/de/`): Offer → Why → Community → FAQ should sit on continuous Paper (no alternating Snow stripes). Contact (`#contact`) should be Snow white against Paper; footer remains Paper.
3. Contrast: headings and body text remain readable on Paper and on Contact Snow; Cloud user count still visible under Offer.
4. Smoke secondary surfaces: `/doc/`, `/pricing/`, `/meeting/`, `/ideas/` - no broken backgrounds (they never depended on zebra).
5. HTTP: `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` → 200.
6. Footer shows **Versión 1.1.109** (or locale equivalent).
7. `docker logs --since 10m km0-web` - clean nginx start, no 5xx on smoke requests.

## References
- Runbook: docs/runbook.md
- Study: docs/design/reference-study-stirling-satisfecho-nous.md
- Doctrine: docs/design/anti-slop-doctrine.md
- Tokens: docs/brand-tokens.md
- Site: https://km0digital.com

## Test report

1. **Date/time (UTC) and log window:** Start 2026-07-17 20:54:09 UTC; end ~20:54:50 UTC. Docker log window: `--since 10m` / from container restart 20:54:24 UTC.
2. **Environment:** Branch `main` (synced). Build: `docker compose build && docker compose up -d`. Loopback `http://127.0.0.1:9180/`. Production `https://km0digital.com/` (HTTP/2 200; footer Versión 1.1.113; ready via immediate 200 + matching version, no sleep).
3. **What was tested:** Testing instructions 1-7 for kill-zebra (#80): source + built CSS zebra absence, continuous Paper landing rhythm, Contact Snow opt-in, contrast / cloud user proof, secondary surface smoke, HTTP 200s, footer version, nginx logs.
4. **Results:**
   - No landing zebra (`nth-child(odd/even)` / `main:has(#home)`): **PASS** - zero matches in `src/styles/global.css`; comment documents continuous Paper; `docker exec` grep on `/usr/share/nginx/html/_astro/*.css` returned `ZERO_NTH_CHILD` / `ZERO_MAIN_HAS`.
   - Continuous Paper Offer→Why→Community→FAQ; Contact Snow; footer Paper: **PASS** - sections lack alternating `bg-snow`; only `#contact` has `bg-snow km0-motif`; `body` CSS `background-color: rgb(238 240 242)` (Paper); footer `bg-paper`. Locales `/`, `/ca/`, `/en/`, `/de/` all 200.
   - Contrast + cloud user proof: **PASS** - section headings use `heading-section text-navy`; `#cloud-users` proof shows count `28` under Offer (`cloud-user-proof`).
   - Secondary `/doc/`, `/pricing/`, `/meeting/`, `/ideas/`: **PASS** - all HTTP 200; pages render with Paper body / intentional surfaces (e.g. ideas form `bg-snow`), no broken backgrounds.
   - HTTP smoke: **PASS** - `/` `/ca/` `/en/` `/de/` `/doc/` `/pricing/` `/meeting/` `/ideas/` → 200.
   - Footer version: **PASS** - loopback and production show **Versión 1.1.113** (task noted 1.1.109 from this FEAT alone; later phase-2 UNTESTED tasks #81-84 bumped further in the same workspace; version present and >= coder bump).
   - Docker logs: **PASS** - nginx start notice at 20:54:24; access log smoke all 200; no 5xx in window.
   - GitHub label `agent:testing` on issue #80: **PASS** (applied at test start).
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/meeting/`, `/ideas/`; `https://km0digital.com/`.
7. **Log excerpts:**
   ```
   2026/07/17 20:54:24 [notice] 1#1: nginx/1.31.3
   2026/07/17 20:54:24 [notice] 1#1: start worker processes
   172.21.0.1 - - [17/Jul/2026:20:54:36 +0000] "GET / HTTP/1.1" 200
   172.21.0.1 - - [17/Jul/2026:20:54:36 +0000] "GET /ca/ HTTP/1.1" 200
   172.21.0.1 - - [17/Jul/2026:20:54:36 +0000] "GET /en/ HTTP/1.1" 200
   172.21.0.1 - - [17/Jul/2026:20:54:36 +0000] "GET /de/ HTTP/1.1" 200
   172.21.0.1 - - [17/Jul/2026:20:54:36 +0000] "GET /doc/ HTTP/1.1" 200
   ```
8. **GitHub:** label `agent:testing` applied on issue #80 at test start.

