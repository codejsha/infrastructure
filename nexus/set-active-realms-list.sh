#!/usr/bin/bash

NEXUS_URL="https://nexus.kube.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"
REALM_IDS="${1}"

function set_active_realms_list {
    curl --insecure \
        -X PUT "${NEXUS_URL}/service/rest/beta/security/realms/active" \
        -H "accept: application/json" \
        -H "Content-Type: application/json" \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -d \
        "[${REALM_IDS}]"
}

set_active_realms_list