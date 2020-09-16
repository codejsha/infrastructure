#!/usr/bin/bash

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"

function get_available_realms_list {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X GET "${NEXUS_URL}/service/rest/beta/security/realms/available" \
        -H "accept: application/json"
}

get_available_realms_list
