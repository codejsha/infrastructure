#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"
REALM_IDS="${1}"

######################################################################

function set_active_realms_list {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X PUT \
        -H "Accept:application/json" \
        -H "Content-Type:application/json" \
        -d "[${REALM_IDS}]" \
        ${NEXUS_URL}/service/rest/beta/security/realms/active
}

######################################################################

set_active_realms_list
