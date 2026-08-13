---
## Closing summary (TOP)

- **What happened:** Standing nginx 403 on `/contact/` and `/contact` from directory-index of the asset-only `public/contact/` folder.
- **What was done:** Exact `location =` 301 redirects in `nginx/container.conf` to `/#contact` (plus locale twins); QR asset path unchanged; site version bumped to 1.2.27 and redeployed.
- **What was tested:** All acceptance criteria PASS (local 301s, locale twins, QR 200, no new directory-index 403 in logs, landings 200, footer 1.2.27, production `/contact/` 301).
- **Why closed:** All criteria passed; not UI/craft-parity (infra redirect only).
- **Closed at (UTC):** 2026-08-13 02:11
---

# Fix standing nginx 403 on /contact/ directory

## Source
- Docker incident (container `km0-web`, nginx static on `127.0.0.1:9180` and production `km0digital.com`).
- No GitHub issue; standing log noise + user-facing 403.

## Problem / goal
nginx error log shows recurring `directory index ... is forbidden` for `/contact/`:

```
directory index of "/usr/share/nginx/html/contact/" is forbidden ... request: "GET /contact/ HTTP/1.1", host: "km0digital.com"
directory index of "/usr/share/nginx/html/contact/" is forbidden ... request: "HEAD /contact/ HTTP/1.1", host: "127.0.0.1:9180"
```

Observed repeatedly on 2026-08-13 (01:45, 01:49, 01:55, 02:01 UTC) on both production and loopback. `curl -sI` confirms `HTTP/1.1 403 Forbidden` for `/contact/` while `/contact/whatsapp-group-qr.png` remains `200`.

Root cause: `public/contact/` exists only as an asset folder (WhatsApp QR PNG). There is no `index.html`, autoindex is off, so directory requests return 403. Contact UX on the site is the landing hash `#contact`, not a standalone `/contact/` page.

## High-level instructions for coder
- Stop `/contact` and `/contact/` from 403ing. Prefer a small nginx redirect (or equivalent) to the on-site contact hash (`/` → `/#contact`; locale prefixes if a clean rule exists, otherwise default locale home hash is fine).
- Keep `/contact/whatsapp-group-qr.png` (and any future files under that prefix) serving `200` unchanged.
- Prefer the smallest correct fix in `nginx/container.conf` (exact `location` for `/contact` / `/contact/`). Do not invent a full Contact page unless product asks; do not break security headers or other `location` rules.
- Do not emit `mailto:` links. Do not add em dashes.
- After change: `docker compose build && docker compose up -d`; confirm logs no longer emit `directory index of ".../contact/" is forbidden` for fresh HEAD/GET probes.
- Bump site version once with `./scripts/bump-patch-version.sh` before renaming to UNTESTED- (nginx ships in the container; per `.cursor/rules/site-version-bump.mdc`).
- Follow repo guards: `./scripts/check-no-em-dash.sh`, `./scripts/check-no-mailto.sh`. Reference `docs/runbook.md` for deploy smoke.

## Implementation summary
- Added exact `location =` redirects in `nginx/container.conf` for `/contact` and `/contact/` → `301 /#contact`, plus locale twins (`/ca|en|de/contact[/]` → locale `#contact`), matching the existing `/cloud` pattern.
- Exact match leaves `/contact/whatsapp-group-qr.png` on the static file path (`200 image/png`).
- Site version: `1.2.26` → `1.2.27` via `./scripts/bump-patch-version.sh`.
- Redeployed with `docker compose build && docker compose up -d`.

## Testing instructions
1. Confirm container is up: `docker compose ps` (or `docker ps --filter name=km0-web`).
2. `curl -sI http://127.0.0.1:9180/contact/` → expect `301` with `Location` containing `/#contact` (not `403`).
3. `curl -sI http://127.0.0.1:9180/contact` → same `301` to `/#contact`.
4. Optional locale checks: `curl -sI http://127.0.0.1:9180/en/contact/` → `301` to `/en/#contact` (same for `/ca/`, `/de/`).
5. `curl -sI http://127.0.0.1:9180/contact/whatsapp-group-qr.png` → `200`, `Content-Type: image/png`.
6. Smoke landings: `for p in / /ca/ /en/ /de/ /doc/; do curl -sI -o /dev/null -w "%{http_code} $p\n" "http://127.0.0.1:9180$p"; done` → all `200`.
7. After steps 2-3, `docker logs km0-web 2>&1 | grep -F 'directory index of "/usr/share/nginx/html/contact/" is forbidden'` should show no new lines for those fresh probes (access log should show `301` for `/contact` and `/contact/`).
8. Footer version on `/` should include `1.2.27` (e.g. `curl -s http://127.0.0.1:9180/ | grep -oE 'Versi[oó]n [0-9.]+|Version [0-9.]+'`).
9. Guards (optional): `./scripts/check-no-em-dash.sh` and `./scripts/check-no-mailto.sh` → OK.

## Acceptance criteria
- `curl -sI http://127.0.0.1:9180/contact/` is not 403 (prefer 301/302 to `/#contact` or equivalent success redirect).
- `curl -sI http://127.0.0.1:9180/contact` behaves the same (no trailing slash).
- `curl -sI http://127.0.0.1:9180/contact/whatsapp-group-qr.png` still `200` image/png.
- Fresh probes do not add `directory index of ".../contact/" is forbidden` lines in `docker logs km0-web`.
- Locale landings `/` `/ca/` `/en/` `/de/` and `/doc/` still `200`.

## Test report

1. **Date/time (UTC) and log window:** Start 2026-08-13 02:10:10 UTC; probes 02:10:18–02:10:29 UTC; report closed 2026-08-13 02:10:33 UTC. Log window: `docker logs --since=2m km0-web`.
2. **Environment:** Branch `main` (local working tree has uncommitted `nginx/container.conf` + `package.json` 1.2.27 from coder). Container `km0-web` Up/healthy, `127.0.0.1:9180->80/tcp` (created ~39s before first probe). Build method: existing coder redeploy (`docker compose build && docker compose up -d`); tester did not rebuild. Loopback `http://127.0.0.1:9180`; production `https://km0digital.com/` polled until HTTP 200 (first try).
3. **What was tested:** Acceptance criteria for `/contact` and `/contact/` redirects; locale twins; QR asset; landing smoke; no new directory-index 403 in logs; footer version 1.2.27; optional em-dash/mailto guards; production `/contact/` and QR.
4. **Results:**
   - `/contact/` not 403, 301 to `/#contact`: **PASS** - `HTTP/1.1 301`, `Location: http://127.0.0.1/#contact`
   - `/contact` same: **PASS** - `HTTP/1.1 301`, `Location: http://127.0.0.1/#contact`
   - Locale `/ca|en|de/contact[/]`: **PASS** - all `301` to `/ca/#contact`, `/en/#contact`, `/de/#contact`
   - `/contact/whatsapp-group-qr.png`: **PASS** - `200`, `Content-Type: image/png`, length 2452
   - Fresh probes no `directory index .../contact/ is forbidden`: **PASS** - grep on last 2m logs returned no matches; access log shows `301` for contact directory HEAD probes
   - Locale landings + `/doc/`: **PASS** - `200 /`, `200 /ca/`, `200 /en/`, `200 /de/`, `200 /doc/`
   - Footer version 1.2.27: **PASS** - `Versión 1.2.27` on `/`
   - Guards (optional): **PASS** - `check-no-em-dash: OK`, `check-no-mailto: OK`
   - Production `/contact/`: **PASS** - site ready when `curl -sI https://km0digital.com/` returned `200` on first poll; `/contact/` → `HTTP/2 301` `location: http://km0digital.com/#contact`; QR still `200 image/png`
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/contact`, `/contact/`, `/ca|en|de/contact[/]`, `/contact/whatsapp-group-qr.png`, `/`, `/ca/`, `/en/`, `/de/`, `/doc/`; `https://km0digital.com/`, `/contact/`, `/contact/whatsapp-group-qr.png`. No GitHub issue (task `0`); labels N/A.
7. **Relevant log excerpts:**
```
172.21.0.1 - - [13/Aug/2026:02:10:18 +0000] "HEAD /contact/ HTTP/1.1" 301 0 "-" "curl/8.14.1" "-"
172.21.0.1 - - [13/Aug/2026:02:10:18 +0000] "HEAD /contact HTTP/1.1" 301 0 "-" "curl/8.14.1" "-"
172.21.0.1 - - [13/Aug/2026:02:10:18 +0000] "HEAD /contact/whatsapp-group-qr.png HTTP/1.1" 200 0 "-" "curl/8.14.1" "-"
(no "directory index of \"/usr/share/nginx/html/contact/\" is forbidden" lines in --since=2m window)
```
