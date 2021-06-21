#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"
REALM_IDS="${1}"

######################################################################

function set_active_realms_list {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        --request PUT \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --data "[${REALM_IDS}]" \
        ${NEXUS_URL}/service/rest/beta/security/realms/active
}

######################################################################

set_active_realms_list
