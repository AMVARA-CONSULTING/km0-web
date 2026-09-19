---
## Closing summary (TOP)

- **What happened:** Issue #150 asked the site to follow the visitor's browser language on shared unprefixed links instead of always showing Spanish.
- **What was done:** Unprefixed GET and HEAD requests now redirect to `/ca/`, `/en/`, or `/de/` from the first Accept-Language tag; Spanish and unsupported languages stay on the canonical URL; crawlers are not redirected; an explicit choice sticks via the `km0_locale` cookie. Footer version is 1.3.19.
- **What was tested:** PASS on loopback and production: locale smoke, Accept-Language redirects, cookie lock, Twitterbot, WhatsApp, Googlebot, `fb_locale`, and footer 1.3.19.
- **Why closed:** All acceptance criteria passed. Not a craft-parity task, so the Hard gate does not apply.
- **Closed at (UTC):** 2026-09-18 12:39
---

# [ideas/es] Detect browser language for site locale on shared links

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/150
- **Number:** #150
- **Labels:** agent:wip → agent:untested → agent:testing → CLOSED (pass)
- **Created:** 2026-09-17T08:00:33Z

## Problem / goal
## Summary  The submitter wants km0digital.com to respect the visitor's browser language when choosing which locale to show. They note that pasting the site URL into X.com or WhatsApp always surfaces Spanish, and ask whether it should surface English...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/150
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary

Unprefixed URLs stay the Spanish canonical. Container nginx (`nginx/container.conf`) sends `GET`/`HEAD` of those pages to `/ca/`, `/en/`, or `/de/` when the first `Accept-Language` tag is `ca`, `en`, or `de` (`302`). Spanish and any other language stay put. Search crawlers are not redirected.

WhatsApp sends the chat language, so a Spanish chat still unfurls Spanish and an English chat unfurls English. X/Twitterbot sends no language; those bare-domain fetches go to English (`og:locale` `en_GB`). Facebook `fb_locale` wins over `Accept-Language`.

The language switcher links include `?km0_locale=`. Nginx answers with `301` to the same path without the query and sets cookie `km0_locale`. That cookie beats `Accept-Language`, so choosing ES sticks. A click handler sets the same cookie before navigation.

Site version: `1.3.18` → `1.3.19`.

Pre-emit: no new visual surface (lock query on the existing language links only). P5 H5 E5 S5 R5 V5.

## Testing instructions

1. **Locale smoke (no `Accept-Language`).** Expect `200` on each.
   ```bash
   curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/de/ http://127.0.0.1:9180/doc/
   ```

2. **Browser language on unprefixed paths.**
   ```bash
   curl -sI -H 'Accept-Language: en-US,en;q=0.9' http://127.0.0.1:9180/
   curl -sI -H 'Accept-Language: de-DE,de;q=0.9' http://127.0.0.1:9180/pricing/
   curl -sI -H 'Accept-Language: ca-ES,ca;q=0.9' http://127.0.0.1:9180/doc/
   curl -sI -H 'Accept-Language: es-ES,es;q=0.9' http://127.0.0.1:9180/
   curl -sI -H 'Accept-Language: fr-FR,fr;q=0.9' http://127.0.0.1:9180/
   curl -sI -H 'Accept-Language: de' http://127.0.0.1:9180/en/
   curl -sI -H 'Accept-Language: en' http://127.0.0.1:9180/favicon.svg
   ```
   Expect `302` to `/en/`, `/de/pricing/`, `/ca/doc/`. Expect `200` for Spanish, French (unsupported), already-prefixed `/en/`, and the SVG.

3. **Explicit locale lock.**
   ```bash
   curl -sI -c /tmp/km0cj -H 'Accept-Language: en' 'http://127.0.0.1:9180/?km0_locale=es'
   curl -sI -b /tmp/km0cj -H 'Accept-Language: en' http://127.0.0.1:9180/
   ```
   First response: `301` to `/` and `Set-Cookie: km0_locale=es`. Second: `200` (cookie beats English).

4. **Share cards vs search.**
   ```bash
   curl -sI -A 'Twitterbot/1.0' http://127.0.0.1:9180/
   curl -sL -A 'Twitterbot/1.0' http://127.0.0.1:9180/ | grep -o 'og:locale" content="en_GB"'
   curl -sI -A 'WhatsApp/2.23.20.0 A' -H 'Accept-Language: es' http://127.0.0.1:9180/
   curl -sI -A 'WhatsApp/2.23.20.0 A' -H 'Accept-Language: en' http://127.0.0.1:9180/
   curl -sI -A 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)' -H 'Accept-Language: en' http://127.0.0.1:9180/
   curl -sI 'http://127.0.0.1:9180/?fb_locale=de_DE'
   ```
   Twitterbot: `302` `/en/`, followed HTML contains `og:locale" content="en_GB"`. WhatsApp `es`: `200`. WhatsApp `en`: `302` `/en/`. Googlebot: `200` (Spanish canonical stays). `fb_locale=de_DE`: `302` `/de/`.

5. **Footer version.** Expect `1.3.19`.
   ```bash
   curl -s http://127.0.0.1:9180/ | grep -o 'Versión 1.3.19'
   ```

Coder evidence (2026-09-18, container `km0-web` after `docker compose build && docker compose up -d`): steps 1-5 passed. Twitterbot follow returned `og:locale" content="en_GB"`. Cookie jar after `?km0_locale=es` stayed `200` under `Accept-Language: en`. No browser click-through: language-switcher click was not exercised in a GUI; the lock query and cookie were checked with curl.

## Test report

1. **Date/time (UTC) and log window:** Start 2026-09-18T12:36:06Z (UNTESTED → TESTING + `agent:testing`). Checks 12:37:39Z–12:38:07Z. Report close 2026-09-18T12:38:40Z. Docker log window 12:36:06Z–12:38:07Z (container already healthy; config md5 matched repo, no rebuild this session).

2. **Environment:** Branch `main` at `40d4c4d` (ahead of origin, local uncommitted ship under test, package `1.3.19`). Method: existing `docker compose` image `km0-web` healthy on `127.0.0.1:9180->80/tcp`. Running `/etc/nginx/conf.d/default.conf` md5 `8810f572a546652d794958359af81978` equals `nginx/container.conf`. Loopback `http://127.0.0.1:9180/`. Production ready when the first poll of `https://km0digital.com/` returned **200** (same `Last-Modified` / etag as loopback, host nginx proxies to `:9180`).

3. **What was tested:** Locale smoke without `Accept-Language`; browser-language redirects on unprefixed paths; Spanish, French, already-prefixed `/en/`, and SVG stay `200`; `?km0_locale=es` cookie lock beats English; Twitterbot, WhatsApp, Googlebot, and `fb_locale`; footer `1.3.19`; language-switcher `?km0_locale=` links and `hreflang` / `x-default`; production spot-check. Craft parity: N/A (task does not name Stirling, Satisfecho, dark theme, or hard parity). Hallmark: pre-emit P5 H5 E5 S5 R5 V5 in Implementation summary; no new visual surface.

4. **Results:**
   - **Locale smoke:** **PASS** - `/`, `/ca/`, `/en/`, `/de/`, `/doc/` all **200**. `/en/doc/day-0/` **200**.
   - **Browser language:** **PASS** - `Accept-Language: en-US` → **302** `Location: /en/`; `de-DE` on `/pricing/` → **302** `/de/pricing/`; `ca-ES` on `/doc/` → **302** `/ca/doc/`. Spanish **200**, French **200**, `Accept-Language: de` on `/en/` **200**, `Accept-Language: en` on `/favicon.svg` **200**.
   - **Locale lock:** **PASS** - `/?km0_locale=es` with `Accept-Language: en` → **301** `Location: /` and `Set-Cookie: km0_locale=es; Path=/; Max-Age=31536000; SameSite=Lax`. Replay with that cookie and `Accept-Language: en` → **200**.
   - **Share cards vs search:** **PASS** - Twitterbot **302** `/en/`, follow HTML contains `og:locale" content="en_GB"`. WhatsApp `es` **200**. WhatsApp `en` **302** `/en/`. Googlebot with `Accept-Language: en` **200**. `fb_locale=de_DE` **302** `Location: /de/?fb_locale=de_DE` (German prefix; query kept). Follow-up `HEAD /de/?fb_locale=de_DE` **200** (no loop).
   - **Footer version:** **PASS** - `/` `Versión 1.3.19`; `/en/` and `/de/` `Version 1.3.19`; `/ca/` `Versió 1.3.19`.
   - **i18n switcher and hreflang:** **PASS** - switcher hrefs `/?km0_locale=es`, `/ca/?km0_locale=ca`, `/en/?km0_locale=en`, `/de/?km0_locale=de`. `hreflang` es/ca/en/de plus `x-default` → `https://km0digital.com/`.
   - **Production:** **PASS** - `https://km0digital.com/` **200** on first poll; footer `Versión 1.3.19`; `Accept-Language: en-US` **302** `/en/`; Spanish **200**; Googlebot **200**.
   - **GitHub label:** **PASS** - `agent:testing` on #150 at start; removed on PASS → CLOSED.

5. **Overall: PASS**

6. **URLs tested:** Loopback: `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/favicon.svg`, `/en/doc/day-0/`, `/?km0_locale=es`, `/?fb_locale=de_DE`. Production: `https://km0digital.com/`.

7. **Log excerpts:**
   ```
   km0-web Up (healthy) 127.0.0.1:9180->80/tcp
   HEAD / /ca/ /en/ /de/ /doc/ → 200
   HEAD / → 302 (en); HEAD /pricing/ → 302 (de); HEAD /doc/ → 302 (ca)
   HEAD /?km0_locale=es → 301; cookie replay HEAD / → 200
   Twitterbot HEAD / → 302; GET /en/ → 200
   WhatsApp es HEAD / → 200; WhatsApp en HEAD / → 302
   Googlebot HEAD / → 200
   HEAD /?fb_locale=de_DE → 302
   GET / footer 1.3.19; no 5xx in log window (42 lines, 0 matches)
   prod HEAD / → 200; Accept-Language en → 302; Googlebot → 200
   ```

8. **GitHub:** label `agent:testing` on #150 at start; removed on PASS → CLOSED.
