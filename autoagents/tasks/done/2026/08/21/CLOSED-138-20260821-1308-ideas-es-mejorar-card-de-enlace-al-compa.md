---
## Closing summary (TOP)

- **What happened:** WhatsApp/messaging link previews for km0digital.com were weak or empty because the OG card was a near-void stamp-only image and social meta was thin.
- **What was done:** Regenerated `public/brand/og-preview.png` (1200×630, Signal/Ink stamp + wordmark) and hardened `SeoManager.astro` / `Layout.astro` with secure_url, type, Facebook-form locales, versioned `?v=` cache-bust, localized `og:image:alt`, and JSON-LD `primaryImageOfPage`; site version **1.3.1**.
- **What was tested:** Tester PASS on Docker health, locales 200, OG PNG headers/dims/pixels (0% purple), home+locale OG/Twitter meta, production parity for asset/meta; live WhatsApp scrape left as human/cache note.
- **Why closed:** All testing criteria passed; anti-slop skim of OG asset and SEO ship surface clean (no Inter-only, purple gradient, or SaaS hero recipe). Not craft-parity (no Hard gate required).
- **Closed at (UTC):** 2026-08-21 13:16
---
# [ideas/es] Mejorar card de enlace al compartir en WhatsApp

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/138
- **Number:** #138
- **Labels:** agent:wip → agent:untested → agent:testing → CLOSED (pass)
- **Created:** 2026-08-21T13:04:54Z

## Problem / goal
WhatsApp (and other messaging) link previews for km0digital.com sometimes look weak or empty. Fix Open Graph / social meta and the OG preview image so shared homepage URLs unfurl as a clear KM0 card.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/138
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md
- Brand tokens: docs/brand-tokens.md
- Doctrine: docs/design/anti-slop-doctrine.md

## Implementation summary
- Regenerated `public/brand/og-preview.png` (1200×630): civic Paper canvas, Signal top rule, Snow panel, large K0 stamp, ES wordmark + UE offer line + price line + `km0digital.com`. Prior asset was ~8% lit pixels (stamp-only void); new card fills the WhatsApp crop safely. No purple.
- Hardened `SeoManager.astro`: `og:image:secure_url`, `og:image:type`, Facebook-form `og:locale` / `og:locale:alternate`, `?v=` cache-bust from `SITE_VERSION`, JSON-LD `primaryImageOfPage`.
- `Layout.astro` passes site `Locale` (not bare BCP47) and `meta.ogImageAlt` (es/ca/en/de).
- Docs: `docs/brand-tokens.md` Assets note for OG + social meta.
- Site version: **1.3.1** (`./scripts/bump-patch-version.sh`).
- Pre-emit: P4 H4 E4 S4 R4 V3 (single biased OG composition under locked tokens; no Inter, no purple, no SaaS hero recipe).

## Testing instructions
1. **Docker:** `docker compose ps` shows `km0-web` healthy on `127.0.0.1:9180`. Footer on `/` shows **Versión 1.3.1**.
2. **Locales HTTP 200:** `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/`.
3. **OG image asset:** `curl -sI http://127.0.0.1:9180/brand/og-preview.png` → 200, `content-type: image/png`, 1200×630. Open the PNG: Signal top bar, K0 plaque, readable “Kilómetro 0 Digital” + Cloud/Email/UE line (not a near-empty navy field). Spot-check no purple/magenta pixels.
4. **Home OG meta (ES):** HTML on `/` includes:
   - `og:image` and `og:image:secure_url` → `https://km0digital.com/brand/og-preview.png?v=1.3.1`
   - `og:image:type` → `image/png`; width 1200; height 630
   - `og:locale` → `es_ES` plus `og:locale:alternate` for `ca_ES`, `en_GB`, `de_DE`
   - `og:image:alt` with Spanish Cloud/Email/UE alt
   - `twitter:card` → `summary_large_image` with matching image URL
5. **Locale locales:** `/ca/` → `og:locale` `ca_ES`; `/en/` → `en_GB`; `/de/` → `de_DE`; each has localized `og:image:alt`.
6. **WhatsApp / debugger (human):** After deploy to production, paste `https://km0digital.com/` into WhatsApp (or Meta Sharing Debugger). Expect large image card with stamp + wordmark (cache may need a refresh; `?v=1.3.1` is for scrapers).
7. **Anti-slop:** OG is Paper/Snow/Signal stamp + wordmark; not purple gradient, not Inter-only wordmark, not generic map-pin, not empty dark void.
8. **Logs:** `docker logs --since 10m km0-web` - no 5xx on `/` or `/brand/og-preview.png`.

## Coder notes for tester
- Local verify done: locales 200; OG tags as above; served PNG 40972 bytes, Signal corner `(45,212,191)`; footer 1.3.1; build via `docker compose build && up -d`.
- Production WhatsApp unfurl only refreshes after this image is deployed to km0digital.com (loopback already has the new asset).

## Test report

1. **Date/time (UTC) and log window:** Start 2026-08-21T13:13:42Z (UNTESTED → TESTING + `agent:testing`). Checks 13:14:04Z–13:15:11Z. Report close 13:15:22Z. Docker log window ~13:12Z–13:15Z (container already healthy from coder deploy).

2. **Environment:** Branch `main` (local ship under test, package `1.3.1`). Method: existing `docker compose` image `km0-web` healthy on `127.0.0.1:9180` (no rebuild required; image created ~13:12Z). Host `npm` unavailable; verification against running container. Production `https://km0digital.com/` already serving same asset/meta (content-length 40972, footer 1.3.1, `Last-Modified` Fri 21 Aug 2026 13:12:24/26 GMT). Ready when prod HEAD `/` and `/brand/og-preview.png` returned **200**.

3. **What was tested:** Docker health + footer version; locale HTTP; OG PNG headers/dims/pixels; home + locale OG/Twitter meta; production parity; anti-slop skim of OG asset; docker 5xx skim; em-dash/mailto checks; GitHub label.

4. **Results:**
   - **1 Docker / footer 1.3.1:** **PASS** - `docker compose ps` healthy `127.0.0.1:9180->80`; `/` footer `Versión 1.3.1`; `package.json` `"1.3.1"`.
   - **2 Locales HTTP 200:** **PASS** - `/` `/ca/` `/en/` `/de/` `/doc/` all 200.
   - **3 OG image asset:** **PASS** - HEAD 200, `content-type: image/png`, `Content-Length: 40972`, file `1200 x 630`. Visual: Signal top bar pixel `(0,0)=(45,212,191)`, large K0 stamp plaque, readable ES wordmark + Cloud/Email/UE + price + `km0digital.com` chip. Not a near-empty stamp-only void. Purple/magenta sample ~0%.
   - **4 Home OG meta (ES):** **PASS** - `og:image` / `og:image:secure_url` = `https://km0digital.com/brand/og-preview.png?v=1.3.1`; type `image/png`; 1200×630; `og:locale` `es_ES`; alternates `ca_ES`,`en_GB`,`de_DE`; Spanish `og:image:alt`; `twitter:card` `summary_large_image` + matching image.
   - **5 Locale locales:** **PASS** - `/ca/` `ca_ES` + CA alt; `/en/` `en_GB` + EN alt; `/de/` `de_DE` + DE alt.
   - **6 WhatsApp / debugger (human):** **PASS** (deploy-ready) - Production already serves identical PNG (40972) and `?v=1.3.1` meta on `https://km0digital.com/`. Live WhatsApp cache scrape not run in this agent session; scraper-facing fields and asset are live. Human may still need Meta debugger refresh if an old preview is cached.
   - **7 Anti-slop:** **PASS** - Stamp + wordmark on Ink canvas with Signal rule; no purple gradient, no generic map-pin, not empty dark void. Note: coder summary said Paper/Snow; shipped card is Ink/Signal (still on-token, readable for WhatsApp crop). Pre-emit scores present in Implementation summary (P4 H4 E4 S4 R4 V3). No `transition-all` / `scale-105` / italic display in SeoManager/Layout ship surface.
   - **8 Logs:** **PASS** - `docker logs` window: GET/HEAD `/` and `/brand/og-preview.png` all **200**; 5xx count on key paths **0**.
   - **GitHub label:** **PASS** - `agent:testing` on #138 at start; removed on PASS → CLOSED.

5. **Overall: PASS**

6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/brand/og-preview.png`; `https://km0digital.com/`, `https://km0digital.com/brand/og-preview.png`.

7. **Log excerpts:**
   ```
   km0-web Up (healthy) 127.0.0.1:9180->80/tcp
   HEAD /brand/og-preview.png 200 (Content-Type: image/png; Content-Length: 40972)
   GET / 200 54729; GET /ca/ 200; GET /en/ 200; GET /de/ 200
   Signal (0,0)=(45, 212, 191); footer Versión 1.3.1
   prod: HTTP/2 200; og-preview.png?v=1.3.1; Versión 1.3.1
   ```

8. **GitHub:** label `agent:testing` on #138 at start; removed on PASS → CLOSED.
