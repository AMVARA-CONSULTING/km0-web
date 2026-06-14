---
name: autoagents
description: Runs the km0-web autoagents loop (GitHub issues → FEAT tasks → cursor-agent coders/testers/closers). Use when working with autoagents/, task files (FEAT/NEW/WIP/UNTESTED/TESTING/CLOSED), autoagents-loop.sh, issue_checker_agent.py, or GitHub agent labels on AMVARA-CONSULTING/km0-web.
---

# autoagents (km0-web)

## Quick start

```bash
./scripts/setup-autoagents-gh.sh          # once: gh auth + issue list test
./autoagents/autoagents-loop.sh 001        # single step
./autoagents/autoagents-loop.sh            # full loop every 5 min
```

Requires **cursor-agent** on PATH. No Ollama.

## Task pipeline

See **`autoagents/TASKS-README.md`** and **`docs/agent-loop.md`**.

```text
FEAT/NEW → WIP → UNTESTED → TESTING → CLOSED → done/YYYY/MM/DD/
```

## Site version

Footer displays **`package.json`** semver. Coders **must** run **`./scripts/bump-patch-version.sh`** once per task before **UNTESTED-**.

## Key paths

| Path | Purpose |
|------|---------|
| `scripts/bump-patch-version.sh` | Patch bump for footer version |
| `autoagents/autoagents-loop.sh` | Orchestrator |
| `autoagents/issue_checker_agent.py` | GH → FEAT helper |
| `autoagents/tasks/` | Active task queue |
| `scripts/git-sync-main.sh` | Sync before edits |
| `scripts/move-agent-task-to-done.sh` | Archive CLOSED tasks |
| `autoagents/.env` | GH_TOKEN, REDMINE_* (gitignored) |

## Single commands

| Command | Step |
|---------|------|
| `001` | GitHub reviewer |
| `feat` | Feature coder |
| `coder` | NEW/WIP coder |
| `handoff` | WIP → UNTESTED check |
| `tester` | Tester |
| `closing-review` | Archive CLOSED |
| `committer` | Git commit (`AGENT_COMMITTER_USE_CURSOR=1` in `.env`) |
| `sync_github_from_tasks.py` | FEAT → comment/label; CLOSED → comment/close |
| `redmine_sync.py` | Redmine closing note on archive (via move script) |

## GitHub

- Repo: `AMVARA-CONSULTING/km0-web`
- Account: Luipy56
- Labels: `agent:planned`, `agent:wip`, `agent:untested`, `agent:testing`

## Direct user chat

Non-task IDE prompts follow **`.cursor/rules/direct-user-prompts.mdc`**, same discipline without task files.
