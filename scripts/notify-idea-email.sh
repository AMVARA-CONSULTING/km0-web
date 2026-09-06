#!/usr/bin/env bash
# Fire-and-forget notification via AutoMail (no cursor-agent).
# Usage:
#   notify-idea-email.sh <idea> [subject] [full_text]
# If full_text is set, it is sent as the body; otherwise a short Spanish preview is used.
set -euo pipefail

REPO_ROOT="${KM0_WEB_ROOT:-/opt/km0-web}"
idea="${1:-}"
subject="${2:-Nueva idea km0digital}"
custom_text="${3:-}"

# Load AutoMail secrets when not already in the environment (processor path).
if [[ -z "${AUTOMAIL_TOKEN:-}" && -f "${REPO_ROOT}/.env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source "${REPO_ROOT}/.env"
  set +a
fi

token="${AUTOMAIL_TOKEN:-}"
to="${AUTOMAIL_NOTIFY_TO:-yoelberjaga@gmail.com}"
api_url="${AUTOMAIL_API_URL:-https://automail.lu-zero.ldeluipy.es/api/send.php}"
log="${KM0_IDEAS_RECEIVER_LOG:-/var/log/km0-ideas/receiver.log}"

log_line() {
  printf '%s notify-idea-email %s\n' "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$*" >> "$log" 2>/dev/null || true
}

if [[ -z "$token" ]]; then
  exit 0
fi

if [[ -z "$idea" && -z "$custom_text" ]]; then
  log_line "skip empty idea"
  exit 0
fi

if [[ -n "$custom_text" ]]; then
  text="$custom_text"
else
  preview="${idea:0:100}"
  text=$'Se ha enviado una nueva idea desde km0digital\n\n'"${preview}"
fi

payload="$(jq -n \
  --arg to "$to" \
  --arg subject "$subject" \
  --arg text "$text" \
  '{to: $to, subject: $subject, text: $text}')"

if ! response="$(curl -sS -w '\n%{http_code}' -X POST "$api_url" \
  -H "Authorization: Bearer ${token}" \
  -H 'Content-Type: application/json' \
  -d "$payload" 2>&1)"; then
  log_line "curl failed: ${response}"
  exit 0
fi

http_code="${response##*$'\n'}"
body="${response%$'\n'*}"

if [[ "$http_code" != "200" ]]; then
  log_line "automail http=${http_code} body=${body}"
fi

exit 0
