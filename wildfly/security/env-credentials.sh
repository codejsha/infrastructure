#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

PASSWORD="${1}"

CREDENTIALS_ALIAS="baseds1-password"
CREDENTIALS_SECRET_VALUE="${PASSWORD}"
