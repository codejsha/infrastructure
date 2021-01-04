#!/bin/bash

export NEXUS_URL="https://nexus.example.com"
export NEXUS_USER="admin"
export NEXUS_PASSWORD="admin123"
export REPOSITORY_NAME="${1}"
export BLOBSTORE_NAME="${2}"

envsubst < ./data-maven-hosted-repo.json > ./data-maven-hosted-repo-temp.json

function create_maven_hosted_repository {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X POST "${NEXUS_URL}/service/rest/beta/repositories/maven/hosted" \
        -H "Accept:application/json" \
        -H "Content-Type: application/json" \
        -d @data-maven-hosted-repo-temp.json
}

create_maven_hosted_repository
