#!/bin/sh
# Fail if the em dash character (U+2014) appears in project text files.
set -eu

ROOT="$(CDPATH= cd "$(dirname "$0")/.." && pwd)"
EM=$(printf '\342\200\224')
TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

is_text_file() {
  case "$1" in
    *.md|*.mdc|*.py|*.sh|*.txt|*.red|*.json|*.astro|*.ts|*.js|*.mjs|*.yml|*.yaml|*.conf|*.example|*.html|*.css|*.svg)
      return 0 ;;
    Dockerfile|VERSION|LICENSE)
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

find "$ROOT" -type f \
  \( -path "$ROOT/.git/*" -o -path "$ROOT/node_modules/*" -o -path "$ROOT/dist/*" -o -path "$ROOT/.astro/*" -o -path "*/__pycache__/*" \) -prune \
  -o -type f -print | while IFS= read -r file; do
  if should_skip "$file"; then
    continue
  fi
  if grep -q "$EM" "$file" 2>/dev/null; then
    echo "${file#"$ROOT"/}" >>"$TMP"
  fi
done

if [ -s "$TMP" ]; then
  echo "Em dash (U+2014) found in file(s):" >&2
  sed 's/^/  /' "$TMP" >&2
  echo "Use hyphen, comma, or colon instead. See .cursor/rules/no-em-dash.mdc and CONTRIBUTING.md." >&2
  exit 1
fi

echo "check-no-em-dash: OK (zero U+2014 matches in text files)"
