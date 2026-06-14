# Task workflow (autoagents / km0-web)

Tasks move through a single pipeline. See **`docs/agent-loop.md`** for roles and GitHub label conventions. **Before renaming task files**, sync with **`./scripts/git-sync-main.sh`**.

## Filename pattern

`<STATUS>-<GITHUB-ISSUE-NUMBER>-<YYYYMMDD>-<HHMM>-<slug>.md`

For **NEW-** tasks without an issue number, use **`NEW-0-YYYYMMDD-HHMM-<slug>.md`**.

Examples: `FEAT-12-20260526-1030-hero-copy-update.md`, `CLOSED-12-20260526-1200-hero-copy-update.md`

The **`<YYYYMMDD>`** segment places archived tasks under **`done/YYYY/MM/DD/`**.

## Statuses

| Status       | Meaning |
|--------------|--------|
| **new**      | Task defined, not started (incidents from logs). |
| **feat**     | Feature-sized task from GitHub issue. |
| **wip**      | Work in progress. When done → **UNTESTED-**. |
| **untested** | Implementation done; **Testing instructions** appended. |
| **testing**  | Tester is verifying. |
| **closed**   | Verified; ready for closing reviewer. |

## Flow

```text
  new   ─┐
         ├─→  wip  →  untested  →  testing  →  closed  →  done/YYYY/MM/DD/
  feat  ─┘
```

On test failure: **testing → wip**, then **wip → untested** when ready.

## Archiving

```bash
./scripts/move-agent-task-to-done.sh autoagents/tasks/CLOSED-12-20260526-1200-example.md
```

→ **`autoagents/tasks/done/2026/05/26/CLOSED-12-20260526-1200-example.md`**

When Redmine is configured (`REDMINE_API_KEY`, `REDMINE_ISSUE_ID` in `autoagents/.env`), the move script also posts an English Textile closing summary via `autoagents/redmine_sync.py`.

## Rules of thumb

- **feat → wip** when feature coder starts.
- **wip → untested** when implementation complete + **`./scripts/bump-patch-version.sh`** (once per task) + **Testing instructions** at end.
- **untested → testing** when tester starts.
- **testing → closed** on pass; **testing → wip** on fail.
- **closed → done/** after closing summary (move script).
