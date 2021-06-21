#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"

######################################################################

function status {
    curl --insecure \
        --head \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        --request GET \
        --header "Accept:application/json" \
        ${NEXUS_URL}/service/rest/v1/status
}

function status_check {
    # curl --insecure \
    #     --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
    #     --request GET \
    #     --header "Accept:application/json" \
    #     ${NEXUS_URL}/service/rest/v1/status/check
}

######################################################################

status
# status_check
