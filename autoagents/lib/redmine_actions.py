#!/usr/bin/env python3
"""
Post Textile-formatted completion notes to Redmine when autoagents tasks close.

Uses REDMINE_BASE_URL, REDMINE_API_KEY, and REDMINE_ISSUE_ID from the environment
(autoagents/.env loaded by autoagents-loop.sh before Python runs).
"""
from __future__ import annotations

import json
import os
import re
import sys
import urllib.error
import urllib.request
from pathlib import Path

from gh_issue_actions import (  # noqa: E402
    extract_closing_summary,
    issue_number_from_task_basename,
)

REDMINE_BASE_URL = os.environ.get("REDMINE_BASE_URL", "https://redmine.amvara.de").rstrip("/")
REDMINE_API_KEY = os.environ.get("REDMINE_API_KEY", "")
REDMINE_ISSUE_ID = os.environ.get("REDMINE_ISSUE_ID", "")
REDMINE_NOTE_MARKER = "autoagents task completed"
REDMINE_TIMEOUT = float(os.environ.get("REDMINE_TIMEOUT", "60"))

SUMMARY_BULLET_RE = re.compile(
    r"^\s*-\s*\*\*(.+?):\*\*\s*(.+?)\s*$",
    re.MULTILINE,
)


class RedmineError(Exception):
    pass


class IssueNotFound(RedmineError):
    pass


def redmine_configured() -> bool:
    return bool(REDMINE_API_KEY and REDMINE_ISSUE_ID)


def _headers() -> dict[str, str]:
    return {
        "X-Redmine-API-Key": REDMINE_API_KEY,
        "Content-Type": "application/json",
        "Accept": "application/json",
    }


def _request(method: str, path: str, payload: dict | None = None) -> dict:
    url = f"{REDMINE_BASE_URL}{path}"
    data = json.dumps(payload).encode("utf-8") if payload is not None else None
    req = urllib.request.Request(url, data=data, headers=_headers(), method=method)
    try:
        with urllib.request.urlopen(req, timeout=REDMINE_TIMEOUT) as resp:
            body = resp.read().decode("utf-8")
            return json.loads(body) if body.strip() else {}
    except urllib.error.HTTPError as exc:
        text = exc.read().decode("utf-8", errors="replace")[:500]
        if exc.code == 404:
            raise IssueNotFound(f"Issue not found at {path}") from exc
        raise RedmineError(f"Redmine {method} {path} failed: {exc.code} {text}") from exc
    except urllib.error.URLError as exc:
        raise RedmineError(f"Redmine request failed: {exc}") from exc


def add_redmine_note(base_url: str, api_key: str, issue_id: int, notes: str) -> None:
    """PUT /issues/{issue_id}.json with a new journal note."""
    url = f"{base_url.rstrip('/')}/issues/{issue_id}.json"
    payload = json.dumps({"issue": {"notes": notes}}).encode("utf-8")
    req = urllib.request.Request(
        url,
        data=payload,
        headers={
            "X-Redmine-API-Key": api_key,
            "Content-Type": "application/json",
            "Accept": "application/json",
        },
        method="PUT",
    )
    try:
        with urllib.request.urlopen(req, timeout=REDMINE_TIMEOUT) as resp:
            if resp.status >= 400:
                raise RedmineError(f"Redmine PUT issue failed: {resp.status}")
    except urllib.error.HTTPError as exc:
        text = exc.read().decode("utf-8", errors="replace")[:500]
        if exc.code == 404:
            raise IssueNotFound(f"Issue #{issue_id} not found") from exc
        raise RedmineError(f"Redmine PUT issue failed: {exc.code} {text}") from exc


def get_issue_journals(issue_id: int) -> list[dict]:
    data = _request("GET", f"/issues/{issue_id}.json?include=journals")
    issue = data.get("issue") or {}
    journals = issue.get("journals") or []
    return journals if isinstance(journals, list) else []


def issue_has_note_marker(issue_id: int, marker: str, task_basename: str) -> bool:
    needle = marker.lower()
    task_needle = task_basename.lower()
    for journal in get_issue_journals(issue_id):
        notes = (journal.get("notes") or "").lower()
        if needle in notes and task_needle in notes:
            return True
    return False


def _inline_code(text: str) -> str:
    """Wrap paths, URLs, and GH refs with @ for Textile inline code."""
    text = re.sub(r"`([^`]+)`", r"@\1@", text)
    parts: list[str] = []
    pattern = re.compile(
        r"(https?://[^\s<]+|autoagents/tasks/[^\s<]+|CLOSED-[A-Za-z0-9._-]+|FEAT-[A-Za-z0-9._-]+|#\d+)"
    )
    last = 0
    for match in pattern.finditer(text):
        parts.append(text[last : match.start()])
        parts.append(f"@{match.group(1)}@")
        last = match.end()
    parts.append(text[last:])
    return "".join(parts)


def closing_summary_to_textile(task_path: Path, summary_block: str) -> str:
    """Convert a task closing summary block to English Textile (.red style)."""
    gh_num = issue_number_from_task_basename(task_path.name)
    gh_repo = os.environ.get("AGENT_GH_REPO", "AMVARA-CONSULTING/km0-web")
    gh_url = f"https://github.com/{gh_repo}/issues/{gh_num}" if gh_num else ""

    lines = [
        "h2. Autoagents task completed",
        "",
        f"p. {REDMINE_NOTE_MARKER.capitalize()}.",
        "",
        "*Summary*",
    ]

    bullets = SUMMARY_BULLET_RE.findall(summary_block)
    if bullets:
        for label, value in bullets:
            lines.append(f"* *{label.strip()}:* {_inline_code(value.strip())}")
    elif summary_block.strip():
        for raw in summary_block.splitlines():
            stripped = raw.strip()
            if not stripped or stripped.startswith("#"):
                continue
            if stripped.startswith("- "):
                stripped = stripped[2:]
            lines.append(f"* {_inline_code(stripped)}")
    else:
        lines.append("* Task reached *closed* status in the autoagents pipeline.")

    lines.extend(
        [
            "",
            "*References*",
            f"* *Task file:* @{task_path.name}@",
        ]
    )
    if gh_num and gh_url:
        lines.append(f'* *GitHub issue:* "GitHub #{gh_num}":{gh_url}')
    lines.append("")
    lines.append("p. _Posted automatically by autoagents._")
    return "\n".join(lines)


def post_task_completion_note(task_path: Path, issue_id: int | None = None) -> str:
    """
    Post a Textile completion note to Redmine for a CLOSED task file.
    Returns: "posted", "skipped", or "failed".
    """
    if not redmine_configured():
        print("  Redmine skip, set REDMINE_API_KEY and REDMINE_ISSUE_ID in autoagents/.env", file=sys.stderr)
        return "failed"

    rid = issue_id if issue_id is not None else int(REDMINE_ISSUE_ID)
    if rid <= 0:
        print("  Redmine skip, invalid REDMINE_ISSUE_ID", file=sys.stderr)
        return "failed"

    if issue_has_note_marker(rid, REDMINE_NOTE_MARKER, task_path.name):
        print(f"  Redmine skip #{rid}, note already exists for {task_path.name}")
        return "skipped"

    text = task_path.read_text(encoding="utf-8")
    summary = extract_closing_summary(text)
    note_body = closing_summary_to_textile(task_path, summary)

    try:
        add_redmine_note(REDMINE_BASE_URL, REDMINE_API_KEY, rid, note_body)
    except IssueNotFound:
        print(f"  Redmine error - issue #{rid} not found", file=sys.stderr)
        return "failed"
    except RedmineError as exc:
        print(f"  Redmine error - {exc}", file=sys.stderr)
        return "failed"

    print(f"  Redmine note posted: #{rid} ({task_path.name})")
    return "posted"
