#!/usr/bin/env bash
# Raw fallback when cursor-agent cannot draft: open a GitHub issue with the
# verbatim idea text + waiting-for-human label, then notify AutoMail.
#
# Usage (from autoissue.sh):
#   autoissue-raw-fallback.sh <queue.json> <draft_path> <skipHumanValidation:true|false> <reason>
# Prints issue number on stdout. Exit 0 on success.
set -euo pipefail

REPO_ROOT="${KM0_WEB_ROOT:-/opt/km0-web}"
PATH="/root/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH:-}"
GH_REPO="${AGENT_GH_REPO:-AMVARA-CONSULTING/km0-web}"
LABEL="waiting for human validation"
LOG="${KM0_IDEAS_LOG:-/var/log/km0-ideas/autoissue.log}"
NOTIFY="${REPO_ROOT}/scripts/notify-idea-email.sh"

json_file="${1:-}"
draft_path="${2:-}"
skip_human_validation="${3:-false}"
reason="${4:-cursor-agent unavailable}"

log() {
  printf '%s %s\n' "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$*" >> "$LOG"
}

if [[ -z "$json_file" || ! -f "$json_file" ]]; then
  log "raw-fallback: missing json file"
  exit 1
fi
if [[ -z "$draft_path" ]]; then
  log "raw-fallback: missing draft path"
  exit 1
fi

queue_id="$(jq -r '.id // empty' "$json_file")"
idea="$(jq -r '.idea // empty' "$json_file")"
locale="$(jq -r '.locale // "es"' "$json_file")"
scope="$(jq -r '.scope // "web"' "$json_file")"
name="$(jq -r '.name // empty' "$json_file")"
received_at="$(jq -r '.receivedAt // empty' "$json_file")"

case "$locale" in
  es | ca | en | de) ;;
  *) locale="es" ;;
esac
case "$scope" in
  cloud) GH_REPO="AMVARA-CONSULTING/km0-opencloud" ;;
  mail) GH_REPO="AMVARA-CONSULTING/km0-mail" ;;
  *)
    scope="web"
    GH_REPO="AMVARA-CONSULTING/km0-web"
    ;;
esac

if [[ -z "$queue_id" || -z "$idea" ]]; then
  log "raw-fallback: missing id or idea"
  exit 1
fi

if [[ -z "$name" || "$name" == "null" ]]; then
  name="anonymous"
fi
if [[ -z "$received_at" || "$received_at" == "null" ]]; then
  received_at="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
fi

title="$(python3 -c '
import sys
locale, idea = sys.argv[1], sys.argv[2]
idea = idea.strip().replace("\n", " ")
prefix = f"[ideas/{locale}] "
body = idea[: max(1, 80 - len(prefix))]
if len(idea) > len(body):
    body = body.rstrip() + "..."
print(prefix + body)
' "$locale" "$idea")"

mkdir -p "$(dirname "$draft_path")"

python3 -c '
import sys
from pathlib import Path
draft_path, title, idea, queue_id, received_at, locale, scope, name, reason = sys.argv[1:10]

def fence(text: str) -> str:
    safe = text.replace("```", "''''''")
    return "```\n" + safe + "\n```"

body = f"""## Summary

Raw fallback issue (cursor-agent did not draft). Reason: {reason}.
A human must triage the original submission below.

## Original submission

{fence(idea)}

## Context

| Field | Value |
|-------|-------|
| Queue ID | `{queue_id}` |
| Received (UTC) | `{received_at}` |
| Locale | `{locale}` |
| Product scope | `{scope}` |
| Submitter name | `{name}` |
| Source | Site-wide ideas widget on km0digital.com |
| Intake mode | `raw-fallback` |

## Triage notes

- Type: unclear (raw intake; no agent summary)
- Suggested next step: Read the original submission and rewrite or close after human review.

---

_Submitted via public ideas intake (raw fallback). A human must review and remove the **waiting for human validation** label before autoagents picks this up._
"""

safe_title = title.replace(chr(34), chr(39))
Path(draft_path).write_text(
    "---\ntitle: \"" + safe_title + "\"\n---\n\n" + body,
    encoding="utf-8",
)
' "$draft_path" "$title" "$idea" "$queue_id" "$received_at" "$locale" "$scope" "$name" "$reason"

ensure_label() {
  if ! gh label list --repo "$GH_REPO" --json name -q '.[].name' 2>/dev/null | grep -qxF "$LABEL"; then
    gh label create "$LABEL" --repo "$GH_REPO" --color "C5DEF5" \
      --description "User idea pending human review" >/dev/null 2>&1 || true
  fi
}

body_file="$(mktemp)"
python3 -c '
import sys
text = open(sys.argv[1], encoding="utf-8").read()
parts = text.split("---", 2)
body = parts[2].lstrip("\n") if len(parts) >= 3 else ""
open(sys.argv[2], "w", encoding="utf-8").write(body)
' "$draft_path" "$body_file"

create_args=(issue create --repo "$GH_REPO" --title "$title" --body-file "$body_file")
if [[ "$skip_human_validation" != "true" ]]; then
  ensure_label
  create_args+=(--label "$LABEL")
fi

if ! issue_url="$(gh "${create_args[@]}" 2>>"$LOG")"; then
  rm -f "$body_file"
  log "raw-fallback: gh issue create failed for ${json_file}"
  exit 1
fi
rm -f "$body_file"

issue_num="${issue_url##*/}"
log "raw-fallback: created issue #${issue_num} in ${GH_REPO} queue_id=${queue_id} reason=${reason}"

if [[ -x "$NOTIFY" ]]; then
  preview="${idea:0:200}"
  mail_text="$(printf "Raw fallback: cursor-agent failed (%s).\nIssue: %s\nQueue ID: %s\nLocale: %s\nScope: %s\nName: %s\n\nIdea preview:\n%s\n" \
    "$reason" "$issue_url" "$queue_id" "$locale" "$scope" "$name" "$preview")"
  "$NOTIFY" "$idea" "KM0 ideas RAW FALLBACK -> #${issue_num}" "$mail_text" >>"$LOG" 2>&1 || true
fi

printf "%s\n" "$issue_num"
