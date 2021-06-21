#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

CREDENTIALS_DOMAIN="cicd"
CREDENTIALS_USERNAME="${USERNAME}"
CREDENTIALS_PASSWORD="${PASSWORD}"
CREDENTIALS_DESCRIPTION=""
