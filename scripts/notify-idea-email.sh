#!/usr/bin/env bash
# Fire-and-forget dev notification via AutoMail (no cursor-agent).
set -euo pipefail

idea="${1:-}"
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

if [[ -z "$idea" ]]; then
  log_line "skip empty idea"
  exit 0
fi

preview="${idea:0:100}"
text=$'Se ha enviado una nueva idea desde km0digital\n\n'"${preview}"

payload="$(jq -n \
  --arg to "$to" \
  --arg subject "Nueva idea km0digital" \
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
