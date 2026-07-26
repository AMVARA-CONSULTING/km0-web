---
## Closing summary (TOP)

- **What happened:** Issue #120 asked to stop per-cycle commits of the 001 gh-reviewer stamp file.
- **What was done:** Stamp path gitignored and untracked; loop stamp-only commit/push removed with skip when that path is the only dirty file; committer/001/docs/rules updated accordingly.
- **What was tested:** All six criteria PASS (gitignore, ignored status after append, no stamp commit path, skip helper, rule forbids, bash -n, optional HTTP 200).
- **Why closed:** All testing criteria passed; no site/UI change (anti-slop and craft Hard gate N/A).
- **Closed at (UTC):** 2026-07-26 12:52
---

# Reduce commit noise

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/120
- **Number:** #120
- **Labels:** agent:wip
- **Created:** 2026-07-26T12:48:15Z

## Problem / goal
We do not want to “record 001 gh-reviewer” commits in every cycle. This produces stupid noise. Update your rules.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/120
- Stop per-cycle commits of `autoagents/001-gh-reviewer/time-of-last-review.txt`
- Update loop + committer + 001 rules accordingly

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary

- **Gitignore** `autoagents/001-gh-reviewer/time-of-last-review.txt` and `git rm --cached` so the stamp stays on disk only.
- **Loop:** removed stamp-only auto-commit/push; if that path is the only dirty file, committer step **skips**. Fixed `last_review_iso_utc` to use the newest appended stamp.
- **Rules:** `001-gh-reviewer.md`, `040-committer.md`, `docs/agent-loop.md`, skill + workflow notes, `.env.example`, local `001-gh-reviewer/README.md`.
- **Version bump:** skipped (autoagents / docs / `.gitignore` only; no shipped site change).

## Testing instructions

1. Confirm stamp is ignored:
   ```bash
   git check-ignore -v autoagents/001-gh-reviewer/time-of-last-review.txt
   # expect: .gitignore … time-of-last-review.txt
   ```
2. After this task is committed (deletion + gitignore), append a local stamp line and confirm git stays clean for that path:
   ```bash
   printf '%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ) UTC | test stamp" >> autoagents/001-gh-reviewer/time-of-last-review.txt
   git status -sb | grep -F time-of-last-review.txt || echo "PASS: stamp not in status"
   ```
3. Confirm loop no longer has stamp-only commit:
   ```bash
   grep -n 'record 001\|update 001 reviewer time-of-last-review stamp\|committer_try_local_stamp' autoagents/autoagents-loop.sh || echo "PASS: no stamp commit path"
   grep -n 'committer_skip_local_stamp_only\|never commit stamp' autoagents/autoagents-loop.sh
   ```
4. Confirm committer rules forbid stamp-only commits:
   ```bash
   grep -n 'Never commit\|time-of-last-review\|record 001' autoagents/040-committer.md autoagents/001-gh-reviewer.md docs/agent-loop.md
   ```
5. Optional: `bash -n autoagents/autoagents-loop.sh` (syntax ok).
6. No Docker/site rebuild required for this task. If container is up, smoke only: `curl -sI http://127.0.0.1:9180/` → 200 (unchanged product).

## Test report

- **Date/time (UTC):** 2026-07-26 12:51:50 UTC start → 12:52:13 UTC end
- **Log window:** 2026-07-26 12:51:50Z – 12:52:13Z
- **Environment:** branch `main` @ `e4133c0`; uncommitted task diff (gitignore, loop, committer/001 rules); no site rebuild required; optional loopback smoke on `http://127.0.0.1:9180/`
- **What was tested:** Testing instructions for #120 (stamp gitignore, no stamp-only commit path, committer/001/docs rules, `bash -n`, optional HTTP smoke)

### Results

| Criterion | Result | Evidence |
|-----------|--------|----------|
| 1. Stamp ignored by git | **PASS** | `git check-ignore -v` → `.gitignore:8:autoagents/001-gh-reviewer/time-of-last-review.txt` |
| 2. Append stamp stays out of dirty status (content) | **PASS** | After append, `git status -uall --ignored --porcelain -- autoagents/001-gh-reviewer/` shows `!! …/time-of-last-review.txt` (ignored). Staged `D` is only the pending `git rm --cached` from this uncommitted task (expected until committer lands deletion). |
| 3a. No stamp-only auto-commit path | **PASS** | `grep` for `record 001` / `update 001 reviewer time-of-last-review stamp` / `committer_try_local_stamp` → only a comment forbidding commits; no commit function |
| 3b. Skip helper present | **PASS** | `committer_skip_local_stamp_only` at lines 264–268; called at 473 |
| 4. Committer / 001 / agent-loop forbid stamp commits | **PASS** | Matches in `040-committer.md` (Never commit section), `001-gh-reviewer.md` (gitignored, do not git add), `docs/agent-loop.md` (Commit noise section) |
| 5. Loop shell syntax | **PASS** | `bash -n autoagents/autoagents-loop.sh` → ok |
| 6. Optional product smoke | **PASS** | `curl -sI http://127.0.0.1:9180/` → `HTTP/1.1 200 OK` |

- **Overall:** **PASS**
- **URLs tested:** `http://127.0.0.1:9180/` (200); production N/A (no site change)
- **Log excerpts (`docker logs km0-web`):**
  ```
  172.21.0.1 - - [26/Jul/2026:12:52:02 +0000] "HEAD / HTTP/1.1" 200 0 "-" "curl/8.14.1" "-"
  ```
