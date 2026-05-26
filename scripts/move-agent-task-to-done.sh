#!/usr/bin/env bash
# Move a CLOSED-*.md task from autoagents/tasks/ to done/YYYY/MM/DD/
# Usage: ./scripts/move-agent-task-to-done.sh autoagents/tasks/CLOSED-123-20260526-1200-slug.md
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 autoagents/tasks/CLOSED-<issue>-<YYYYMMDD>-<HHMM>-<slug>.md" >&2
  exit 1
fi

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
src="$1"
if [[ "$src" != /* ]]; then
  src="${REPO_ROOT}/${src}"
fi

bn="$(basename "$src")"
if [[ ! "$bn" =~ ^CLOSED-[0-9]+-[0-9]{8}-[0-9]{4}- ]]; then
  echo "Error: filename must start with CLOSED-<issue>-<YYYYMMDD>-<HHMM>-" >&2
  exit 1
fi

if [[ ! -f "$src" ]]; then
  echo "Error: file not found: $src" >&2
  exit 1
fi

# Extract YYYYMMDD from CLOSED-<issue>-YYYYMMDD-HHMM-slug.md
datepart="$(echo "$bn" | sed -E 's/^CLOSED-[0-9]+-([0-9]{8})-.*/\1/')"
yyyy="${datepart:0:4}"
mm="${datepart:4:2}"
dd="${datepart:6:2}"

dest_dir="${REPO_ROOT}/autoagents/tasks/done/${yyyy}/${mm}/${dd}"
mkdir -p "$dest_dir"
mv "$src" "${dest_dir}/${bn}"
echo "Moved to ${dest_dir}/${bn}"
