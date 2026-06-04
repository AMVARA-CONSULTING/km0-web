# User Ideas Intake – Public Feedback Page and GitHub Issue Pipeline

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/14
- **Number:** #14
- **Labels:** agent:wip
- **Created:** 2026-06-04T15:28:17Z

## Problem / goal
Public feedback page at `/ideas` (all locales) where users submit ideas or bug reports. Submissions POST to `/hooks/ideas`, enqueue JSON via Script 1 (`scripts/receive-idea.sh`), for later GitHub Issue creation by host-only Script 2.

## Implementation summary
- **Frontend:** `src/views/Ideas.astro`, `src/components/IdeasForm.astro`, `src/scripts/ideas-form.ts`, pages under `src/pages/{ideas,ca/ideas,en/ideas,de/ideas}/`
- **i18n:** `ideas` section in all locale JSON files + `src/i18n/types.ts`
- **Receiver:** `scripts/receive-idea.sh`, `hooks/hooks.json`, `Dockerfile.receiver`, `km0-ideas-receiver` service in `docker-compose.yml`
- **nginx:** `/hooks/ideas` proxy in `nginx/container.conf` (Docker) and `nginx/sites-available/km0` (production host)
- **Autoagents:** skip issues labeled `waiting for human validation` in `issue_checker_agent.py` and `001-gh-reviewer.md`
- **Docs:** runbook section + updated `user-ideas-queue-plan.md` status
- **Site version:** 1.1.23

## Out of scope (host ops)
- Script 2 secret processor (`/opt/km0-private/bin/process-idea.sh`)
- systemd path/service units
- GitHub label `waiting for human validation` creation on repo
- cursor-agent issue enrichment prompt

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md
- Queue plan: docs/user-ideas-queue-plan.md

## Testing instructions

1. **Build and deploy**
   ```bash
   cd /opt/km0-web
   ./scripts/git-sync-main.sh
   docker compose build
   docker compose up -d
   docker compose ps
   ```

2. **Static pages (200 OK)**
   ```bash
   curl -sI http://127.0.0.1:9180/ideas/
   curl -sI http://127.0.0.1:9180/ca/ideas/
   curl -sI http://127.0.0.1:9180/en/ideas/
   curl -sI http://127.0.0.1:9180/de/ideas/
   curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/de/ http://127.0.0.1:9180/doc/
   ```

3. **Footer version** (all locales after rebuild)
   ```bash
   curl -s http://127.0.0.1:9180/ideas/ | rg 'Versi[oó]n 1\.1\.23|Version 1\.1\.23'
   ```

4. **Hook enqueue**
   ```bash
   curl -s -X POST http://127.0.0.1:9180/hooks/ideas \
     -H 'Content-Type: application/json' \
     -d '{"idea":"Smoke test idea","locale":"en","name":"Tester"}'
   # Expect: {"ok":true}
   docker compose exec km0-ideas-receiver ls -la /var/spool/km0-ideas/incoming/
   docker compose exec km0-ideas-receiver cat /var/spool/km0-ideas/incoming/*.json
   ```
   Verify JSON has `id`, `receivedAt`, `locale`, `idea`, `meta.userAgent`, `meta.remoteAddr`.

5. **Validation**
   ```bash
   curl -s -X POST http://127.0.0.1:9180/hooks/ideas \
     -H 'Content-Type: application/json' \
     -d '{"idea":"","locale":"en"}'
   # Expect: {"ok":false,"error":"invalid_input"}
   ```

6. **Browser (manual)**
   - Open `http://127.0.0.1:9180/en/ideas/`
   - Fill textarea, optional name, click Send
   - Confirm thank-you message and no technical details shown

7. **Receiver logs**
   ```bash
   docker logs --since 10m km0-ideas-receiver
   docker logs --since 10m km0-web
   ```

8. **Honeypot (optional)**
   ```bash
   curl -s -X POST http://127.0.0.1:9180/hooks/ideas \
     -H 'Content-Type: application/json' \
     -d '{"idea":"spam","website":"http://bot.example"}'
   # Expect: {"ok":true} but no new queue file
   ```

## Test report

1. **Date/time (UTC):** 2026-06-04T15:55:01Z start, 2026-06-04T15:56:30Z end. Log window: `2026-06-04T15:55:00Z` through end of test.
2. **Environment:** branch `main` (synced, already up to date). Build: `docker compose build && docker compose up -d` (Astro 1.1.23 inside `km0-web` image; `npm` not on host PATH). Loopback: `http://127.0.0.1:9180`, receiver `127.0.0.1:9181`. Production polled: `https://km0digital.com/`.
3. **What was tested:** Docker build/deploy, static `/ideas/` pages (all locales), baseline locale paths, footer version 1.1.23, hook enqueue and JSON schema, validation error response, honeypot, page markup (form/success/i18n switcher), receiver and nginx logs, production `/ideas/` availability.
4. **Results:**
   - Build and deploy (`docker compose build`, `up -d`, both containers Up): **PASS**
   - Static pages 200 (`/ideas/`, `/ca/ideas/`, `/en/ideas/`, `/de/ideas/`, `/`, `/ca/`, `/en/`, `/de/`, `/doc/`): **PASS** (all `HTTP/1.1 200 OK`)
   - Footer version 1.1.23 on `/ideas/`: **PASS** (`Versión 1.1.23`)
   - Hook enqueue `{"ok":true}` and queue JSON fields (`id`, `receivedAt`, `locale`, `idea`, `meta.userAgent`, `meta.remoteAddr`): **PASS**
   - Validation empty idea returns `{"ok":false,"error":"invalid_input"}`: **FAIL** (HTTP 500, body `Error occurred while executing the hook's command...`; script prints correct JSON but exits 1; webhook maps non-zero exit to 500)
   - Browser form (HTML): **PASS** (verified `#ideas-form`, `#ideas-success`, client-side trim/length check in bundled script; manual click not run)
   - Honeypot `{"ok":true}` with no new queue file: **PASS** (count 2 before and after)
   - Locale switcher + `hreflang` on `/en/ideas/`: **PASS** (`/ca/ideas/`, `/de/ideas/`, `/en/ideas/`, `/ideas/` with `hreflang` es/ca/en/de/x-default)
   - Production `https://km0digital.com/ideas/` and `/en/ideas/`: **PASS** (HTTP 200 on first poll, no sleep loop)
   - GitHub label `agent:testing` at start, `agent:wip` on fail: **PASS**
5. **Overall:** **FAIL** (validation API contract)
6. **URLs tested:** `http://127.0.0.1:9180/ideas/`, `/ca/ideas/`, `/en/ideas/`, `/de/ideas/`, `/`, `/ca/`, `/en/`, `/de/`, `/doc/`; `http://127.0.0.1:9180/hooks/ideas` (POST); `https://km0digital.com/ideas/`, `https://km0digital.com/en/ideas/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.23 build
   15:55:12 [build] 52 page(s) built in 2.39s
   [webhook] 2026/06/04 15:55:14 serving hooks on http://0.0.0.0:9000/hooks/{id}
   [webhook] 2026/06/04 15:55:33 [f8896f] command output: {"ok":false,"error":"invalid_input"}
   [webhook] 2026/06/04 15:55:33 [f8896f] error occurred: exit status 1
   [webhook] 2026/06/04 15:55:33 [f8896f] 500 | 91 B | 52.600021ms | 127.0.0.1 | POST /hooks/ideas
   [webhook] 2026/06/04 15:55:34 [36dce1] command output: {"ok":true}
   [webhook] 2026/06/04 15:55:34 [36dce1] 200 | 12 B | 22.268805ms | 127.0.0.1 | POST /hooks/ideas
   2026/06/04 15:55:14 [notice] 1#1: Configuration complete; ready for start up
   ```

## Fix required (coder)

`scripts/receive-idea.sh` `respond_err` exits with status 1. The adnanh/webhook runner treats non-zero exit as failure and returns HTTP 500 with a generic message instead of the JSON body to the client. Change error responses to exit 0 while still printing `{"ok":false,"error":"..."}` (or adjust `hooks/hooks.json` per webhook docs) so invalid POSTs return the documented JSON contract.
