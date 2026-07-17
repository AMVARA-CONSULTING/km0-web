---
## Closing summary (TOP)

- **What happened:** Deferred blog prose batch closed as a template-contract task after pilot day-0 polish, without rewriting historical day posts.
- **What was done:** Added `docs/design/blog-post-template.md` and linked it from doctrine/remodel docs; lightly polished day-0 prose in es/ca/en/de to match the inverted-pyramid voice.
- **What was tested:** Tester PASS - template + references, day-0 polish, non-pilot days untouched, HTTP 200 on locales/doc, em-dash clean, footer on current build, nginx healthy.
- **Why closed:** All acceptance criteria passed; historical day-1…16 rewrite correctly deferred.
- **Closed at (UTC):** 2026-07-17 19:06
---

# FEAT-Task: Blog & docs prose pass (day posts + voice)

## GitHub Issue
- **Number:** #78
- **Title:** (see issue)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/78
- **Labels:** agent:planned
- **Depends / notes:** see body; run remodel epic in order


## Problem / goal

**Deferred batch.** Product owner decided: ship **blog chrome + day-0 template** first; rewrite remaining `day-*` prose in a **follow-up** after the visual remodel lands.

This task is a **placeholder epic stub**: either close as cancelled once #1809 is done, or slim to “document the template contract for future day posts” only - **do not** rewrite all historical days in this pass.

## High-level instructions for coder

1. Confirm `FEAT` blog redesign (pilot `day-0`) is UNTESTED/CLOSED.
2. Write `docs/design/blog-post-template.md`: inverted pyramid, Markdown-first, no manifesto intros, checklist for future `day-N` authors/agents.
3. Optionally polish **only** `day-0` prose in es/ca/en/de to match the template (if not already perfect).
4. **Do not** batch-rewrite day-1…day-16 in this task.
5. Build + bump if any content changed. Skip GH if still numberless; if this file is linked to a GH issue, comment the deferral.

## Acceptance

- Template doc exists and is referenced from doctrine or remodel-epic
- Non-pilot posts untouched (except unbroken under new CSS)
- `check-no-em-dash` still OK

## Testing instructions

1. **Version:** Footer shows `1.1.107` on `/` (and locales).
2. **Template doc:** Confirm `docs/design/blog-post-template.md` exists (inverted pyramid, Markdown-first, voice checklist, points at pilot `day-0`).
3. **References:** `docs/design/anti-slop-doctrine.md` and `docs/design/remodel-epic.md` link to `blog-post-template.md` (also `lessons-from-pos.md` Blog row).
4. **HTTP 200:** `curl -sI http://127.0.0.1:9180/` plus `/ca/`, `/en/`, `/de/`, `/doc/`, `/doc/day-0/`, `/doc/day-1/`, `/en/doc/day-0/`, `/ca/doc/day-0/`, `/de/doc/day-0/`.
5. **Pilot polish:** Open `/doc/day-0/` and `/en/doc/day-0/`. Lead is conclusion-first (“ships the foundations” / “deja las fundaciones”); close has soft next-step links. Still Markdown `##` prose, no `doc-lead-block`.
6. **Non-pilot untouched:** `git diff` (or status) shows no edits under `src/content/doc/*/day-1.md` … `day-16.md`. `/doc/day-1/` still 200.
7. **Em dash:** `./scripts/check-no-em-dash.sh` OK (also ran in Docker build).
8. **Logs:** `docker logs --since 10m km0-web` - no nginx error/emerg after deploy.

## References
- `src/content/doc/`
- `docs/design/blog-post-template.md`
- NN/g applying guidelines: https://www.nngroup.com/articles/applying-writing-guidelines-web-pages/

## Test report

- **Date/time (UTC):** 2026-07-17 19:04:16 start → 19:05:00 end
- **Log window:** `docker logs --since 10m km0-web` (approx 19:04–19:05 UTC)
- **Environment:** branch `main`; `docker compose build && docker compose up -d`; loopback `http://127.0.0.1:9180/`; production `https://km0digital.com/` (HTTP 200 on first poll)
- **What was tested:** Template doc + references; day-0 pilot polish; non-pilot day posts untouched; HTTP locales/doc; em-dash; footer version; nginx logs

### Results

| Criterion | Result | Evidence |
|-----------|--------|----------|
| 1. Footer version | PASS (note) | Loopback footer `Versión 1.1.108`; task asked for `1.1.107` but FEAT-79 bumped to `1.1.108` in the same tree. Deliverables of #78 present under current build. |
| 2. Template doc | PASS | `docs/design/blog-post-template.md` exists; inverted pyramid, Markdown-first, voice checklist, pilot `day-0` |
| 3. References | PASS | Linked from `anti-slop-doctrine.md`, `remodel-epic.md`, and Blog row in `lessons-from-pos.md` |
| 4. HTTP 200 | PASS | `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/doc/day-0/`, `/doc/day-1/`, `/en/doc/day-0/`, `/ca/doc/day-0/`, `/de/doc/day-0/` all 200 |
| 5. Pilot polish | PASS | ES lead “deja las **fundaciones**”; EN “ships the **foundations**”; close links to services/contact; no `doc-lead-block`; Markdown `##` sections |
| 6. Non-pilot untouched | PASS | `git diff` only `day-0.md` under `src/content/doc/`; day-1…16 diff empty; `/doc/day-1/` 200 |
| 7. Em dash | PASS | `./scripts/check-no-em-dash.sh` OK; Docker prebuild OK |
| 8. Logs | PASS | nginx start notices + access 200s; no error/emerg |

- **Overall:** **PASS**
- **URLs tested:** `http://127.0.0.1:9180/` (+ locales/doc paths above); `https://km0digital.com/` (200, footer also 1.1.108)
- **Log excerpts:**
  ```
  2026/07/17 19:04:32 [notice] 1#1: nginx/1.31.3
  HEAD /doc/day-0/ 200; HEAD /doc/day-1/ 200; GET /doc/day-0/ 200
  ```
