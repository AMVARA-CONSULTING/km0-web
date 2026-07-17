#!/bin/sh
# Fail if the mailto: URI scheme appears in shipped site paths.
set -eu

ROOT="$(CDPATH= cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

# Only paths that ship to users (site build, public assets, email templates).
# Docs/rules may mention mailto: when documenting the ban.
SCAN_DIRS="src public email-templates"

is_text_file() {
  case "$1" in
    *.md|*.mdc|*.py|*.sh|*.txt|*.red|*.json|*.astro|*.ts|*.js|*.mjs|*.yml|*.yaml|*.conf|*.example|*.html|*.css|*.svg)
      return 0 ;;
    Dockerfile|VERSION|LICENSE|security.txt)
      return 0 ;;
    *)
      return 1 ;;
  esac
}

should_skip() {
  case "$1" in
    */.git/*|*/node_modules/*|*/dist/*|*/.astro/*|*/__pycache__/*)
      return 0 ;;
  esac
  base="${1##*/}"
  if [ "$base" = ".env" ]; then
    return 0
  fi
  if is_text_file "$base"; then
    return 1
  fi
  return 0
}

for dir in $SCAN_DIRS; do
  target="$ROOT/$dir"
  if [ ! -d "$target" ]; then
    continue
  fi
  find "$target" -type f \
    \( -path "*/.git/*" -o -path "*/node_modules/*" -o -path "*/dist/*" -o -path "*/.astro/*" -o -path "*/__pycache__/*" \) -prune \
    -o -type f -print | while IFS= read -r file; do
    if should_skip "$file"; then
      continue
    fi
    if grep -q 'mailto:' "$file" 2>/dev/null; then
      echo "${file#"$ROOT"/}" >>"$TMP"
    fi
  done
done

if [ -s "$TMP" ]; then
  echo "mailto: URI scheme found in shipped file(s):" >&2
  sort -u "$TMP" | sed 's/^/  /' >&2
  echo "Use plain visible email text (no mailto: links). See .cursor/rules/no-mailto.mdc and CONTRIBUTING.md." >&2
  exit 1
fi

echo "check-no-mailto: OK (zero mailto: matches in src/, public/, email-templates/)"
