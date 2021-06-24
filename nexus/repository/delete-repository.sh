#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"
REPOSITORY_NAME="${1}"

######################################################################

function delete_repository {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        --request DELETE \
        --header "Accept:application/json" \
        ${NEXUS_URL}/service/rest/beta/repositories/${REPOSITORY_NAME}
}

######################################################################

delete_repository
