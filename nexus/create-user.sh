#!/bin/bash

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"

USER_ID="${1}"
USER_PASSWORD="${2}"
USER_FIRSTNAME="${USER_ID}"
USER_LASTNAME="${USER_ID}"
USER_EMAIL="${USER_ID}@example.org"
USER_ROLES="nx-admin"

function create_user {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X POST "${NEXUS_URL}/service/rest/beta/security/users" \
        -H "accept: application/json" \
        -H "Content-Type: application/json" \
        -d \
        "{ \
          \"userId\": \"${USER_ID}\", \
          \"firstName\": \"${USER_FIRSTNAME}\", \
          \"lastName\": \"${USER_LASTNAME}\", \
          \"emailAddress\": \"${USER_EMAIL}\", \
          \"password\": \"${USER_PASSWORD}\", \
          \"status\": \"active\", \
          \"roles\": [\"${USER_ROLES}\"] \
        }"
}

create_user
