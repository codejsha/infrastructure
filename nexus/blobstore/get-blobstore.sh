#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NEXUS_URL="https://nexus.example.com"
NEXUS_USER="admin"
NEXUS_PASSWORD="admin123"
BLOBSTORE_NAME="${1}"

######################################################################

function get_s3_blob_store {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        --request GET \
        --header "Accept:application/json" \
        ${NEXUS_URL}/service/rest/beta/blobstores/s3/${BLOBSTORE_NAME}
}

######################################################################

get_s3_blob_store
