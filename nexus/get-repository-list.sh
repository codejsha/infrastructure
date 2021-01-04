#!/bin/bash

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"

function get_repository_list {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X GET "${NEXUS_URL}/service/rest/beta/repositories" \
        -H "Accept:application/json"
    # curl --insecure \
    #     --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
    #     -X GET "${NEXUS_URL}/service/rest/v1/repositories" \
    #     -H "Accept:application/json"
}

get_repository_list
