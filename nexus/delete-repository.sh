#!/usr/bin/bash

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"
REPOSITORY_NAME="${1}"

function delete_repository {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X DELETE "${NEXUS_URL}/service/rest/beta/repositories/${REPOSITORY_NAME}" \
        -H "accept: application/json"
}

delete_repository
