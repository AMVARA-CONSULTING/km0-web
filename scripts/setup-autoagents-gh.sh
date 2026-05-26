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
    echo "Option A — token file (recommended on server):"
    echo "  1. Create a fine-grained PAT at https://github.com/settings/tokens"
    echo "     Scopes: Issues (read/write), Contents (read), Metadata (read)"
    echo "     Repository: AMVARA-CONSULTING/km0-web"
    echo "  2. cp autoagents/.env.example autoagents/.env"
    echo "  3. Set GH_TOKEN=github_pat_... in autoagents/.env"
    echo "  4. Re-run: ./scripts/setup-autoagents-gh.sh"
    echo ""
    echo "Option B — interactive login:"
    echo "  gh auth login --hostname github.com --git-protocol ssh --scopes repo,read:org"
    exit 1
  fi
fi

echo ""
echo "Testing issue list for ${GH_REPO} ..."
if gh issue list --repo "$GH_REPO" --state open -L 3; then
  echo ""
  echo "GitHub integration OK."
else
  echo "Warning: could not list issues. Check repo access for Luipy56." >&2
  exit 1
fi
