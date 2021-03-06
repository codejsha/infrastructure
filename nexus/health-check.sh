#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"

######################################################################

function status {
    curl --insecure \
        --head \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X GET \
        -H "Accept:application/json" \
        ${NEXUS_URL}/service/rest/v1/status
}

function status_check {
    # curl --insecure \
    #     --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
    #     -X GET \
    #     -H "Accept:application/json" \
    #     ${NEXUS_URL}/service/rest/v1/status/check
}

######################################################################

status
# status_check
