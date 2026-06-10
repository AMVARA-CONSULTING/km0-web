#!/bin/sh
# Install repo git hooks (pre-commit runs check-no-em-dash.sh).
set -eu

ROOT="$(CDPATH= cd "$(dirname "$0")/.." && pwd)"
HOOK_SRC="$ROOT/.githooks/pre-commit"
HOOK_DST="$ROOT/.git/hooks/pre-commit"

if [ ! -d "$ROOT/.git/hooks" ]; then
  echo "install-git-hooks: skip (no .git/hooks; not a git checkout?)" >&2
  exit 0
fi

cp "$HOOK_SRC" "$HOOK_DST"
chmod +x "$HOOK_DST" "$HOOK_SRC" "$ROOT/scripts/check-no-em-dash.sh"
echo "install-git-hooks: installed pre-commit hook -> .git/hooks/pre-commit"
