---
## Closing summary (TOP)

- **What happened:** Lighthouse flagged missing `llms.txt` on the public marketing site.
- **What was done:** Added `public/llms.txt` (llmstxt.org format with Pages / Products / Optional links) served at `/llms.txt`; site version bumped for ship.
- **What was tested:** Loopback and production `/llms.txt` returned HTTP 200 `text/plain` with expected body; locale smoke and footer version PASS. Overall PASS.
- **Why closed:** All acceptance criteria passed; missing-asset root cause fixed.
- **Closed at (UTC):** 2026-07-29 01:32
---

# [ideas/es] Fix missing LLMs.txt reported by Lighthouse

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/132
- **Number:** #132
- **Labels:** none
- **Created:** 2026-07-29T01:21:50Z

## Problem / goal
## Summary  The submitter reports that Lighthouse flags `LLMs.txt` as missing on the km0digital.com site and asks for it to be fixed. Product scope is the public marketing web (`web`). No further requirements were provided beyond adding or exposing t...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/132
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- Added `public/llms.txt` at the site root (llmstxt.org format: H1, blockquote summary, Pages / Products / Optional H2 link lists).
- Spec path is `/llms.txt` (lowercase); Astro copies `public/` into `dist/`, so nginx serves it at the origin root with `text/plain`.
- Site version bumped `1.2.16` → `1.2.17` via `./scripts/bump-patch-version.sh`.
- UI pre-emit scores: N/A (static SEO asset only; no UI/i18n change).

## Testing instructions
1. Confirm file exists in the image/root: `curl -sI http://127.0.0.1:9180/llms.txt` → **HTTP 200**, `Content-Type: text/plain`.
2. Body starts with `# Kilometer 0 Digital` and includes at least one markdown link under `## Pages`: `curl -s http://127.0.0.1:9180/llms.txt | head -20`.
3. Smoke locales still OK: `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` → **200**.
4. Footer shows **Versión 1.2.17** (or locale equivalent): `curl -s http://127.0.0.1:9180/ | grep -oE 'Versi[oó]n? [0-9.]+|Version [0-9.]+'`.
5. Optional production check after deploy: `curl -sI https://km0digital.com/llms.txt` → **200**.
6. Optional Lighthouse: re-run the agentic-browsing / llms.txt audit on the home page; missing-file failure should clear.

## Test report

- **Date/time (UTC):** 2026-07-29 01:30:24 start → 01:31:13 end
- **Log window:** 2026-07-29 01:30:40Z – 01:31:13Z (`docker logs km0-web`)
- **Environment:** branch `main` @ `2b3b41d` (working tree includes uncommitted `public/llms.txt` + version bumps); build via `docker compose build && docker compose up -d`; loopback `http://127.0.0.1:9180/`; production `https://km0digital.com/`
- **What was tested:** `/llms.txt` headers/body, locale smoke, footer version, optional production `/llms.txt`

### Results

1. **`/llms.txt` HTTP 200 + `text/plain`** - **PASS**  
   Evidence: `curl -sI http://127.0.0.1:9180/llms.txt` → `HTTP/1.1 200 OK`, `Content-Type: text/plain`, `Content-Length: 1871`. File present in container: `/usr/share/nginx/html/llms.txt`.

2. **Body H1 + Pages links** - **PASS**  
   Evidence: body starts with `# Kilometer 0 Digital`; `## Pages` includes markdown links such as `[Home (ES)](https://km0digital.com/)`.

3. **Locale / doc smoke** - **PASS**  
   Evidence: `/`, `/ca/`, `/en/`, `/de/`, `/doc/` all `HTTP/1.1 200 OK`.

4. **Footer version** - **PASS** (superseded bump)  
   Evidence: home HTML shows `Versión 1.2.18` (task #132 bumped to 1.2.17; same tree then #133 bumped to 1.2.18). Footer reflects current ship label.

5. **Production `/llms.txt`** - **PASS**  
   Evidence: polled `https://km0digital.com/llms.txt` → `HTTP/2 200`, `content-type: text/plain`, `content-length: 1871`. Site ready confirmed by immediate 200 (no wait loop needed).

6. **Optional Lighthouse re-audit** - **N/A** (not run in this session; file presence satisfies the missing-asset root cause).

### Overall: **PASS**

### URLs tested
- http://127.0.0.1:9180/llms.txt
- http://127.0.0.1:9180/ , /ca/, /en/, /de/, /doc/
- https://km0digital.com/llms.txt
- https://km0digital.com/

### Log excerpts
```
2026/07/29 01:30:40 [notice] 1#1: nginx/1.31.3
... start worker processes ...
172.21.0.1 - - [29/Jul/2026:01:30:46 +0000] "HEAD /llms.txt HTTP/1.1" 200 0
172.21.0.1 - - [29/Jul/2026:01:30:47 +0000] "GET /llms.txt HTTP/1.1" 200 1871
172.21.0.1 - - [29/Jul/2026:01:31:12 +0000] "GET /llms.txt HTTP/1.1" 200 1871 ... "116.202.10.106"
```
No nginx crash loop.
