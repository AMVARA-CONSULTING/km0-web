#!/usr/bin/env bash
# Sync repo nginx vhost to /etc/nginx and reload (includes /hooks/ideas proxy).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="${ROOT}/nginx/sites-available/km0"
DST="/etc/nginx/sites-available/km0"

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Run as root: sudo $0" >&2
  exit 1
fi

if [[ ! -f "$SRC" ]]; then
  echo "Missing template: $SRC" >&2
  exit 1
fi

install -m 644 "$SRC" "$DST"
ln -sf "$DST" /etc/nginx/sites-enabled/km0
nginx -t
systemctl reload nginx
echo "Deployed ${DST} and reloaded nginx."
