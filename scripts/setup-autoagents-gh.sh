#!/usr/bin/env bash
# Configure GitHub CLI for autoagents (Luipy56 / AMVARA-CONSULTING/km0-web).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="${REPO_ROOT}/autoagents/.env"
GH_REPO="${AGENT_GH_REPO:-AMVARA-CONSULTING/km0-web}"

echo "=== autoagents GitHub setup ==="
echo "Account: Luipy56 (yoelberjaga@gmail.com)"
echo "Repo:    ${GH_REPO}"
echo ""

if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC1090
  set -a && source "$ENV_FILE" && set +a
fi

if gh auth status --hostname github.com >/dev/null 2>&1; then
  echo "OK: gh is authenticated."
  gh auth status --hostname github.com
else
  if [[ -n "${GH_TOKEN:-}" ]]; then
    echo "Authenticating gh with GH_TOKEN from autoagents/.env ..."
    printf '%s\n' "$GH_TOKEN" | gh auth login --hostname github.com --with-token
  else
    echo "gh is not authenticated."
    echo ""
    echo "Option A - token file (recommended on server):"
    echo "  1. Create a fine-grained PAT at https://github.com/settings/tokens"
    echo "     Permissions: Issues (Read and write), Contents (Read), Metadata (Read)"
    echo "     Expiration: max 366 days (AMVARA-CONSULTING org forbids longer fine-grained PATs)"
    echo "     Repository: AMVARA-CONSULTING/km0-web"
    echo "     (Comments, labels, and close require Issues write, not read-only)"
    echo "  2. cp autoagents/.env.example autoagents/.env"
    echo "  3. Set GH_TOKEN=github_pat_... in autoagents/.env"
    echo "  4. Re-run: ./scripts/setup-autoagents-gh.sh"
    echo ""
    echo "Option B - interactive login:"
    echo "  gh auth login --hostname github.com --git-protocol ssh --scopes repo,read:org"
    exit 1
  fi
fi

echo ""
echo "Ensuring agent workflow labels exist ..."
gh label create "agent:planned" --repo "$GH_REPO" --color "0E8A16" --description "001 created FEAT task" --force 2>/dev/null || true
gh label create "agent:wip" --repo "$GH_REPO" --color "1D76DB" --description "Coder working" --force 2>/dev/null || true
gh label create "agent:untested" --repo "$GH_REPO" --color "FBCA04" --description "Ready for tester" --force 2>/dev/null || true
gh label create "agent:testing" --repo "$GH_REPO" --color "5319E7" --description "Tester active" --force 2>/dev/null || true

echo ""
echo "Testing issue list for ${GH_REPO} ..."
GH_LIST_ERR="$(mktemp)"
if gh issue list --repo "$GH_REPO" --state open -L 3 2>"$GH_LIST_ERR"; then
  rm -f "$GH_LIST_ERR"
  echo ""
  echo "Issue list OK."
else
  if grep -qi 'lifetime is greater than 366 days' "$GH_LIST_ERR" 2>/dev/null; then
    echo "" >&2
    echo "ERROR: Fine-grained PAT lifetime exceeds org policy (max 366 days)." >&2
    echo "  Regenerate the token with expiration ≤ 1 year, update autoagents/.env, re-run." >&2
    cat "$GH_LIST_ERR" >&2
    rm -f "$GH_LIST_ERR"
    exit 1
  fi
  rm -f "$GH_LIST_ERR"
  echo "Warning: could not list issues. Check repo access for Luipy56." >&2
  exit 1
fi

echo ""
echo "Testing issue write (comment permission) ..."
PROBE_ISSUE="$(gh issue list --repo "$GH_REPO" --state open -L 1 --json number -q '.[0].number' 2>/dev/null || true)"
if [[ -z "${PROBE_ISSUE:-}" ]]; then
  echo "  (skip: no open issues to probe, create one issue and re-run to verify write access)"
else
  PROBE_BODY="🤖 autoagents setup probe, safe to delete ($(date -u +%Y-%m-%dT%H:%M:%SZ))"
  if gh api -X POST "repos/${GH_REPO}/issues/${PROBE_ISSUE}/comments" -f body="$PROBE_BODY" >/dev/null 2>&1; then
    echo "  OK: GH_TOKEN can comment on issues (#${PROBE_ISSUE})."
  else
    echo "" >&2
    echo "ERROR: GH_TOKEN cannot comment on issues (HTTP 403 / addComment)." >&2
    echo "  Issue list works but write fails, permissions in the UI may already be correct." >&2
    echo "" >&2
    echo "  Most likely: AMVARA-CONSULTING requires *approval* for fine-grained PATs." >&2
    echo "  Until approved, tokens can only READ public repos (not comment/label/close)." >&2
    echo "" >&2
    echo "  Fix A - approve the token (org owner):" >&2
    echo "    https://github.com/organizations/AMVARA-CONSULTING/settings/personal-access-token-requests" >&2
    echo "    → Pending requests → Approve the Luipy56 token" >&2
    echo "" >&2
    echo "  Fix B - classic PAT (if org allows classic tokens):" >&2
    echo "    https://github.com/settings/tokens → Generate new token (classic) → scope: repo" >&2
    echo "" >&2
    echo "  Also verify fine-grained PAT:" >&2
    echo "    • Issues: Read and write  • Expiration ≤ 366 days  • ${GH_REPO} included" >&2
    echo "" >&2
    exit 1
  fi
fi

echo ""
echo "GitHub integration OK."
