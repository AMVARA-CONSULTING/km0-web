#!/usr/bin/env bash
# Public receiver (Script 1): validate POST payload and enqueue JSON atomically.
set -euo pipefail

QUEUE="${KM0_IDEAS_QUEUE:-/var/spool/km0-ideas/incoming}"
payload="${1:-}"

respond_ok() {
  printf '{"ok":true}\n'
  exit 0
}

respond_err() {
  local code="${1:-invalid_input}"
  printf '{"ok":false,"error":"%s"}\n' "$code"
  # Exit 0 so adnanh/webhook returns JSON in the HTTP body (non-zero → 500).
  exit 0
}

if [[ -z "$payload" ]]; then
  respond_err "invalid_input"
fi

if ! printf '%s' "$payload" | jq -e . >/dev/null 2>&1; then
  respond_err "invalid_input"
fi

# Honeypot: silent accept for bots
hp="$(printf '%s' "$payload" | jq -r '.website // ._hp // empty')"
if [[ -n "$hp" && "$hp" != "null" ]]; then
  respond_ok
fi

idea="$(printf '%s' "$payload" | jq -r '.idea // empty')"
name="$(printf '%s' "$payload" | jq -r '.name // empty')"
locale="$(printf '%s' "$payload" | jq -r '.locale // empty')"
user_agent="${2:-}"
x_real_ip="${3:-}"
x_forwarded_for="${4:-}"

idea="${idea#"${idea%%[![:space:]]*}"}"
idea="${idea%"${idea##*[![:space:]]}"}"
name="${name#"${name%%[![:space:]]*}"}"
name="${name%"${name##*[![:space:]]}"}"

if [[ -z "$idea" ]]; then
  respond_err "invalid_input"
fi

if [[ ${#idea} -gt 4000 ]]; then
  respond_err "invalid_input"
fi

if [[ -n "$name" && ${#name} -gt 200 ]]; then
  respond_err "invalid_input"
fi

case "$locale" in
  es | ca | en | de) ;;
  '' | null) locale="es" ;;
  *) locale="es" ;;
esac

remote_addr="$x_real_ip"
if [[ -z "$remote_addr" && -n "$x_forwarded_for" && "$x_forwarded_for" != "null" ]]; then
  remote_addr="${x_forwarded_for%%,*}"
  remote_addr="${remote_addr// /}"
fi

uuid="$(cat /proc/sys/kernel/random/uuid)"
ts="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
ts_file="$(date -u +"%Y%m%dT%H%M%SZ")"
filename="${ts_file}-${uuid}.json"

if [[ -n "$name" ]]; then
  json="$(jq -n \
    --arg id "$uuid" \
    --arg receivedAt "$ts" \
    --arg locale "$locale" \
    --arg name "$name" \
    --arg idea "$idea" \
    --arg userAgent "$user_agent" \
    --arg remoteAddr "$remote_addr" \
    '{
      id: $id,
      receivedAt: $receivedAt,
      locale: $locale,
      name: $name,
      idea: $idea,
      meta: { userAgent: $userAgent, remoteAddr: $remoteAddr }
    }')"
else
  json="$(jq -n \
    --arg id "$uuid" \
    --arg receivedAt "$ts" \
    --arg locale "$locale" \
    --arg idea "$idea" \
    --arg userAgent "$user_agent" \
    --arg remoteAddr "$remote_addr" \
    '{
      id: $id,
      receivedAt: $receivedAt,
      locale: $locale,
      name: null,
      idea: $idea,
      meta: { userAgent: $userAgent, remoteAddr: $remoteAddr }
    }')"
fi

mkdir -p "$QUEUE"

tmp="$(mktemp "${QUEUE}/.tmp.XXXXXX")"
if ! printf '%s' "$json" > "$tmp"; then
  rm -f "$tmp"
  respond_err "unavailable"
fi
chmod 640 "$tmp" 2>/dev/null || true

if ! mv "$tmp" "${QUEUE}/${filename}"; then
  rm -f "$tmp"
  respond_err "unavailable"
fi

respond_ok
