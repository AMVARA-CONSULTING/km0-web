#!/usr/bin/env bash
# One-time host setup: spool dirs, webhook receiver, systemd units.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SPOOL="/var/spool/km0-ideas"
SYSTEMD_SRC="${ROOT}/deploy/systemd"
SYSTEMD_DST="/etc/systemd/system"
WEBHOOK_VERSION="2.8.1"
WEBHOOK_BIN="/usr/local/bin/webhook"
RECEIVER_USER="km0-receiver"

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Run as root: sudo $0" >&2
  exit 1
fi

echo "Creating spool directories under ${SPOOL} ..."
mkdir -p "${SPOOL}"/{incoming,processing,processed,failed}
mkdir -p /var/log/km0-ideas

if ! id "$RECEIVER_USER" &>/dev/null; then
  echo "Creating system user ${RECEIVER_USER} ..."
  useradd -r -s /usr/sbin/nologin -d /nonexistent -c "KM0 ideas webhook receiver" "$RECEIVER_USER"
fi

touch /var/log/km0-ideas/receiver.log
chown root:"${RECEIVER_USER}" /var/log/km0-ideas /var/log/km0-ideas/receiver.log
chmod 775 /var/log/km0-ideas
chmod 664 /var/log/km0-ideas/receiver.log

chown root:"${RECEIVER_USER}" "${SPOOL}" "${SPOOL}/incoming"
chmod 775 "${SPOOL}" "${SPOOL}/incoming"
chmod 750 "${SPOOL}/processing" "${SPOOL}/processed" "${SPOOL}/failed"

chmod +x "${ROOT}/scripts/autoissue.sh" \
  "${ROOT}/scripts/process-idea.sh" \
  "${ROOT}/scripts/receive-idea.sh" \
  "${ROOT}/scripts/notify-idea-email.sh"

if [[ ! -x "$WEBHOOK_BIN" ]]; then
  echo "Installing webhook ${WEBHOOK_VERSION} to ${WEBHOOK_BIN} ..."
  arch="$(uname -m)"
  case "$arch" in
    x86_64) webhook_arch="amd64" ;;
    aarch64 | arm64) webhook_arch="arm64" ;;
    armv7l | armv6l) webhook_arch="arm" ;;
    i686 | i386) webhook_arch="386" ;;
    *)
      echo "Unsupported architecture for webhook download: ${arch}" >&2
      exit 1
      ;;
  esac
  build_dir="$(mktemp -d)"
  trap 'rm -rf "$build_dir"' EXIT
  curl -fsSL "https://github.com/adnanh/webhook/releases/download/${WEBHOOK_VERSION}/webhook-linux-${webhook_arch}.tar.gz" \
    | tar xz -C "$build_dir"
  install -m 755 "${build_dir}/webhook-linux-${webhook_arch}/webhook" "$WEBHOOK_BIN"
fi

echo "Installing systemd units ..."
install -m 644 "${SYSTEMD_SRC}/km0-ideas-receiver.service" "${SYSTEMD_DST}/"
install -m 644 "${SYSTEMD_SRC}/km0-idea-processor.service" "${SYSTEMD_DST}/"
install -m 644 "${SYSTEMD_SRC}/km0-idea-processor.path" "${SYSTEMD_DST}/"
install -m 644 "${SYSTEMD_SRC}/km0-idea-processor.timer" "${SYSTEMD_DST}/"

systemctl daemon-reload
systemctl enable km0-ideas-receiver.service km0-idea-processor.path km0-idea-processor.timer
systemctl restart km0-ideas-receiver.service
systemctl start km0-idea-processor.path km0-idea-processor.timer

echo ""
echo "Receiver: systemctl status km0-ideas-receiver"
echo "Processor manual drain: ${ROOT}/scripts/autoissue.sh"
echo "Test enqueue:"
echo "  curl -s -X POST http://127.0.0.1:9181/hooks/ideas \\"
echo "    -H 'Content-Type: application/json' \\"
echo "    -d '{\"idea\":\"Test feedback\",\"locale\":\"en\"}'"
