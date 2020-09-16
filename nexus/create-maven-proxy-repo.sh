#!/usr/bin/bash

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"
REPOSITORY_NAME="${1}"
BLOBSTORE_NAME="${2}"
REMOTE_URL="${3}"

function create_maven_proxy_repository {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X POST "${NEXUS_URL}/service/rest/beta/repositories/maven/proxy" \
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
          \"cleanup\": null, \
          \"proxy\": { \
            \"remoteUrl\": \"${REMOTE_URL}\", \
            \"contentMaxAge\": -1, \
            \"metadataMaxAge\": 1440 \
          }, \
          \"negativeCache\": { \
            \"enabled\": true, \
            \"timeToLive\": 1440 \
          }, \
          \"httpClient\": { \
            \"blocked\": false, \
            \"autoBlock\": false, \
            \"connection\": { \
              \"retries\": null, \
              \"userAgentSuffix\": null, \
              \"timeout\": null, \
              \"enableCircularRedirects\": false, \
              \"enableCookies\": false \
            }, \
            \"authentication\": null \
          }, \
          \"routingRule\": null, \
          \"maven\": { \
            \"versionPolicy\": \"RELEASE\", \
            \"layoutPolicy\": \"PERMISSIVE\" \
          } \
        }"
}

create_maven_proxy_repository
