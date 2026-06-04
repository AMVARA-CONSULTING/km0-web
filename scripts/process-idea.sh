#!/usr/bin/env bash
# Compatibility wrapper: Script 2 was renamed to autoissue.
exec "$(dirname "$0")/autoissue.sh" "$@"
