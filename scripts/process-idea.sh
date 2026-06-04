#!/usr/bin/env bash
# Script 2: drain queue files and create GitHub issues (host-only, no HTTP).
set -euo pipefail

QUEUE="${KM0_IDEAS_QUEUE_ROOT:-/var/spool/km0-ideas}"
GH_REPO="${AGENT_GH_REPO:-AMVARA-CONSULTING/km0-web}"
LABEL="waiting for human validation"
LOG="${KM0_IDEAS_LOG:-/var/log/km0-ideas/processor.log}"
LOCK="/var/run/km0-idea-processor.lock"

mkdir -p "$QUEUE"/{incoming,processing,processed,failed} "$(dirname "$LOG")"

log() {
  printf '%s %s\n' "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$*" >> "$LOG"
}

load_env() {
  local env_file="${KM0_IDEAS_ENV:-/opt/km0-web/autoagents/.env}"
  if [[ -f "$env_file" ]]; then
    set -a
    # shellcheck disable=SC1090
    source "$env_file"
    set +a
  fi
}

ensure_label() {
  if ! gh label list --repo "$GH_REPO" --json name -q '.[].name' 2>/dev/null | grep -qxF "$LABEL"; then
    gh label create "$LABEL" --repo "$GH_REPO" --color "C5DEF5" \
      --description "User idea pending human review" >/dev/null 2>&1 || true
  fi
}

process_one() {
  local file="$1"
  local base issue_url issue_num title_line title body name idea locale id receivedAt

  base="$(basename "$file")"

  if ! jq -e . "$file" >/dev/null 2>&1; then
    log "invalid json: $base"
    return 1
  fi

  id="$(jq -r '.id // empty' "$file")"
  locale="$(jq -r '.locale // "es"' "$file")"
  name="$(jq -r '.name // empty' "$file")"
  idea="$(jq -r '.idea // empty' "$file")"
  receivedAt="$(jq -r '.receivedAt // empty' "$file")"

  if [[ -z "$idea" || "$idea" == "null" ]]; then
    log "missing idea: $base"
    return 1
  fi

  title_line="$(printf '%s' "$idea" | head -n1 | tr -d '\r' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
  if [[ ${#title_line} -gt 80 ]]; then
    title_line="${title_line:0:77}..."
  fi
  if [[ -z "$title_line" ]]; then
    title_line="User feedback"
  fi
  title="[ideas/${locale}] ${title_line}"

  body="$(jq -n \
    --arg id "$id" \
    --arg receivedAt "$receivedAt" \
    --arg locale "$locale" \
    --arg name "$name" \
    --arg idea "$idea" \
    --arg meta "$(jq -c '.meta // {}' "$file")" \
    'def row(k; v): "| " + k + " | " + v + " |\n";
     "## User idea\n\n" + $idea + "\n\n---\n\n| Field | Value |\n|-------|-------|\n"
     + row("Queue ID"; "`" + $id + "`")
     + row("Received"; $receivedAt)
     + row("Locale"; $locale)
     + (if ($name | length) > 0 then row("Name"; $name) else "" end)
     + row("Source"; "[/ideas/](https://km0digital.com/ideas/) form")
     + "\n**Meta:** `" + $meta + "`\n\n"
     + "_Submitted via public ideas intake. Review before removing the **waiting for human validation** label._"
    ')"

  ensure_label

  if ! issue_url="$(gh issue create --repo "$GH_REPO" --title "$title" --body "$body" --label "$LABEL" 2>>"$LOG")"; then
    log "gh issue create failed: $base"
    return 1
  fi

  issue_num="${issue_url##*/}"
  jq -n --argjson issue "$issue_num" --arg url "$issue_url" --arg id "$id" \
    '{issue: $issue, issueUrl: $url, queueId: $id, processedAt: (now | strftime("%Y-%m-%dT%H:%M:%SZ"))}' \
    > "$QUEUE/processed/${base%.json}.meta.json"
  log "created issue #${issue_num} for ${base} (queue id ${id})"
  return 0
}

load_env

if [[ -z "${GH_TOKEN:-}" ]]; then
  log "GH_TOKEN not set, aborting"
  exit 1
fi

export GH_TOKEN

exec 9>"$LOCK"
if ! flock -n 9; then
  exit 0
fi

shopt -s nullglob
for f in "$QUEUE/incoming"/*.json; do
  base="$(basename "$f")"
  claimed="$QUEUE/processing/$base"
  if mv "$f" "$claimed" 2>/dev/null; then
    rc=0
    process_one "$claimed" || rc=$?
    if [[ "$rc" -eq 0 ]]; then
      mv "$claimed" "$QUEUE/processed/$base"
    else
      printf '%s exit=%s file=%s\n' "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$rc" "$base" \
        > "$QUEUE/failed/${base%.json}.err"
      mv "$claimed" "$QUEUE/failed/$base"
    fi
  fi
done
