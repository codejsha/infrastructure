#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"
REPOSITORY_NAME="${1}"

######################################################################

function delete_repository {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X DELETE \
        -H "Accept:application/json" \
        ${NEXUS_URL}/service/rest/beta/repositories/${REPOSITORY_NAME}
}

######################################################################

delete_repository
