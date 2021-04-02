#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### seconds since 1970-01-01 00:00:00 UTC
SECONDS_SINCE="$(date +%s)"
echo "${SECONDS_SINCE}"
