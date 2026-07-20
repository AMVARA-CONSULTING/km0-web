---
## Closing summary (TOP)

- **What happened:** Issue #71 asked for concrete family / SMB / enterprise use cases on the home Why section.
- **What was done:** Rewrote vision i18n bands (es/ca/en/de) into three use cases and added `contact` CTAs on WhyKm0; version bumped to 1.2.7. Anti-slop skim: reused existing scale bands only, no icon-tile grid, purple gradients, or Inter-only ship.
- **What was tested:** Tester PASS: locales, contact hashes, one Cloud primary, HTTP smoke loopback + production, no 5xx.
- **Why closed:** All testing criteria passed; no craft-parity Hard gate required (copy/CTA on existing Why).
- **Closed at (UTC):** 2026-07-20 12:35
---

# [ideas/en] Explain use cases for families, SMB, and enterprise

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/71
- **Number:** #71
- **Labels:** agent:wip (was agent:planned)
- **Created:** 2026-07-14T17:11:39Z

## Problem / goal
Ralf (ideas intake) asked for clear use-case examples so visitors see who KM0 is for: families (photo sync, shared storage, secure links, optional mail), SMB (~10 mail + website/DNS help), and larger orgs (plan/operate, large file exchange). Content and positioning, not a new product.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/71
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary

**Approach:** Reuse the existing Stirling-style Why (`#why`) scale bands instead of a new page or icon-tile grid. Rewrote `vision` i18n copy (es/ca/en/de) into the three concrete use cases. Extended band CTA type with `contact` so SMB secondary and org primary can deep-link to `#contact`. Did not invent a self-serve website hosting SKU; web/DNS is framed as planning via contact.

**Pre-flight:** Civic editorial use-case bands on Paper; layout = existing split-bias Why bands; type = Bricolage + Source Serif + IBM Plex; accent = Signal teal; refused new icon-tile feature grid, fake stats, and claiming website hosting as a listed product.

**Pre-emit:** P4 H4 E4 S5 R4 V4

**Files:**
- `src/i18n/{es,ca,en,de}.json` - vision intro + three bands
- `src/i18n/types.ts` - `cta` / `secondaryCta` include `contact`
- `src/components/WhyKm0.astro` - `bandHref` for contact hash
- `package.json` - **1.2.6 → 1.2.7** via `./scripts/bump-patch-version.sh`

**Verify (coder):** `docker compose build && docker compose up -d`; HEAD 200 on `/` `/ca/` `/en/` `/de/` `/doc/`; EN Why shows family / SMB / larger copy; footer Version 1.2.7; contact CTAs → `/en/#contact`.

## Testing instructions

1. Sync and confirm container: `./scripts/git-sync-main.sh`; `docker compose ps` / `curl -sI http://127.0.0.1:9180/` (expect 200). Footer on `/` or `/en/` shows **1.2.7** (or later if stacked bumps).
2. Open `/#why` and `/en/#why` (also `/ca/#why`, `/de/#why`). Confirm three bands:
   - Family: photo sync / shared folders / optional mail; primary Cloud; secondary pricing.
   - SMB (~10 accounts): team mail + cloud + migration; web/DNS via planning; primary pricing; secondary contact (`…/#contact`).
   - Larger org: plan/operate / large files; primary contact; secondary pricing.
3. Click org primary "Talk to us" / "Hablar con nosotros" and confirm hash lands on `#contact`.
4. Confirm only one Why-band Cloud `btn-primary` (family band); no new icon-tile use-case grid; no purple gradients / Inter-only / invented metrics.
5. HTTP smoke: `/` `/ca/` `/en/` `/de/` `/doc/` all 200. Em-dash and mailto checks green (covered by image prebuild).
6. Logs: `docker logs --since 10m km0-web` - no 5xx on those paths.

## Test report

- **Date/time (UTC):** 2026-07-20 12:34:04 start → 12:34:50 end
- **Log window:** 2026-07-20 12:33:14Z (container start) through 12:34:50Z
- **Environment:** branch `main` (working tree includes task ship: WhyKm0 + vision i18n + package.json 1.2.7). Container `km0-web` healthy on `127.0.0.1:9180`. Image built/deployed ~12:33:13Z (`Last-Modified: 2026-07-20 12:33:12 GMT`). Production `https://km0digital.com/` served same content (content-length match, footer Version 1.2.7, EN Why titles present). Ready signal: curl HEAD 200 + HTML body contains use-case titles + footer 1.2.7 (no sleep).
- **What was tested:** Testing instructions 1–6; Hallmark/anti-slop skim on Why ship files; i18n Why bands es/ca/en/de; contact hash targets; HTTP smoke loopback + production.

### Results

1. **Container + footer 1.2.7** - **PASS**. `docker compose ps`: healthy. `curl -sI http://127.0.0.1:9180/` → 200. Footer: `Version 1.2.7` (`/en/`), `Versión 1.2.7` (`/`). `package.json` version 1.2.7.
2. **Three Why bands (family / SMB / org) all locales** - **PASS**.
   - EN: Family "Home photos, Gmail optional" (Cloud + pricing); SMB "Team mail and shared cloud" (pricing + contact); Org "Plan, operate, large file exchange" (contact + pricing).
   - ES/CA/DE parallel titles and body themes (photo sync, ~10 accounts, plan/operate/large files) confirmed in served HTML.
3. **Org primary → `#contact`** - **PASS**. EN `Talk to us` → `/en/#contact`; ES `Hablar con nosotros` → `/#contact`. Page has `id="contact"`. SMB secondary also `#contact` (`Write to us` / `Escribirnos`).
4. **One Cloud primary; no icon-tile / purple / Inter-only / invented metrics** - **PASS**. Exactly one Why `btn-primary` pointing at `https://cloud.km0digital.com` per locale. Existing scale bands only (no new icon-tile grid). Ship files: no `transition-all` / `scale-105` / italic display / purple-indigo. Pre-emit in Implementation summary: P4 H4 E4 S5 R4 V4.
5. **HTTP smoke + em-dash / mailto** - **PASS**. Loopback HEAD 200: `/` `/ca/` `/en/` `/de/` `/doc/`. `./scripts/check-no-em-dash.sh` OK; `./scripts/check-no-mailto.sh` OK. Production HEAD 200: `/` `/ca/` `/en/` `/de/` `/doc/`; EN body shows new Why copy + Version 1.2.7.
6. **Logs no 5xx** - **PASS**. `docker logs --since 15m km0-web`: access lines for tested paths all 200; no 5xx status lines in window.

### Overall: **PASS**

### URLs tested
- http://127.0.0.1:9180/ , /ca/, /en/, /de/, /doc/ (and `#why` / `#contact` via HTML parse)
- https://km0digital.com/ , /ca/, /en/, /de/, /doc/

### Log excerpts
```
2026/07/20 12:33:14 [notice] 1#1: nginx/1.31.3
172.21.0.1 - - [20/Jul/2026:12:34:23 +0000] "HEAD / HTTP/1.1" 200 0
172.21.0.1 - - [20/Jul/2026:12:34:23 +0000] "HEAD /ca/ HTTP/1.1" 200 0
172.21.0.1 - - [20/Jul/2026:12:34:23 +0000] "HEAD /en/ HTTP/1.1" 200 0
172.21.0.1 - - [20/Jul/2026:12:34:23 +0000] "HEAD /de/ HTTP/1.1" 200 0
172.21.0.1 - - [20/Jul/2026:12:34:23 +0000] "HEAD /doc/ HTTP/1.1" 200 0
172.21.0.1 - - [20/Jul/2026:12:34:23 +0000] "GET /en/ HTTP/1.1" 200 44568
```
No 5xx in log window.

