#!/usr/bin/env python3
"""Post a Redmine completion note for one CLOSED task (archive hook)."""
from __future__ import annotations

import os
import sys
from pathlib import Path

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(SCRIPT_DIR, "lib"))

from redmine_actions import post_task_completion_note  # noqa: E402


def main() -> int:
    if len(sys.argv) != 3 or sys.argv[1] != "note":
        print(
            "Usage: redmine_sync.py note <path/to/CLOSED-....md>",
            file=sys.stderr,
        )
        return 1

    path = Path(sys.argv[2])
    if not path.is_file():
        print(f"Error: file not found: {path}", file=sys.stderr)
        return 1

    result = post_task_completion_note(path)
    return 0 if result != "failed" else 1


if __name__ == "__main__":
    raise SystemExit(main())
