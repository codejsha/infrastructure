#!/bin/bash

export NEXUS_URL="https://nexus.example.com"
export NEXUS_USER="admin"
export NEXUS_PASSWORD="admin123"
export REPOSITORY_NAME="${1}"
export BLOBSTORE_NAME="${2}"

envsubst < ./data-helm-hosted-repo.json > ./data-helm-hosted-repo-temp.json

function create_helm_hosted_repository {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X POST "${NEXUS_URL}/service/rest/beta/repositories/helm/hosted" \
        -H "Accept:application/json" \
        -H "Content-Type: application/json" \
        -d @data-helm-hosted-repo-temp.json
}

create_helm_hosted_repository
