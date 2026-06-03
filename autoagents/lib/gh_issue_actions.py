#!/usr/bin/env python3
"""
Deterministic GitHub issue updates for autoagents (comments, labels, close).
Uses gh CLI; repo from AGENT_GH_REPO. Load GH_TOKEN via autoagents/.env before import
or export in the shell that runs the loop.
"""
from __future__ import annotations

import json
import os
import re
import subprocess
import sys
from pathlib import Path

GH_REPO = os.environ.get("AGENT_GH_REPO", "AMVARA-CONSULTING/km0-web")

AGENT_LABELS: tuple[tuple[str, str, str], ...] = (
    ("agent:planned", "0E8A16", "001 created FEAT task"),
    ("agent:wip", "1D76DB", "Coder working"),
    ("agent:untested", "FBCA04", "Ready for tester"),
    ("agent:testing", "5319E7", "Tester active"),
)

TASK_ISSUE_RE = re.compile(
    r"^(?:FEAT|NEW|WIP|UNTESTED|TESTING|CLOSED)-(\d+)-\d{8}-\d{4}-"
)


def _gh_json(args: list[str], timeout: int = 60) -> dict | list | None:
    cmd = ["gh", *args, "--repo", GH_REPO]
    try:
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            check=True,
            timeout=timeout,
        )
        if not result.stdout.strip():
            return None
        return json.loads(result.stdout)
    except (subprocess.CalledProcessError, json.JSONDecodeError, FileNotFoundError):
        return None


def _gh_run(args: list[str], timeout: int = 60) -> tuple[bool, str]:
    cmd = ["gh", *args, "--repo", GH_REPO]
    try:
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=timeout,
        )
        err = (result.stderr or result.stdout or "").strip()
        if result.returncode != 0 and "not accessible by personal access token" in err.lower():
            print(
                "  GitHub token missing permission (Issues: Read and write on this repo). "
                "Regenerate PAT at https://github.com/settings/tokens",
                file=sys.stderr,
            )
        return result.returncode == 0, err
    except (subprocess.CalledProcessError, FileNotFoundError) as exc:
        return False, str(exc)


def gh_available() -> bool:
    try:
        subprocess.run(["gh", "--version"], capture_output=True, check=True, timeout=10)
        return True
    except (subprocess.CalledProcessError, FileNotFoundError):
        return False


def ensure_agent_labels() -> None:
    if not gh_available():
        return
    for name, color, description in AGENT_LABELS:
        _gh_run(
            [
                "label",
                "create",
                name,
                "--color",
                color,
                "--description",
                description,
                "--force",
            ],
            timeout=30,
        )


def issue_number_from_task_basename(basename: str) -> int | None:
    m = TASK_ISSUE_RE.match(basename)
    if not m:
        return None
    num = int(m.group(1))
    return num if num > 0 else None


def issue_is_open(num: int) -> bool:
    data = _gh_json(["issue", "view", str(num), "--json", "state"])
    if not isinstance(data, dict):
        return False
    return data.get("state") == "OPEN"


def issue_has_comment_marker(num: int, marker: str) -> bool:
    data = _gh_json(["issue", "view", str(num), "--json", "comments"])
    if not isinstance(data, dict):
        return False
    for c in data.get("comments") or []:
        body = (c.get("body") or "").lower()
        if marker.lower() in body:
            return True
    return False


def issue_has_label(num: int, label: str) -> bool:
    data = _gh_json(["issue", "view", str(num), "--json", "labels"])
    if not isinstance(data, dict):
        return False
    names = {lbl.get("name", "") for lbl in data.get("labels") or []}
    return label in names


def comment_issue(num: int, body: str) -> bool:
    ok, err = _gh_run(["issue", "comment", str(num), "--body", body])
    if not ok:
        print(f"  gh comment #{num} failed: {err}", file=sys.stderr)
    return ok


def set_agent_label(num: int, label: str) -> bool:
    agent_names = [n for n, _, _ in AGENT_LABELS]
    data = _gh_json(["issue", "view", str(num), "--json", "labels"])
    if isinstance(data, dict):
        for lbl in data.get("labels") or []:
            name = lbl.get("name", "")
            if name in agent_names and name != label:
                _gh_run(["issue", "edit", str(num), "--remove-label", name])
    ok, err = _gh_run(["issue", "edit", str(num), "--add-label", label])
    if not ok:
        print(f"  gh label #{num} -> {label} failed: {err}", file=sys.stderr)
    return ok


def close_issue(num: int) -> bool:
    ok, err = _gh_run(["issue", "close", str(num)])
    if not ok:
        print(f"  gh close #{num} failed: {err}", file=sys.stderr)
        return False
    for name, _, _ in AGENT_LABELS:
        _gh_run(["issue", "edit", str(num), "--remove-label", name])
    return True


def notify_feat_planned(num: int, feat_basename: str) -> bool:
    marker = "agent 001"
    if issue_has_comment_marker(num, marker):
        print(f"  skip GitHub notify #{num}, Agent 001 comment exists")
        return True
    body = (
        f"🤖 **Agent 001:** Added FEAT task for this issue.\n\n"
        f"Task file: `autoagents/tasks/{feat_basename}`\n\n"
        f"The feature coder (010) will pick this up in the next loop cycle."
    )
    if not comment_issue(num, body):
        return False
    ensure_agent_labels()
    return set_agent_label(num, "agent:planned")


def extract_closing_summary(text: str, max_len: int = 3500) -> str:
    if "## Closing summary" not in text:
        return ""
    start = text.find("## Closing summary")
    end = text.find("\n---\n", start)
    block = text[start:end] if end > start else text[start : start + max_len]
    return block.strip()[:max_len]


def notify_issue_closed(num: int, task_path: Path) -> bool:
    if not issue_is_open(num):
        print(f"  skip close #{num}, already closed on GitHub")
        return True
    text = task_path.read_text(encoding="utf-8")
    summary = extract_closing_summary(text)
    body = (
        "🤖 **Agent (autoagents):** Work completed and verified.\n\n"
        + (summary if summary else "Task reached **CLOSED** status in the agent pipeline.")
        + f"\n\nArchived task: `autoagents/tasks/{task_path.name}` (or `done/` after archive)."
    )
    if issue_has_comment_marker(num, "work completed and verified"):
        print(f"  skip close comment #{num}, completion comment exists")
    else:
        if not comment_issue(num, body):
            return False
    return close_issue(num)


def sync_feat_tasks_planned(tasks_dir: Path) -> int:
    """Comment + agent:planned for FEAT-* files missing GitHub sync."""
    if not gh_available():
        print("gh not available, skip FEAT GitHub sync", file=sys.stderr)
        return 0
    ensure_agent_labels()
    synced = 0
    for path in sorted(tasks_dir.glob("FEAT-*.md")):
        num = issue_number_from_task_basename(path.name)
        if num is None:
            continue
        if issue_has_label(num, "agent:planned") and issue_has_comment_marker(num, "agent 001"):
            continue
        print(f"  GitHub sync planned: #{num} ({path.name})")
        if notify_feat_planned(num, path.name):
            synced += 1
    return synced


def sync_closed_tasks(tasks_dir: Path) -> int:
    """Comment + close GitHub issues for CLOSED-* task files still in tasks/."""
    if not gh_available():
        print("gh not available, skip CLOSED GitHub sync", file=sys.stderr)
        return 0
    closed = 0
    for path in sorted(tasks_dir.glob("CLOSED-*.md")):
        num = issue_number_from_task_basename(path.name)
        if num is None:
            continue
        print(f"  GitHub close: #{num} ({path.name})")
        if notify_issue_closed(num, path):
            closed += 1
    return closed


def sync_closed_from_done(tasks_dir: Path) -> int:
    """Close open GitHub issues that already have CLOSED-* under tasks/done/."""
    if not gh_available():
        return 0
    done_root = tasks_dir / "done"
    if not done_root.is_dir():
        return 0
    closed = 0
    seen: set[int] = set()
    for path in sorted(done_root.rglob("CLOSED-*.md")):
        num = issue_number_from_task_basename(path.name)
        if num is None or num in seen:
            continue
        seen.add(num)
        if not issue_is_open(num):
            continue
        print(f"  GitHub retro-close: #{num} ({path.relative_to(tasks_dir)})")
        if notify_issue_closed(num, path):
            closed += 1
    return closed
