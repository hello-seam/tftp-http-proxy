#!/usr/bin/env bash

set -euo pipefail

PUID=${PUID:-nobody}
PGID=${PGID:-nogroup}

exec /usr/bin/dumb-init /usr/sbin/gosu "$PUID:$PGID" /usr/bin/tftp-http-proxy "$@"
