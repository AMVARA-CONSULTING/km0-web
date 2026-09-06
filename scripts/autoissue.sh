#!/usr/bin/env bash
# Autoissue: drain queue JSON files, draft issues via cursor-agent, create GitHub issues.
# On cursor-agent or draft-create failure: raw fallback (verbatim idea + label + AutoMail).
set -euo pipefail

REPO_ROOT="${KM0_WEB_ROOT:-/opt/km0-web}"
PATH="/root/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH:-}"
QUEUE="${KM0_IDEAS_QUEUE_ROOT:-/var/spool/km0-ideas}"
GH_REPO="${AGENT_GH_REPO:-AMVARA-CONSULTING/km0-web}"
LABEL="waiting for human validation"
LOG="${KM0_IDEAS_LOG:-/var/log/km0-ideas/autoissue.log}"
LOCK="/var/run/km0-idea-processor.lock"
PROMPT="${REPO_ROOT}/autoissue/autoissue-agent.md"
DRAFTS="${REPO_ROOT}/autoissue/drafts"
RAW_FALLBACK="${REPO_ROOT}/scripts/autoissue-raw-fallback.sh"

repo_for_scope() {
  case "${1:-web}" in
    cloud) printf '%s\n' "AMVARA-CONSULTING/km0-opencloud" ;;
    mail) printf '%s\n' "AMVARA-CONSULTING/km0-mail" ;;
    *) printf '%s\n' "AMVARA-CONSULTING/km0-web" ;;
  esac
}

mkdir -p "$QUEUE"/{incoming,processing,processed,failed} "$DRAFTS" "$(dirname "$LOG")"

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
  # AutoMail lives in repo-root .env (receiver EnvironmentFile).
  local root_env="${REPO_ROOT}/.env"
  if [[ -f "$root_env" ]]; then
    set -a
    # shellcheck disable=SC1090
    source "$root_env"
    set +a
  fi
}

# Prefer host `gh` OAuth/session when available. Exporting a fine-grained
# GH_TOKEN that lacks org approval overrides host auth and breaks createIssue.
resolve_gh_auth() {
  if [[ "${KM0_IDEAS_FORCE_GH_TOKEN:-0}" == "1" && -n "${GH_TOKEN:-}" ]]; then
    export GH_TOKEN
    log "gh auth: forced GH_TOKEN from env"
    return 0
  fi
  if gh auth status --hostname github.com >/dev/null 2>&1; then
    unset GH_TOKEN || true
    log "gh auth: using host gh session (GH_TOKEN unset)"
    return 0
  fi
  if [[ -n "${GH_TOKEN:-}" ]]; then
    export GH_TOKEN
    log "gh auth: using GH_TOKEN from env (host gh not authenticated)"
    return 0
  fi
  log "gh auth: no host session and GH_TOKEN not set, aborting"
  return 1
}

ensure_label() {
  if ! gh label list --repo "$GH_REPO" --json name -q '.[].name' 2>/dev/null | grep -qxF "$LABEL"; then
    gh label create "$LABEL" --repo "$GH_REPO" --color "C5DEF5" \
      --description "User idea pending human review" >/dev/null 2>&1 || true
  fi
}

run_cursor_draft() {
  local json_file="$1" queue_id="$2" draft_path="$3" full_prompt rc

  if [[ ! -f "$PROMPT" ]]; then
    log "missing prompt: $PROMPT"
    return 1
  fi
  if ! command -v cursor-agent >/dev/null 2>&1; then
    log "cursor-agent not on PATH"
    return 1
  fi

  rm -f "$draft_path"

  full_prompt="$(cat "$PROMPT")

---

Loop message:
Queue JSON (read this file): ${json_file}
Output draft (write ONLY this file): ${draft_path}
Queue ID: ${queue_id}
Do not create GitHub issues. Do not edit application source. Do your job."

  log "cursor-agent start queue_id=${queue_id}"
  set +e
  cursor-agent --yolo --print --trust --workspace "$REPO_ROOT" "$full_prompt"
  rc=$?
  set -e
  if (( rc != 0 )); then
    log "cursor-agent exited ${rc} queue_id=${queue_id}"
    return 1
  fi
  if [[ ! -s "$draft_path" ]]; then
    log "draft missing or empty: ${draft_path}"
    return 1
  fi
  log "cursor-agent draft ok queue_id=${queue_id}"
  return 0
}

create_issue_from_draft() {
  local draft_path="$1"
  local skip_human_validation="${2:-false}"
  local title body_file issue_url issue_num create_args

  title="$(python3 - "$draft_path" <<'PY'
import sys
text = open(sys.argv[1], encoding="utf-8").read()
if not text.startswith("---"):
    raise SystemExit("no frontmatter")
parts = text.split("---", 2)
if len(parts) < 3:
    raise SystemExit("bad frontmatter")
title = None
for line in parts[1].splitlines():
    if line.startswith("title:"):
        title = line.split(":", 1)[1].strip().strip('"').strip("'")
        break
if not title:
    raise SystemExit("missing title")
if len(title) > 256:
    title = title[:253] + "..."
print(title.replace("\n", " "))
PY
)" || {
    log "draft parse failed (title): ${draft_path}"
    return 1
  }

  body_file="$(mktemp)"
  if ! python3 - "$draft_path" "$body_file" <<'PY'
import sys
text = open(sys.argv[1], encoding="utf-8").read()
parts = text.split("---", 2)
body = parts[2].lstrip("\n") if len(parts) >= 3 else ""
open(sys.argv[2], "w", encoding="utf-8").write(body)
PY
  then
    rm -f "$body_file"
    log "draft parse failed (body): ${draft_path}"
    return 1
  fi

  create_args=(issue create --repo "$GH_REPO" --title "$title" --body-file "$body_file")
  if [[ "$skip_human_validation" != "true" ]]; then
    ensure_label
    create_args+=(--label "$LABEL")
  fi
  if ! issue_url="$(gh "${create_args[@]}" 2>>"$LOG")"; then
    rm -f "$body_file"
    log "gh issue create failed for draft ${draft_path}"
    return 1
  fi
  rm -f "$body_file"

  issue_num="${issue_url##*/}"
  printf '%s\n' "$issue_num"
  return 0
}

run_raw_fallback() {
  local json_file="$1" draft_path="$2" skip_human_validation="$3" reason="$4"
  if [[ ! -x "$RAW_FALLBACK" ]]; then
    log "raw fallback script missing or not executable: ${RAW_FALLBACK}"
    return 1
  fi
  "$RAW_FALLBACK" "$json_file" "$draft_path" "$skip_human_validation" "$reason"
}

write_meta_and_finish() {
  local base="$1" queue_id="$2" issue_num="$3" scope="$4" draft_path="$5" skip_human_validation="$6" mode="$7"
  local issue_url meta_path
  issue_url="https://github.com/${GH_REPO}/issues/${issue_num}"
  meta_path="$QUEUE/processed/${base%.json}.meta.json"
  jq -n \
    --argjson issue "$issue_num" \
    --arg url "$issue_url" \
    --arg id "$queue_id" \
    --arg scope "$scope" \
    --arg repo "$GH_REPO" \
    --arg draft "$draft_path" \
    --arg mode "$mode" \
    --argjson skipHumanValidation "$skip_human_validation" \
    '{issue: $issue, issueUrl: $url, queueId: $id, scope: $scope, repo: $repo, draftPath: $draft, skipHumanValidation: $skipHumanValidation, mode: $mode, processedAt: (now | strftime("%Y-%m-%dT%H:%M:%SZ"))}' \
    > "$meta_path"

  if [[ -f "$draft_path" ]]; then
    mv "$draft_path" "$QUEUE/processed/${queue_id}.draft.md"
  fi
  log "created issue #${issue_num} in ${GH_REPO} for ${base} (queue id ${queue_id}, scope ${scope}, skipHumanValidation=${skip_human_validation}, mode=${mode})"
}

process_one() {
  local file="$1" base queue_id draft_path issue_num scope skip_human_validation

  base="$(basename "$file")"

  if ! jq -e . "$file" >/dev/null 2>&1; then
    log "invalid json: $base"
    return 1
  fi

  queue_id="$(jq -r '.id // empty' "$file")"
  if [[ -z "$queue_id" || "$queue_id" == "null" ]]; then
    log "missing queue id: $base"
    return 1
  fi

  if [[ -z "$(jq -r '.idea // empty' "$file")" ]]; then
    log "missing idea: $base"
    return 1
  fi

  scope="$(jq -r '.scope // "web"' "$file")"
  case "$scope" in
    web | cloud | mail) ;;
    *) scope="web" ;;
  esac
  GH_REPO="$(repo_for_scope "$scope")"

  skip_human_validation="$(jq -r 'if .skipHumanValidation == true then "true" else "false" end' "$file")"

  draft_path="${DRAFTS}/${queue_id}.md"

  if run_cursor_draft "$file" "$queue_id" "$draft_path"; then
    if issue_num="$(create_issue_from_draft "$draft_path" "$skip_human_validation")"; then
      write_meta_and_finish "$base" "$queue_id" "$issue_num" "$scope" "$draft_path" "$skip_human_validation" "cursor-draft"
      return 0
    fi
    log "draft create failed; raw fallback queue_id=${queue_id}"
    if ! issue_num="$(run_raw_fallback "$file" "$draft_path" "$skip_human_validation" "gh issue create failed after cursor draft")"; then
      return 1
    fi
    write_meta_and_finish "$base" "$queue_id" "$issue_num" "$scope" "$draft_path" "$skip_human_validation" "raw-fallback"
    return 0
  fi

  log "cursor-agent failed; raw fallback queue_id=${queue_id}"
  if ! issue_num="$(run_raw_fallback "$file" "$draft_path" "$skip_human_validation" "cursor-agent failed")"; then
    return 1
  fi
  write_meta_and_finish "$base" "$queue_id" "$issue_num" "$scope" "$draft_path" "$skip_human_validation" "raw-fallback"
  return 0
}

load_env

if ! resolve_gh_auth; then
  exit 1
fi

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
