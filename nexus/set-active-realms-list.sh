#!/usr/bin/bash

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"
REALM_IDS="${1}"

function set_active_realms_list {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X PUT "${NEXUS_URL}/service/rest/beta/security/realms/active" \
        -H "accept: application/json" \
        -H "Content-Type: application/json" \
        -d \
        "[${REALM_IDS}]"
}

set_active_realms_list
