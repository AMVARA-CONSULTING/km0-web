#!/usr/bin/env bash
# One-time host setup: spool dirs, systemd units, docker bind mount prerequisites.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SPOOL="/var/spool/km0-ideas"
SYSTEMD_SRC="${ROOT}/deploy/systemd"
SYSTEMD_DST="/etc/systemd/system"

echo "Creating spool directories under ${SPOOL} ..."
mkdir -p "${SPOOL}"/{incoming,processing,processed,failed}
mkdir -p /var/log/km0-ideas
chmod 775 "${SPOOL}" "${SPOOL}/incoming"
chmod 750 "${SPOOL}/processing" "${SPOOL}/processed" "${SPOOL}/failed"
chmod 755 /var/log/km0-ideas

chmod +x "${ROOT}/scripts/process-idea.sh"

echo "Installing systemd units ..."
install -m 644 "${SYSTEMD_SRC}/km0-idea-processor.service" "${SYSTEMD_DST}/"
install -m 644 "${SYSTEMD_SRC}/km0-idea-processor.path" "${SYSTEMD_DST}/"
install -m 644 "${SYSTEMD_SRC}/km0-idea-processor.timer" "${SYSTEMD_DST}/"

systemctl daemon-reload
systemctl enable km0-idea-processor.path km0-idea-processor.timer
systemctl start km0-idea-processor.path km0-idea-processor.timer

echo "Processor path unit enabled. Manual drain:"
echo "  ${ROOT}/scripts/process-idea.sh"
echo ""
echo "Ensure docker-compose bind-mounts ${SPOOL}/incoming (not a named volume)."
