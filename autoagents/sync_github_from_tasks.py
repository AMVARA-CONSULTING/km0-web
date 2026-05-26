#!/usr/bin/env python3
"""Sync GitHub issues from autoagents task filenames (planned + closed)."""
import os
import sys
from pathlib import Path

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(SCRIPT_DIR, "lib"))

from gh_issue_actions import (  # noqa: E402
    sync_closed_from_done,
    sync_closed_tasks,
    sync_feat_tasks_planned,
)

TASKS_DIR = Path(SCRIPT_DIR) / "tasks"


def main() -> int:
    mode = (sys.argv[1] if len(sys.argv) > 1 else "all").lower()
    planned = closed = 0
    if mode in ("all", "planned", "feat"):
        print("=== Sync FEAT → GitHub (agent:planned) ===")
        planned = sync_feat_tasks_planned(TASKS_DIR)
        print(f"Synced {planned} FEAT task(s)\n")
    if mode in ("all", "closed"):
        print("=== Sync CLOSED → GitHub (comment + close) ===")
        closed = sync_closed_tasks(TASKS_DIR)
        retro = sync_closed_from_done(TASKS_DIR)
        print(f"Closed {closed} active + {retro} archived issue(s) on GitHub\n")
    return 0 if (planned or closed or mode == "all") else 0


if __name__ == "__main__":
    raise SystemExit(main())
