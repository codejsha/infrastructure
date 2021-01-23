#!/bin/bash

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"

function get_active_realms_list {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X GET \
        -H "Accept:application/json" \
        ${NEXUS_URL}/service/rest/beta/security/realms/active
}

get_active_realms_list
