#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

export NEXUS_URL="https://nexus.example.com"
export NEXUS_USER="admin"
export NEXUS_PASSWORD="admin123"

export USER_ID="${1}"
export USER_PASSWORD="${2}"
export USER_FIRSTNAME="${USER_ID}"
export USER_LASTNAME="${USER_ID}"
export USER_EMAIL="${USER_ID}@example.com"
export USER_ROLES="nx-admin"

envsubst < ./data-user.json > ./data-user-temp.json

######################################################################

function create_user {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X POST \
        -H "Accept:application/json" \
        -H "Content-Type:application/json" \
        -d @data-user-temp.json \
        ${NEXUS_URL}/service/rest/beta/security/users
}

######################################################################

create_user
