#!/usr/bin/env bash
# autoagents loop orchestrator. Run from repo root:
#   ./autoagents/autoagents-loop.sh [COMMAND]
#
# Requires: cursor-agent on PATH, gh authenticated (see scripts/setup-autoagents-gh.sh).
# No Ollama/llama.cpp - log triage uses heuristics only (AGENT_001_OLLAMA_LOG_TRIAGE defaults to 0).

set -euo pipefail

SCRIPTDIR="$(cd "$(dirname "$0")" && pwd)"
TASKDIR="${SCRIPTDIR}/tasks"
REPO_ROOT="$(cd "${SCRIPTDIR}/.." && pwd)"
sleepminutes="${AGENT_LOOP_SLEEP_MINUTES:-5}"
sleepseconds=$((sleepminutes * 60))
# Runtime artifacts (preflight digest, gh stderr) stay inside the repo, not /tmp.
AGENT_LOOP_TMP="${AGENT_LOOP_TMP:-${SCRIPTDIR}/.runtime}"
GH_REPO="${AGENT_GH_REPO:-AMVARA-CONSULTING/km0-web}"
GIT_BRANCH="${AGENT_GIT_BRANCH:-main}"
LAST_REVIEW_FILE="${SCRIPTDIR}/001-gh-reviewer/time-of-last-review.txt"
ENV_FILE="${SCRIPTDIR}/.env"

if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC1090
  set -a && source "$ENV_FILE" && set +a
fi

cd "$SCRIPTDIR" || exit 1

have_cursor_agent() {
  command -v cursor-agent >/dev/null 2>&1
}

issue_linked_in_root_tasks() {
  local num="$1"
  local f bn
  shopt -s nullglob
  for f in "$TASKDIR"/*.md; do
    bn=$(basename "$f")
    [[ "$bn" == "README.md" ]] && continue
    [[ "$bn" == "TEMPLATE.md" ]] && continue
    if grep -qE "#${num}([^0-9]|$)|/issues/${num}([^0-9]|$)" "$f" 2>/dev/null; then
      shopt -u nullglob
      return 0
    fi
  done
  shopt -u nullglob
  return 1
}

last_review_iso_utc() {
  [[ -f "$LAST_REVIEW_FILE" ]] || return 0
  head -1 "$LAST_REVIEW_FILE" | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z' | head -1 || true
}

gh_stderr_looks_like_auth_failure() {
  local f="$1"
  [[ -f "$f" ]] || return 1
  grep -qiE '401|Bad credentials|bad credentials|not authenticated|Authentication failed|HTTP 401|must be authenticated|not logged in|gh auth login|could not authenticate|invalid.*token' "$f" 2>/dev/null
}

prepare_001_preflight_context() {
  local ctx="$1"
  mkdir -p "$(dirname "$ctx")"
  G001_GH_OK=0
  G001_GH_AUTH_FAILED=0
  G001_UNTRACKED_ISSUES=0
  G001_LOG_SIGNALS=0
  local utc
  utc=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
  {
    echo "autoagents 001 preflight - $utc (UTC)"
    echo "repo: $GH_REPO  branch: $GIT_BRANCH  tasks: $TASKDIR"
    echo ""
    echo "=== GitHub (open issues, limit 40) ==="
  } >"$ctx"

  local gh_list_err gh_api_err
  gh_list_err="$(dirname "$ctx")/gh-issue-list-stderr.$$"
  gh_api_err="$(dirname "$ctx")/gh-api-stderr.$$"
  rm -f "$gh_list_err" "$gh_api_err"

  if command -v gh >/dev/null 2>&1; then
    if gh issue list --repo "$GH_REPO" --state open -L 40 --json number,title,labels,url,updatedAt >>"$ctx" 2>"$gh_list_err"; then
      rm -f "$gh_list_err"
      G001_GH_OK=1
      local num untracked=0
      while IFS= read -r num; do
        [[ -z "${num:-}" ]] && continue
        if ! issue_linked_in_root_tasks "$num"; then
          untracked=$((untracked + 1))
          echo "UNTRACKED_IN_TASKS issue #$num" >>"$ctx"
        fi
      done < <(gh issue list --repo "$GH_REPO" --state open -L 40 --json number -q '.[].number' 2>/dev/null || true)
      G001_UNTRACKED_ISSUES=$untracked
    else
      {
        echo "(gh issue list failed, see stderr below, trying REST fallback)"
        echo "=== gh issue list stderr ==="
        cat "$gh_list_err" 2>/dev/null || true
      } >>"$ctx"
      if gh_stderr_looks_like_auth_failure "$gh_list_err"; then
        G001_GH_AUTH_FAILED=1
      fi
      rm -f "$gh_list_err"
      {
        echo ""
        echo "=== gh api fallback: repos/${GH_REPO}/issues?state=open&per_page=40 (no PRs) ==="
      } >>"$ctx"
      if gh api "repos/${GH_REPO}/issues?state=open&per_page=40" \
        --jq '.[] | select(.pull_request == null) | {number,title,labels:[.labels[].name],updatedAt,url}' >>"$ctx" 2>"$gh_api_err"; then
        rm -f "$gh_api_err"
        G001_GH_OK=1
        G001_GH_AUTH_FAILED=0
        local num2 untracked2=0
        while IFS= read -r num2; do
          [[ -z "${num2:-}" ]] && continue
          if ! issue_linked_in_root_tasks "$num2"; then
            untracked2=$((untracked2 + 1))
            echo "UNTRACKED_IN_TASKS issue #$num2" >>"$ctx"
          fi
        done < <(gh api "repos/${GH_REPO}/issues?state=open&per_page=40" --jq '.[] | select(.pull_request == null) | .number' 2>/dev/null || true)
        G001_UNTRACKED_ISSUES=$untracked2
      else
        {
          echo "(gh api fallback also failed - stderr:"
          cat "$gh_api_err" 2>/dev/null || true
          echo ")"
          echo "Fix: ./scripts/setup-autoagents-gh.sh  or  export GH_TOKEN=<token with repo scope>"
        } >>"$ctx"
        if gh_stderr_looks_like_auth_failure "$gh_api_err"; then
          G001_GH_AUTH_FAILED=1
        fi
        rm -f "$gh_api_err"
      fi
    fi
  else
    echo "(gh not on PATH - run scripts/setup-autoagents-gh.sh)" >>"$ctx"
  fi

  {
    echo ""
    echo "=== Docker log incident heuristics (km0-web) ==="
  } >>"$ctx"

  local last_iso
  last_iso=$(last_review_iso_utc)
  local log_args=()
  if [[ -n "$last_iso" ]]; then
    log_args=(--since "$last_iso")
  else
    log_args=(--tail 800)
  fi

  if docker info >/dev/null 2>&1; then
    local c raw hits
    for c in km0-web; do
      if docker inspect "$c" >/dev/null 2>&1; then
        echo "" >>"$ctx"
        echo "--- $c (${log_args[*]}) ---" >>"$ctx"
        raw=$(docker logs "$c" "${log_args[@]}" 2>&1 || true)
        hits=$(printf '%s\n' "$raw" | grep -iE \
          'traceback|panic|fatal|FATAL|error level|level=error|"level":"error"|"level":"fatal"|Internal Server|502 Bad Gateway|503 Service|connection refused|OOM|out of memory' \
          | head -n 80 || true)
        if [[ -z "$hits" ]]; then
          hits=$(printf '%s\n' "$raw" | grep -iE 'error|warn|fail' | grep -viE 'level=debug|no error' | head -n 40 || true)
        fi
        if [[ -n "$hits" ]]; then
          G001_LOG_SIGNALS=1
          printf '%s\n' "$hits" >>"$ctx"
        else
          echo "(no heuristic matches in sampled window)" >>"$ctx"
        fi
      else
        echo "" >>"$ctx"
        echo "--- $c (container not present) ---" >>"$ctx"
      fi
    done
  else
    echo "Docker not available - log pass skipped." >>"$ctx"
  fi

  {
    echo ""
    echo "=== Preflight summary ==="
    echo "G001_GH_OK=$G001_GH_OK G001_GH_AUTH_FAILED=$G001_GH_AUTH_FAILED G001_UNTRACKED_ISSUES=$G001_UNTRACKED_ISSUES G001_LOG_SIGNALS=$G001_LOG_SIGNALS"
  } >>"$ctx"
}

should_run_001_cursor_agent() {
  if [[ "${AGENT_001_SKIP_PREFLIGHT:-0}" == "1" ]]; then
    return 0
  fi
  if [[ "${AGENT_LOG_REVIEWER_ALWAYS:-0}" == "1" ]]; then
    return 0
  fi
  if [[ "$G001_LOG_SIGNALS" == "1" ]]; then
    if [[ "${AGENT_001_LOCAL_LOG_REVIEWER:-1}" != "0" ]] && [[ "$G001_GH_OK" == "1" ]] && [[ "${G001_UNTRACKED_ISSUES:-0}" -eq 0 ]]; then
      return 1
    fi
    return 0
  fi
  if [[ "$G001_GH_OK" == "1" ]] && [[ "${G001_UNTRACKED_ISSUES:-0}" -gt 0 ]]; then
    return 0
  fi
  if [[ "$G001_GH_OK" == "0" ]] && [[ "${AGENT_001_RUN_WHEN_GH_UNKNOWN:-0}" == "1" ]]; then
    return 0
  fi
  return 1
}

sync_repo() {
  if [[ "${AGENT_GIT_SYNC:-1}" == "0" ]]; then
    echo "----- git sync (skip: AGENT_GIT_SYNC=0)"
    return 0
  fi
  echo "-----> git sync ${GIT_BRANCH} $(date "+%Y-%m-%d %H:%M:%S") <----"
  if ! bash "${REPO_ROOT}/scripts/git-sync-main.sh"; then
    echo "ERROR: git sync failed. Resolve and retry." >&2
    return 1
  fi
}

any_root_task_glob() {
  shopt -s nullglob
  local g matches
  for g in "$@"; do
    matches=("$TASKDIR"/$g)
    if (( ${#matches[@]} > 0 )); then
      shopt -u nullglob
      return 0
    fi
  done
  shopt -u nullglob
  return 1
}

has_repo_uncommitted_changes() {
  ( cd "$REPO_ROOT" && { ! git diff --quiet 2>/dev/null || ! git diff --staged --quiet 2>/dev/null; } )
}

committer_changed_paths() {
  ( cd "$REPO_ROOT" && {
    git diff --name-only HEAD 2>/dev/null || true
    git ls-files --others --exclude-standard 2>/dev/null || true
  } | sort -u )
}

committer_paths_all_local_stamp_allowlist() {
  local f had=0
  while IFS= read -r f; do
    [[ -z "$f" ]] && continue
    had=1
    case "$f" in
      autoagents/001-gh-reviewer/time-of-last-review.txt) ;;
      *) return 1 ;;
    esac
  done < <(committer_changed_paths)
  ((had == 1))
}

committer_try_local_stamp_only() {
  [[ "${AGENT_COMMITTER_LOCAL:-1}" == "0" ]] && return 1
  local br
  br=$(cd "$REPO_ROOT" && git rev-parse --abbrev-ref HEAD 2>/dev/null) || return 1
  if [[ "$br" != "$GIT_BRANCH" ]]; then
    echo "----- committer (local skip: repo not on ${GIT_BRANCH})" >&2
    return 1
  fi
  if ! committer_paths_all_local_stamp_allowlist; then
    return 1
  fi
  (
    cd "$REPO_ROOT" || exit 1
    git add -- autoagents/001-gh-reviewer/time-of-last-review.txt
    if git diff --staged --quiet; then
      exit 1
    fi
    git commit -m "chore(autoagents): update 001 reviewer time-of-last-review stamp"
    set +e
    git pull --rebase --autostash origin "$GIT_BRANCH"
    local prc=$?
    set -e
    if ((prc != 0)); then
      echo "----- committer (local: git pull --rebase failed)" >&2
      exit 1
    fi
    set +e
    git push origin "$GIT_BRANCH"
    local psh=$?
    set -e
    if ((psh != 0)); then
      echo "----- committer (local: git push failed)" >&2
      exit 1
    fi
    exit 0
  )
}

run_agent() {
  local desc="$1" cond="$2" prompt="$3" msg="$4"
  local p="${SCRIPTDIR}/${prompt}"
  if [[ ! -f "$p" ]]; then
    echo "----- $desc (skip: missing prompt $prompt, see docs/agent-loop.md)"
    return 0
  fi
  if ! have_cursor_agent; then
    echo "----- $desc (skip: cursor-agent not on PATH)"
    return 0
  fi
  if eval "$cond" 2>/dev/null; then
    echo "-----> $desc $(date "+%Y-%m-%d %H:%M:%S") <----"
    echo "starting cursor-agent with prompt: $prompt"
    echo "msg: $msg"
    echo "---"
    local prompt_body full_prompt
    prompt_body="$(cat "$p")"
    full_prompt="${prompt_body}

---

Loop message:
${msg}"
    set +e
    cursor-agent --yolo --print --trust --workspace "$REPO_ROOT" "$full_prompt"
    local _ca_rc=$?
    set -e
    if ((_ca_rc != 0)); then
      echo "----- $desc: cursor-agent exited ${_ca_rc} (continuing loop, non-fatal)" >&2
    fi
  else
    echo "----- $desc (skip: nothing to do)"
  fi
  echo "<-- end of $desc $(date "+%Y-%m-%d %H:%M:%S") -->"
  echo "--------------------------------"
  echo ""
}

append_001_local_no_cursor_stamp() {
  local ctx="$1"
  local iso line
  iso=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  line="${iso} UTC | 001 local (no cursor-agent) | FEAT: 0 | NEW: 0 | G001_GH_OK=${G001_GH_OK} G001_UNTRACKED_ISSUES=${G001_UNTRACKED_ISSUES} G001_LOG_SIGNALS=${G001_LOG_SIGNALS} | digest: ${ctx}"
  mkdir -p "$(dirname "$LAST_REVIEW_FILE")"
  printf '%s\n\n' "$line" >>"$LAST_REVIEW_FILE"
  {
    echo ""
    echo "=== 001 cursor-agent skipped (local log reviewer) ==="
    echo "$line"
  } >>"$ctx"
}

warn_001_github_auth_if_needed() {
  local d="${AGENT_LOOP_TMP:-${SCRIPTDIR}/.runtime}"
  if [[ "${G001_GH_AUTH_FAILED:-0}" == "1" ]]; then
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >&2
    echo "!!! 001 / GitHub: NOT AUTHENTICATED. Run ./scripts/setup-autoagents-gh.sh     !!!" >&2
    echo "!!! Digest: $d/001-latest-context.txt                                          !!!" >&2
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >&2
  fi
}

run_issue_checker_and_gh_sync() {
  if ! command -v python3 >/dev/null 2>&1; then
    echo "----- issue checker (skip: python3 not on PATH)"
    return 0
  fi
  echo "----- issue checker (FEAT from open issues)"
  python3 "${SCRIPTDIR}/issue_checker_agent.py" || true
  echo "----- GitHub sync (FEAT → planned)"
  python3 "${SCRIPTDIR}/sync_github_from_tasks.py" planned || true
}

run_gh_sync_closed() {
  if ! command -v python3 >/dev/null 2>&1; then
    return 0
  fi
  echo "----- GitHub sync (CLOSED → comment + close, incl. done/)"
  python3 "${SCRIPTDIR}/sync_github_from_tasks.py" closed || true
}

step_log_reviewer() {
  echo "-----> log reviewer (001) <----"
  mkdir -p "$AGENT_LOOP_TMP"
  local ctx="${AGENT_LOOP_TMP}/001-latest-context.txt"
  prepare_001_preflight_context "$ctx"
  echo "----- 001 preflight digest: $ctx"
  warn_001_github_auth_if_needed
  if [[ "$G001_GH_OK" == "1" ]] && [[ "${G001_UNTRACKED_ISSUES:-0}" -gt 0 ]]; then
    run_issue_checker_and_gh_sync
    prepare_001_preflight_context "$ctx"
  fi
  if should_run_001_cursor_agent; then
    if ! have_cursor_agent; then
      echo "----- log reviewer (001) (skip: cursor-agent not on PATH)" >&2
      return 0
    fi
    if ! sync_repo; then
      echo "----- log reviewer (001) (skip: git sync failed)" >&2
      return 0
    fi
    prepare_001_preflight_context "$ctx"
    warn_001_github_auth_if_needed
    if ! should_run_001_cursor_agent; then
      echo "----- log reviewer (001) (skip after sync: gate closed)"
      return 0
    fi
    local msg
    msg="Run 001: Read the preflight digest first (absolute path): $ctx
Then follow 001-gh-reviewer.md - (A) GitHub → up to 3 × FEAT-*.md. (B) Docker logs → NEW-*.md only for real standing incidents. gh comment/label. Task conventions: autoagents/TASKS-README.md. Do your job."
    run_agent "log reviewer (001)" \
      "true" \
      "001-gh-reviewer.md" \
      "$msg"
  elif [[ "$G001_LOG_SIGNALS" == "1" ]] && [[ "$G001_GH_OK" == "1" ]] && [[ "${G001_UNTRACKED_ISSUES:-0}" -eq 0 ]] && [[ "${AGENT_001_LOCAL_LOG_REVIEWER:-1}" != "0" ]]; then
    echo "----- log reviewer (001) (skip cursor-agent: Docker heuristics only, GitHub ok, zero untracked issues)"
    append_001_local_no_cursor_stamp "$ctx"
  else
    echo "----- log reviewer (001) (skip: nothing for 001)"
  fi
}

step_feat() {
  if ! any_root_task_glob 'FEAT-*.md'; then
    echo "----- feature coding (FEAT) (skip: no FEAT-*.md)"
    return 0
  fi
  if ! sync_repo; then return 0; fi
  echo "-----> feature coding (FEAT) <----"
  run_agent "feature coding (FEAT)" \
    "any_root_task_glob 'FEAT-*.md'" \
    "010-feature-coder.md" \
    "Start feature coding now. Pick up a FEAT task if any. Do your job."
}

step_feature_coder_handoff() {
  if ! any_root_task_glob 'WIP-*.md'; then
    echo "----- feature coder handoff (012) (skip: no WIP-*.md)"
    return 0
  fi
  if ! sync_repo; then return 0; fi
  echo "-----> feature coder handoff (012) <----"
  run_agent "feature coder handoff (012)" \
    "any_root_task_glob 'WIP-*.md'" \
    "012-feature-coder-handoff.md" \
    "Handoff pass: review WIP-*.md; if complete per TASKS-README.md, rename to UNTESTED-*.md. Do your job."
}

step_coder() {
  if ! any_root_task_glob 'NEW-*.md' 'WIP-*.md'; then
    echo "----- coding (skip: no NEW-*.md or WIP-*.md)"
    return 0
  fi
  if ! sync_repo; then return 0; fi
  echo "-----> coding (NEW / WIP) <----"
  run_agent "coding" \
    "any_root_task_glob 'NEW-*.md' 'WIP-*.md'" \
    "002-coder/CODER.md" \
    "Start coding now. Prefer NEW → WIP; continue WIP to UNTESTED. Implement in this repo. Do your job."
}

step_tester() {
  if ! any_root_task_glob 'UNTESTED-*.md' 'TESTING-*.md'; then
    echo "----- testing (skip: no UNTESTED-*.md or TESTING-*.md)"
    return 0
  fi
  if ! sync_repo; then return 0; fi
  echo "-----> testing <----"
  run_agent "testing" \
    "any_root_task_glob 'UNTESTED-*.md' 'TESTING-*.md'" \
    "020-test.md" \
    "Start testing now. UNTESTED → TESTING → CLOSED (pass) or WIP (fail). Do your job."
}

step_closing_review() {
  if ! any_root_task_glob 'CLOSED-*.md'; then
    echo "----- closing reviewer (skip: no CLOSED-*.md)"
    return 0
  fi
  if ! sync_repo; then return 0; fi
  echo "-----> closing reviewer <----"
  run_agent "closing" \
    "any_root_task_glob 'CLOSED-*.md'" \
    "030-closing-reviewer.md" \
    "Process CLOSED-*.md; prepend summary; move to done/ with scripts/move-agent-task-to-done.sh. Do your job."
}

step_committer() {
  if ! has_repo_uncommitted_changes; then
    echo "----- committer (skip: no uncommitted changes)"
    return 0
  fi
  if ! sync_repo; then return 0; fi
  if ! has_repo_uncommitted_changes; then
    echo "----- committer (skip after sync: clean tree)"
    return 0
  fi
  echo "-----> committer <----"

  if [[ "${AGENT_COMMITTER_LOCAL:-1}" != "0" ]] && committer_try_local_stamp_only; then
    echo "----- committer (local: stamp-only commit pushed)"
    return 0
  fi

  if [[ "${AGENT_COMMITTER_USE_CURSOR:-0}" != "1" ]] && [[ "${AGENT_COMMITTER_LOCAL:-1}" != "0" ]]; then
    echo "----- committer (skip cursor-agent: set AGENT_COMMITTER_USE_CURSOR=1 for full committer)"
    ( cd "$REPO_ROOT" && git status -sb ) || true
    return 0
  fi

  if ! have_cursor_agent; then
    echo "----- committer (skip: cursor-agent not on PATH)"
    return 0
  fi
  run_agent "committer" \
    "has_repo_uncommitted_changes" \
    "040-committer.md" \
    "Check uncommitted changes on ${GIT_BRANCH}. Update docs/CHANGELOG.md if present; commit and push origin ${GIT_BRANCH}. Do your job."
}

run_full_cycle() {
  echo "$(date)"
  step_log_reviewer
  local i=0
  local has_feat
  while (( i < 5 )); do
    has_feat=false
    shopt -s nullglob
    for _ in "$TASKDIR"/FEAT-*.md; do has_feat=true; break; done
    shopt -u nullglob
    if ! $has_feat; then
      (( i == 0 )) && echo "----- feature coding (FEAT): queue empty"
      break
    fi
    step_feat
    ((i++)) || true
  done
  step_coder
  step_feature_coder_handoff
  step_tester
  step_closing_review
  run_gh_sync_closed
  step_committer
}

usage() {
  cat >&2 <<EOF
Usage: $(basename "$0") [COMMAND]

  (no args)       Full agent cycle every ${AGENT_LOOP_SLEEP_MINUTES:-5} minutes.

  Single run:
    log, 001        Log / GitHub reviewer
    feat, feature   Feature coder (FEAT-*.md)
    coder           Coder (NEW-*.md / WIP-*.md)
    handoff, 012    WIP → UNTESTED handoff
    tester          Tester (UNTESTED-*.md / TESTING-*.md)
    closing-review  Closing reviewer (CLOSED-*.md)
    committer       Commit when repo has local changes

Environment:
  AGENT_GH_REPO              GitHub repo (default: AMVARA-CONSULTING/km0-web)
  AGENT_GIT_BRANCH           Git branch (default: main)
  AGENT_LOOP_SLEEP_MINUTES   Loop interval (default: 5)
  AGENT_COMMITTER_USE_CURSOR Set 1 to run 040-committer via cursor-agent (default in .env.example)
  AGENT_LOOP_TMP             Runtime dir (default: autoagents/.runtime inside repo)
  GH_TOKEN                   GitHub API token (or autoagents/.env)

See docs/agent-loop.md and .cursor/skills/autoagents/SKILL.md
EOF
}

if [[ -n "${1:-}" ]]; then
  case "$1" in
    help | -h | --help) usage; exit 0 ;;
    log | log-reviewer | 001) step_log_reviewer ;;
    feat | feature) step_feat ;;
    coder) step_coder ;;
    handoff | 012 | feature-handoff) step_feature_coder_handoff ;;
    tester) step_tester ;;
    closing-review | closing-closed)
      step_closing_review
      run_gh_sync_closed
      ;;
    committer) step_committer ;;
    *) usage; exit 1 ;;
  esac
  exit 0
fi

if ! have_cursor_agent; then
  echo "cursor-agent not found on PATH. Install Cursor CLI." >&2
  exit 1
fi

next_cycle_eta_local() {
  local end_epoch=$(( $(date +%s) + sleepseconds ))
  date -d "@$end_epoch" '+%Y-%m-%d %H:%M:%S %z' 2>/dev/null || echo "epoch ${end_epoch}"
}

while true; do
  run_full_cycle
  echo "----- sleeping ${sleepminutes}m; next cycle ~ $(next_cycle_eta_local)"
  sleep "$sleepseconds"
done
