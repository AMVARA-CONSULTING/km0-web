#!/usr/bin/env python3
"""
Post Textile-formatted completion notes to Redmine when autoagents tasks close.

Uses REDMINE_BASE_URL, REDMINE_API_KEY, and REDMINE_ISSUE_ID from the environment
(autoagents/.env loaded by autoagents-loop.sh before Python runs).

Also records task duration in the note text and as a Redmine time_entry
(REDMINE_ACTIVITY_ID, default 10 = Service Management).
"""
from __future__ import annotations

import json
import os
import re
import sys
import urllib.error
import urllib.request
from datetime import datetime, timedelta, timezone
from pathlib import Path

from gh_issue_actions import (  # noqa: E402
    extract_closing_summary,
    issue_number_from_task_basename,
)

REDMINE_BASE_URL = os.environ.get("REDMINE_BASE_URL", "https://redmine.amvara.de").rstrip("/")
REDMINE_API_KEY = os.environ.get("REDMINE_API_KEY", "")
REDMINE_ISSUE_ID = os.environ.get("REDMINE_ISSUE_ID", "")
REDMINE_ACTIVITY_ID = int(os.environ.get("REDMINE_ACTIVITY_ID", "10"))
REDMINE_NOTE_MARKER = "autoagents task completed"
REDMINE_TIMEOUT = float(os.environ.get("REDMINE_TIMEOUT", "60"))

SUMMARY_BULLET_RE = re.compile(
    r"^\s*-\s*\*\*(.+?):\*\*\s*(.+?)\s*$",
    re.MULTILINE,
)
TASK_STAMP_RE = re.compile(
    r"^(?:CLOSED|NEW|FEAT|UNTESTED|TESTING)-\d+-(\d{8})-(\d{4})-",
    re.IGNORECASE,
)
CLOSED_AT_RE = re.compile(
    r"Closed at \(UTC\):\s*(\d{4}-\d{2}-\d{2})\s+(\d{1,2}:\d{2})",
    re.IGNORECASE,
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


def add_redmine_time_entry(
    base_url: str,
    api_key: str,
    issue_id: int,
    hours: float,
    comments: str,
    *,
    activity_id: int | None = None,
    spent_on: str | None = None,
) -> None:
    """POST /time_entries.json - official spent-time log."""
    url = f"{base_url.rstrip('/')}/time_entries.json"
    payload = {
        "time_entry": {
            "issue_id": issue_id,
            "hours": round(float(hours), 2),
            "comments": comments[:255],
            "activity_id": activity_id if activity_id is not None else REDMINE_ACTIVITY_ID,
            "spent_on": spent_on or datetime.now(timezone.utc).strftime("%Y-%m-%d"),
        }
    }
    req = urllib.request.Request(
        url,
        data=json.dumps(payload).encode("utf-8"),
        headers={
            "X-Redmine-API-Key": api_key,
            "Content-Type": "application/json",
            "Accept": "application/json",
        },
        method="POST",
    )
    try:
        with urllib.request.urlopen(req, timeout=REDMINE_TIMEOUT) as resp:
            if resp.status >= 400:
                raise RedmineError(f"Redmine POST time_entry failed: {resp.status}")
    except urllib.error.HTTPError as exc:
        text = exc.read().decode("utf-8", errors="replace")[:500]
        if exc.code == 404:
            raise IssueNotFound(f"Issue #{issue_id} not found for time_entry") from exc
        raise RedmineError(f"Redmine POST time_entry failed: {exc.code} {text}") from exc
    except urllib.error.URLError as exc:
        raise RedmineError(f"Redmine time_entry request failed: {exc}") from exc


def parse_task_start_utc(basename: str) -> datetime | None:
    """Start time from CLOSED-/NEW-…-YYYYMMDD-HHMM-… filename (treated as UTC)."""
    m = TASK_STAMP_RE.match(basename)
    if not m:
        return None
    try:
        return datetime.strptime(f"{m.group(1)}{m.group(2)}", "%Y%m%d%H%M").replace(
            tzinfo=timezone.utc
        )
    except ValueError:
        return None


def parse_closed_at_utc(summary_block: str) -> datetime | None:
    m = CLOSED_AT_RE.search(summary_block)
    if not m:
        return None
    try:
        return datetime.strptime(f"{m.group(1)} {m.group(2)}", "%Y-%m-%d %H:%M").replace(
            tzinfo=timezone.utc
        )
    except ValueError:
        return None


def format_duration_label(delta: timedelta) -> str:
    total_sec = max(0, int(delta.total_seconds()))
    hours, rem = divmod(total_sec, 3600)
    minutes, _ = divmod(rem, 60)
    if hours and minutes:
        human = f"{hours} h {minutes} min"
    elif hours:
        human = f"{hours} h"
    else:
        human = f"{max(minutes, 1) if total_sec > 0 else 0} min"
    decimal_h = round(total_sec / 3600.0, 2)
    if total_sec > 0 and decimal_h < 0.01:
        decimal_h = 0.01
    return f"{human} ({decimal_h:.2f} h)"


def compute_task_duration(
    task_path: Path, summary_block: str
) -> tuple[str | None, float | None, str | None]:
    """
    Return (label, hours, spent_on_yyyy_mm_dd) from filename stamp → Closed at.
    hours is None when duration cannot be computed.
    """
    start = parse_task_start_utc(task_path.name)
    end = parse_closed_at_utc(summary_block)
    if end is None:
        end = datetime.now(timezone.utc)
    if start is None or end < start:
        return None, None, None
    delta = end - start
    label = format_duration_label(delta)
    hours = round(max(delta.total_seconds(), 0) / 3600.0, 2)
    if delta.total_seconds() > 0 and hours < 0.01:
        hours = 0.01
    return label, hours, end.strftime("%Y-%m-%d")


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


def closing_summary_to_textile(
    task_path: Path,
    summary_block: str,
    *,
    duration_label: str | None = None,
) -> str:
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

    if duration_label:
        lines.append(f"* *Time taken:* {duration_label}")

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


def _log_time_entry(
    rid: int,
    hours: float,
    task_basename: str,
    duration_label: str,
    spent_on: str,
) -> bool:
    """Post time_entry; return True on success."""
    comment = f"autoagents: {task_basename} - {duration_label}"
    try:
        add_redmine_time_entry(
            REDMINE_BASE_URL,
            REDMINE_API_KEY,
            rid,
            hours,
            comment,
            spent_on=spent_on,
        )
    except (IssueNotFound, RedmineError) as exc:
        print(f"  Redmine time_entry failed - {exc}", file=sys.stderr)
        return False
    print(f"  Redmine time_entry posted: #{rid} {hours:.2f} h ({duration_label})")
    return True


def post_task_completion_note(task_path: Path, issue_id: int | None = None) -> str:
    """
    Post a Textile completion note to Redmine for a CLOSED task file.
    Includes task duration in the note; also logs a time_entry (fallback if note
    cannot carry the duration).
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
    duration_label, hours, spent_on = compute_task_duration(task_path, summary)
    note_body = closing_summary_to_textile(
        task_path, summary, duration_label=duration_label
    )

    note_ok = False
    try:
        add_redmine_note(REDMINE_BASE_URL, REDMINE_API_KEY, rid, note_body)
        note_ok = True
    except IssueNotFound:
        print(f"  Redmine error - issue #{rid} not found", file=sys.stderr)
        return "failed"
    except RedmineError as exc:
        print(f"  Redmine error - {exc}", file=sys.stderr)
        # Note failed: still try to record time via time_entry directly.
        if hours is not None and duration_label and spent_on:
            if _log_time_entry(rid, hours, task_path.name, duration_label, spent_on):
                print(f"  Redmine: logged time_entry after note failure ({task_path.name})")
        return "failed"

    print(f"  Redmine note posted: #{rid} ({task_path.name})")
    if duration_label:
        print(f"  Redmine note includes Time taken: {duration_label}")
    elif hours is None:
        print("  Redmine warn: could not compute task duration for note", file=sys.stderr)

    # Always log spent time via time_entry when we have hours.
    if hours is not None and duration_label and spent_on:
        if not _log_time_entry(rid, hours, task_path.name, duration_label, spent_on):
            # Retry once directly (explicit time_entry fallback).
            print("  Redmine: retrying time_entry directly...", file=sys.stderr)
            _log_time_entry(rid, hours, task_path.name, duration_label, spent_on)

    return "posted" if note_ok else "failed"
