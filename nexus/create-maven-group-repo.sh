#!/usr/bin/bash

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"
REPOSITORY_NAME="${1}"
BLOBSTORE_NAME="${2}"
REPOSITORY_MEMBER_NAMES="${3}"

function create_maven_group_repository {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X POST "${NEXUS_URL}/service/rest/beta/repositories/maven/group" \
        -H "accept: application/json" \
        -H "Content-Type: application/json" \
        -d \
        "{ \
          \"name\": \"${REPOSITORY_NAME}\", \
          \"online\": true, \
          \"storage\": { \
            \"blobStoreName\": \"${BLOBSTORE_NAME}\", \
            \"strictContentTypeValidation\": true \
          }, \
          \"group\": { \
            \"memberNames\": [${REPOSITORY_MEMBER_NAMES}] \
          } \
        }"
}

create_maven_group_repository
