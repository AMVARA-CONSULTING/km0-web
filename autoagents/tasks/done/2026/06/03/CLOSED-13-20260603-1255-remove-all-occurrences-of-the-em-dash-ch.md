---
## Closing summary (TOP)

- **What happened:** GitHub issue #13 requested removal of every em dash (Unicode U+2014) from repository text and automated validation to prevent reintroduction.
- **What was done:** Replaced U+2014 across docs, README, autoagents tasks, presentations, and nginx; added `scripts/check-no-em-dash.sh`, `npm run check:no-em-dash` prebuild hook, GitHub Actions workflow, and `CONTRIBUTING.md`; site version bumped to **1.1.22**.
- **What was tested:** Tester PASS: em dash scan scripts, Docker build with prebuild check (48 pages), HTTP 200 smoke on loopback locales, footer version 1.1.22, CONTRIBUTING and CI workflow present, zero U+2014 in `src/`, production poll 200.
- **Why closed:** All testing criteria passed.
- **Closed at (UTC):** 2026-06-03 12:55
---

# Remove all occurrences of the em dash character and enforce rule to prevent future usage

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/13
- **Number:** #13
- **Labels:** agent:wip
- **Created:** 2026-06-03T12:47:00Z

## Problem / goal
Remove every em dash (Unicode U+2014) from repository text and add automated validation so the character cannot be reintroduced.

## Implementation summary
- Replaced U+2014 in docs, README, autoagents task files, presentations source, nginx comment, and related text.
- Regenerated presentation PPTX/PDF from updated `presentations/generate_presentations.py`.
- Added `CONTRIBUTING.md` with style guidance and validation steps.
- Added `scripts/check-no-em-dash.sh` (POSIX sh, text files only).
- Wired `npm run check:no-em-dash` and `prebuild` hook in `package.json`.
- Added GitHub Actions workflow `.github/workflows/check-no-em-dash.yml`.
- Updated `.cursor/rules/no-em-dash.mdc` to reference U+2014 without embedding the character.
- Site version bumped to **1.1.22**.

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Testing instructions

1. **Em dash scan:** `./scripts/check-no-em-dash.sh` and `npm run check:no-em-dash` must exit 0 with "OK (zero U+2014 matches in text files)".
2. **Negative test:** `printf '\xe2\x80\x94' >> /tmp/em-test.md && EM=$(printf '\342\200\224') && grep -q "$EM" /tmp/em-test.md && rm /tmp/em-test.md` (manual sanity only).
3. **Build:** `docker compose build && docker compose up -d` must succeed; build log shows prebuild check passing and Astro 48 pages at v1.1.22.
4. **HTTP smoke:** `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` expect `200 OK`.
5. **Footer version:** `curl -s http://127.0.0.1:9180/ | grep -o 'Versión [0-9.]*'` shows **1.1.22**.
6. **CONTRIBUTING:** Confirm `CONTRIBUTING.md` documents the no-em-dash rule and points to the check script.
7. **CI workflow:** Confirm `.github/workflows/check-no-em-dash.yml` exists and runs `./scripts/check-no-em-dash.sh` on push/PR to main.

## Test report

1. **Date/time (UTC):** 2026-06-03T12:54:49Z – 2026-06-03T12:55:12Z. Log window: `docker logs --since 2026-06-03T12:54:49Z km0-web`.
2. **Environment:** branch `main` (uncommitted coder changes in worktree); build via `docker compose build && docker compose up -d` (`km0-web@1.1.22`, npm unavailable on host); loopback `http://127.0.0.1:9180/`; production `https://km0digital.com/`.
3. **What was tested:** Em dash scan scripts, negative grep sanity, Docker build with prebuild hook, HTTP smoke, footer version, CONTRIBUTING.md and CI workflow presence, `src/` grep for U+2014, production poll.
4. **Results:**
   - `./scripts/check-no-em-dash.sh`: **PASS** (`OK (zero U+2014 matches in text files)`, exit 0)
   - `npm run check:no-em-dash` on host: **N/A** (`npm` not on PATH); equivalent **PASS** via Docker prebuild (`npm run check:no-em-dash` → OK before `astro build`)
   - Negative grep detects U+2014 in `/tmp/em-test.md`: **PASS**
   - Docker build/up, prebuild check, 48 pages at v1.1.22: **PASS** (`check-no-em-dash: OK`; `[build] 48 page(s) built in 2.45s`)
   - HTTP 200 loopback: `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`: **PASS**
   - Footer version **1.1.22**: **PASS** (`Versión 1.1.22` on `/`)
   - `CONTRIBUTING.md` documents rule and check script: **PASS**
   - `.github/workflows/check-no-em-dash.yml` runs script on push/PR to main: **PASS**
   - `src/` U+2014 grep: **PASS** (0 matches)
   - Production `https://km0digital.com/`: **PASS** (HTTP 200 on first poll, no sleep loop)
   - GitHub label `agent:testing` on issue #13: **PASS** (applied at test start; removed `agent:wip`)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`; `https://km0digital.com/`.
7. **Log excerpts:**
   ```
   > km0-web@1.1.22 check:no-em-dash
   check-no-em-dash: OK (zero U+2014 matches in text files)
   12:55:03 [build] 48 page(s) built in 2.45s
   2026/06/03 12:55:06 [notice] 1#1: Configuration complete; ready for start up
   172.19.0.1 - - [03/Jun/2026:12:55:09 +0000] "HEAD / HTTP/1.1" 200 0 "-" "curl/8.14.1"
   172.19.0.1 - - [03/Jun/2026:12:55:09 +0000] "GET / HTTP/1.1" 200 43604 "-" "curl/8.14.1"
   ```
8. **GitHub:** label `agent:testing` applied on issue #13 at test start.
