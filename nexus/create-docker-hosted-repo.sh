#!/usr/bin/bash

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"
REPOSITORY_NAME="${1}"
BLOBSTORE_NAME="${2}"

function create_docker_hosted_repository {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X POST "${NEXUS_URL}/service/rest/beta/repositories/docker/hosted" \
        -H "accept: application/json" \
        -H "Content-Type: application/json" \
        -d \
        "{ \
          \"name\": \"${REPOSITORY_NAME}\", \
          \"online\": true, \
          \"storage\": { \
            \"blobStoreName\": \"${BLOBSTORE_NAME}\", \
            \"strictContentTypeValidation\": true, \
            \"writePolicy\": \"ALLOW\" \
          }, \
          \"cleanup\": null, \
          \"docker\": { \
            \"v1Enabled\": false, \
            \"forceBasicAuth\": false, \
            \"httpPort\": null, \
            \"httpsPort\": null \
          } \
        }"
}

create_docker_hosted_repository
