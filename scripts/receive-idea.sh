#!/usr/bin/env bash
# Public receiver (Script 1): validate POST payload and enqueue JSON atomically.
set -euo pipefail

REPO_ROOT="${KM0_WEB_ROOT:-/opt/km0-web}"
QUEUE="${KM0_IDEAS_QUEUE:-/var/spool/km0-ideas/incoming}"
RECEIVER_LOG="${KM0_IDEAS_RECEIVER_LOG:-/var/log/km0-ideas/receiver.log}"
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

load_trust_password() {
  if [[ -n "${KM0_IDEAS_TRUST_PASSWORD:-}" ]]; then
    return 0
  fi
  local env_file line value
  # km0-receiver often cannot read root .env (mode 600). Never write to stderr:
  # adnanh/webhook includes command stderr in the HTTP body and breaks JSON clients.
  for env_file in "${REPO_ROOT}/.env" "${REPO_ROOT}/autoagents/.env"; do
    if [[ -f "$env_file" && -r "$env_file" ]]; then
      line="$(grep -E '^[[:space:]]*KM0_IDEAS_TRUST_PASSWORD=' "$env_file" 2>/dev/null | tail -n1 || true)"
      if [[ -n "$line" ]]; then
        value="${line#*=}"
        value="${value#$'\r'}"
        if [[ "$value" == \"*\" ]]; then
          value="${value:1:${#value}-2}"
        elif [[ "$value" == \'*\' ]]; then
          value="${value:1:${#value}-2}"
        fi
        KM0_IDEAS_TRUST_PASSWORD="$value"
        export KM0_IDEAS_TRUST_PASSWORD
        return 0
      fi
    fi
  done
}

# Constant-time-ish compare via SHA-256 digests (never store plaintext password in queue).
password_matches_trust() {
  local submitted="$1"
  local trust="${KM0_IDEAS_TRUST_PASSWORD:-}"
  local a b

  if [[ -z "$trust" || -z "$submitted" ]]; then
    return 1
  fi

  a="$(printf '%s' "$submitted" | openssl dgst -sha256 2>/dev/null | awk '{print $NF}')"
  b="$(printf '%s' "$trust" | openssl dgst -sha256 2>/dev/null | awk '{print $NF}')"
  if [[ -z "$a" || -z "$b" || ${#a} -ne ${#b} ]]; then
    return 1
  fi
  if ! printf '%s' "$a" | cmp -s - <(printf '%s' "$b"); then
    return 1
  fi
  return 0
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
scope="$(printf '%s' "$payload" | jq -r '.scope // empty')"
submitted_password="$(printf '%s' "$payload" | jq -r '.password // empty')"
user_agent="${2:-}"
x_real_ip="${3:-}"
x_forwarded_for="${4:-}"

idea="${idea#"${idea%%[![:space:]]*}"}"
idea="${idea%"${idea##*[![:space:]]}"}"
name="${name#"${name%%[![:space:]]*}"}"
name="${name%"${name##*[![:space:]]}"}"
if [[ "$submitted_password" == "null" ]]; then
  submitted_password=""
fi

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

case "$scope" in
  web | cloud | mail) ;;
  '' | null) scope="web" ;;
  *) respond_err "invalid_input" ;;
esac

load_trust_password
skip_human_validation=false
if password_matches_trust "$submitted_password"; then
  skip_human_validation=true
fi

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
    --arg scope "$scope" \
    --arg name "$name" \
    --arg idea "$idea" \
    --arg userAgent "$user_agent" \
    --arg remoteAddr "$remote_addr" \
    --argjson skipHumanValidation "$skip_human_validation" \
    '{
      id: $id,
      receivedAt: $receivedAt,
      locale: $locale,
      scope: $scope,
      name: $name,
      idea: $idea,
      skipHumanValidation: $skipHumanValidation,
      meta: { userAgent: $userAgent, remoteAddr: $remoteAddr }
    }')"
else
  json="$(jq -n \
    --arg id "$uuid" \
    --arg receivedAt "$ts" \
    --arg locale "$locale" \
    --arg scope "$scope" \
    --arg idea "$idea" \
    --arg userAgent "$user_agent" \
    --arg remoteAddr "$remote_addr" \
    --argjson skipHumanValidation "$skip_human_validation" \
    '{
      id: $id,
      receivedAt: $receivedAt,
      locale: $locale,
      scope: $scope,
      name: null,
      idea: $idea,
      skipHumanValidation: $skipHumanValidation,
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

if [[ -x "${REPO_ROOT}/scripts/notify-idea-email.sh" ]]; then
  "${REPO_ROOT}/scripts/notify-idea-email.sh" "$idea" >>"$RECEIVER_LOG" 2>&1 &
fi

respond_ok
