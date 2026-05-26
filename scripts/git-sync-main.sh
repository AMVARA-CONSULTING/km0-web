#!/usr/bin/env bash
# Sync local main with origin/main before agent steps that edit the repo.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")"
if [[ "$branch" != "main" ]]; then
  echo "git-sync-main: checkout main (was: ${branch:-unknown})" >&2
  git checkout main
fi

git fetch origin main
git pull --rebase --autostash origin main
