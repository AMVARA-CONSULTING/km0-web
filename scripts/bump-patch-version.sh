#!/usr/bin/env bash
# Bump package.json patch (footer-visible site version). Used by autoagents coders each task.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
python3 - "$ROOT/package.json" <<'PY'
import json
import sys
from pathlib import Path

path = Path(sys.argv[1])
data = json.loads(path.read_text(encoding="utf-8"))
old = data["version"]
parts = old.split(".")
if len(parts) != 3 or not all(p.isdigit() for p in parts):
    raise SystemExit(f"Invalid semver in package.json: {old}")
major, minor, patch = (int(p) for p in parts)
new = f"{major}.{minor}.{patch + 1}"
data["version"] = new
path.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
print(f"Site version: {old} → {new} (package.json; shown in footer)")
PY
