---
## Closing summary (TOP)

- **What happened:** GitHub issue #68 requested a mandatory product scope selector on the `/ideas/` form so submissions route to the correct repository.
- **What was done:** Added required scope select to `IdeasForm.astro` and client script, localized labels in all four locales, receiver validation and spool storage, autoissue repo mapping (`web`/`cloud`/`mail`), privacy copy, and runbook docs. Site version **1.1.101**.
- **What was tested:** Tester report **PASS**: Docker build, ideas pages (4 locales), scope UI and hints, client POST body, receiver validation (valid/invalid scope), spool storage, autoissue mapping, smoke paths, footer version, privacy mention, production poll.
- **Why closed:** All acceptance criteria and testing instructions passed.
- **Closed at (UTC):** 2026-07-12 15:41
---

# [ideas/es] Campo obligatorio de scope en formulario de ideas

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/68
- **Number:** #68
- **Labels:** none
- **Created:** 2026-07-12T15:32:36Z

## Problem / goal
Add a mandatory product scope selector on `/ideas/` so submissions route to the correct GitHub repository (km0-web, km0-opencloud, or km0-mail). Default scope is km0digital (web).

## Implementation summary
- **Form UI:** `IdeasForm.astro` + `ideas-form.ts` - required `<select id="ideas-scope">` with options `web`, `cloud`, `mail` (labels: km0digital, cloud.km0digital, mail.km0digital); default `web`.
- **i18n:** scope label, hint, and option labels in `es.json`, `ca.json`, `en.json`, `de.json`; types in `types.ts`.
- **Receiver:** `scripts/receive-idea.sh` validates and stores `scope` in queue JSON (defaults to `web` when omitted).
- **Autoissue:** `scripts/autoissue.sh` maps scope to repo (`web` → km0-web, `cloud` → km0-opencloud, `mail` → km0-mail) before `gh issue create`.
- **Draft agent:** `autoissue/autoissue-agent.md` documents scope in input/context tables.
- **Privacy:** legal sections updated in all locales to mention product scope field.
- **Docs:** `docs/runbook.md`, `docs/user-ideas-queue-plan.md` updated.
- **Site version:** 1.1.101

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Testing instructions

1. **Build and deploy**
   ```bash
   docker compose build && docker compose up -d
   ```

2. **Ideas pages (all locales)**
   - Open `/ideas/`, `/en/ideas/`, `/ca/ideas/`, `/de/ideas/` - expect HTTP 200.
   - Each page shows `#ideas-scope` select with three options: km0digital (selected), cloud.km0digital, mail.km0digital.
   - Hint text visible under the select (localized).

3. **Form client script**
   - View source or DevTools: bundled script includes `scope` in POST body JSON.
   - Submit with empty message: error shown, no success state.

4. **Receiver validation**
   ```bash
   curl -s -X POST http://127.0.0.1:9181/hooks/ideas \
     -H 'Content-Type: application/json' \
     -d '{"idea":"Scope web test","locale":"en","scope":"web"}'
   # expect {"ok":true}

   curl -s -X POST http://127.0.0.1:9181/hooks/ideas \
     -H 'Content-Type: application/json' \
     -d '{"idea":"Scope cloud test","locale":"en","scope":"cloud"}'
   # expect {"ok":true}

   curl -s -X POST http://127.0.0.1:9181/hooks/ideas \
     -H 'Content-Type: application/json' \
     -d '{"idea":"bad scope","scope":"invalid"}'
   # expect {"ok":false,"error":"invalid_input"}
   ```
   - Inspect latest spool files: `jq .scope /var/spool/km0-ideas/incoming/*.json` shows `web` or `cloud` as submitted.

5. **Autoissue routing (host, manual)**
   - Confirm `scripts/autoissue.sh` contains `repo_for_scope` mapping to `AMVARA-CONSULTING/km0-web`, `km0-opencloud`, `km0-mail`.
   - Optional: enqueue a test JSON with `"scope":"cloud"`, run `sudo ./scripts/autoissue.sh`, verify processed meta includes `"repo":"AMVARA-CONSULTING/km0-opencloud"`.

6. **Smoke paths**
   ```bash
   curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/de/ http://127.0.0.1:9180/doc/
   ```
   - All HTTP 200.

7. **Footer version**
   - Footer shows **1.1.101** on ideas page (all locales).

8. **Privacy page**
   - `/legal/` mentions product scope as required field on ideas form.

## Test report

1. **Date/time (UTC):** 2026-07-12T15:40:17Z – 2026-07-12T15:40:48Z. Log window: Docker/nginx from 15:40:34Z.
2. **Environment:** branch `main` @ `cd47bcc`; build via `docker compose build && docker compose up -d` (`km0-web@1.1.101`, 124 pages). URLs: loopback `http://127.0.0.1:9180/`, receiver `http://127.0.0.1:9181/hooks/ideas`, production `https://km0digital.com/`.
3. **What was tested:** Ideas pages (4 locales), scope select UI, client POST body, receiver validation, spool scope storage, autoissue `repo_for_scope` mapping, smoke paths, footer version, privacy page scope mention, production poll.
4. **Results:**
   - Docker build & deploy: **PASS**
   - Ideas pages HTTP 200 (`/ideas/`, `/en/ideas/`, `/ca/ideas/`, `/de/ideas/`): **PASS**
   - `#ideas-scope` select with options `web` (selected), `cloud`, `mail` on all locales: **PASS**
   - Localized hint text under select: **PASS**
   - Client script includes `scope` in POST JSON: **PASS** (`JSON.stringify({idea:a,name:f,locale:h,scope:u,website:v})`)
   - Receiver POST `scope:web`: **PASS** (`{"ok":true}`; spool `scope: "web"`)
   - Receiver POST `scope:cloud`: **PASS** (`{"ok":true}`; spool `scope: "cloud"`)
   - Receiver POST invalid scope: **PASS** (`{"ok":false,"error":"invalid_input"}`)
   - `scripts/autoissue.sh` `repo_for_scope` mapping (km0-web, km0-opencloud, km0-mail): **PASS**
   - Smoke paths (`/`, `/ca/`, `/en/`, `/de/`, `/doc/`): **PASS** (all 200)
   - Footer version **1.1.101** on ideas page: **PASS**
   - Privacy page mentions product scope: **PASS** (ES `producto`, EN `product scope`)
   - Production readiness: **PASS** (`https://km0digital.com/` and `/ideas/` HTTP 200 on first poll)
   - GitHub label `agent:testing` on issue #68: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/ideas/`, `/en/ideas/`, `/ca/ideas/`, `/de/ideas/`, `/legal/`, `/en/legal/`; `http://127.0.0.1:9181/hooks/ideas`; `https://km0digital.com/`, `https://km0digital.com/ideas/`.
7. **Log excerpts:**
   ```
   172.21.0.1 - - [12/Jul/2026:15:40:37 +0000] "HEAD /ideas/ HTTP/1.1" 200 0
   172.21.0.1 - - [12/Jul/2026:15:40:37 +0000] "HEAD /en/ideas/ HTTP/1.1" 200 0
   172.21.0.1 - - [12/Jul/2026:15:40:37 +0000] "GET /ideas/ HTTP/1.1" 200 24573
   ```
8. **GitHub:** label `agent:testing` applied on issue #68 at test start.
