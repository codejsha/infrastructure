#!/bin/bash

export NEXUS_URL="https://nexus.example.com"
export NEXUS_USER="admin"
export NEXUS_PASSWORD="admin123"
export BLOBSTORE_NAME="${1}"

export AWS_ACCESS_KEY="${AWS_ACCESS_KEY}"
export AWS_SECRET_KEY="${AWS_SECRET_KEY}"
export AWS_ENDPOINT_URL="http://minio.example.com"
# export AWS_ENDPOINT_URL="http://10.10.10.52:9000"
export BUCKET_NAME="${BLOBSTORE_NAME}"

envsubst < ./data-blobstore.json > ./data-blobstore-temp.json

function create_s3_blob_store {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X POST "${NEXUS_URL}/service/rest/beta/blobstores/s3" \
        -H "Accept:application/json" \
        -H "Content-Type: application/json" \
        -d @data-blobstore-temp.json
}

create_s3_blob_store
