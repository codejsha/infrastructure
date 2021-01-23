#!/bin/bash

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"
BLOBSTORE_NAME="${1}"

function get_s3_blob_store {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X GET \
        -H "Accept:application/json" \
        ${NEXUS_URL}/service/rest/beta/blobstores/s3/${BLOBSTORE_NAME}
}

get_s3_blob_store
