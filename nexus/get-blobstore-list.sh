#!/bin/bash

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"

function get_blob_store_list {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X GET \
        -H "Accept:application/json" \
        ${NEXUS_URL}/service/rest/beta/blobstores
}

get_blob_store_list
