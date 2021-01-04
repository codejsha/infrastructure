#!/bin/bash

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"

function status {
    curl --insecure \
        --head \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X GET "${NEXUS_URL}/service/rest/v1/status" \
        -H "Accept:application/json"
}

function status_check {
    # curl --insecure \
    #     --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
    #     -X GET "${NEXUS_URL}/service/rest/v1/status/check" \
    #     -H "Accept:application/json"
}

status
# status_check
