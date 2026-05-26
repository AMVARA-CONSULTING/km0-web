#!/usr/bin/env python3
"""
Issue Checker Agent — creates FEAT task files from open GitHub issues.
Uses gh CLI; repo from AGENT_GH_REPO env (default AMVARA-CONSULTING/km0-web).
"""
import json
import os
import subprocess
from datetime import datetime, timezone

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
TASKS_DIR = os.path.join(SCRIPT_DIR, "tasks")
GH_REPO = os.environ.get("AGENT_GH_REPO", "AMVARA-CONSULTING/km0-web")


def has_task_file(issue_num: int) -> bool:
    if not os.path.isdir(TASKS_DIR):
        return False
    prefix = f"FEAT-{issue_num}-"
    return any(f.startswith(prefix) for f in os.listdir(TASKS_DIR))


def get_open_issues():
    try:
        result = subprocess.run(
            [
                "gh", "issue", "list",
                "--repo", GH_REPO,
                "--state", "open",
                "--json", "number,title,url",
            ],
            capture_output=True,
            text=True,
            check=True,
            timeout=60,
        )
        return json.loads(result.stdout)
    except (subprocess.CalledProcessError, json.JSONDecodeError, FileNotFoundError):
        return []


def fetch_issue_details(issue_num: int):
    try:
        result = subprocess.run(
            [
                "gh", "issue", "view", str(issue_num),
                "--repo", GH_REPO,
                "--json", "body,state,title,url,labels,createdAt",
            ],
            capture_output=True,
            text=True,
            check=True,
            timeout=30,
        )
        data = json.loads(result.stdout)
        data["number"] = int(issue_num)
        return data
    except (subprocess.CalledProcessError, json.JSONDecodeError, FileNotFoundError):
        return None


def create_task(issue: dict) -> str:
    num = issue["number"]
    title = issue["title"]
    url = issue["url"]
    body = issue.get("body") or ""
    created = issue.get("createdAt", "")
    labels = issue.get("labels", [])
    labels_str = ", ".join(str(l.get("name", "")) for l in labels) if labels else "none"

    clean_body = body.replace("\n", " ") if body else "[No issue body]"
    summary = clean_body[:250].strip()
    if len(clean_body) > 250:
        summary += "..."

    slug = title.lower()
    for ch in " /_":
        slug = slug.replace(ch, "-")
    slug = "".join(c if c.isalnum() or c == "-" else "" for c in slug)[:40].strip("-") or "issue"

    now = datetime.now(timezone.utc).strftime("%Y%m%d-%H%M")
    filename = f"FEAT-{num}-{now}-{slug}.md"
    filepath = os.path.join(TASKS_DIR, filename)

    content = f"""# {title}

## GitHub Issue
- **Issue:** {url}
- **Number:** #{num}
- **Labels:** {labels_str}
- **Created:** {created}

## Problem / goal
{summary}

## High-level instructions for coder
- Read the full issue at {url}
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/{GH_REPO}
- Runbook: docs/runbook.md
"""
    os.makedirs(TASKS_DIR, exist_ok=True)
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(content)
    return filepath


def run_workflow() -> bool:
    print("=" * 60)
    print("Issue Checker (autoagents)")
    print(f"Repo: {GH_REPO}")
    print("=" * 60)

    issues = get_open_issues()
    if not issues:
        print("\nNo open GitHub issues (or gh not authenticated).")
        return False

    created = 0
    for issue in issues:
        num = issue["number"]
        if has_task_file(num):
            print(f"  skip #{num} — FEAT file exists")
            continue
        details = fetch_issue_details(num)
        if not details:
            continue
        labels = [l.get("name", "") for l in details.get("labels", [])]
        if "agent:planned" in labels:
            print(f"  skip #{num} — agent:planned")
            continue
        path = create_task(details)
        print(f"  created: {os.path.basename(path)}")
        created += 1

    print(f"\nCreated {created} task file(s)")
    return created > 0


if __name__ == "__main__":
    run_workflow()
