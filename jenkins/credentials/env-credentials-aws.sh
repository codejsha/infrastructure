#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

CREDENTIALS_DOMAIN="cicd"
CREDENTIALS_ACCESSKEY="${ACCESS_KEY}"
CREDENTIALS_SECRETKEY="${SECRET_KEY}"
CREDENTIALS_DESCRIPTION=""
