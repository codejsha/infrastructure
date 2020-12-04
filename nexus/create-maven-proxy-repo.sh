#!/bin/bash

export NEXUS_URL="https://nexus.example.com"
export NEXUS_USER="admin"
export NEXUS_PASSWORD="admin123"
export REPOSITORY_NAME="${1}"
export BLOBSTORE_NAME="${2}"
export REMOTE_URL="${3}"

envsubst < ./data-maven-proxy-repo.json > ./data-maven-proxy-repo-temp.json

function create_maven_proxy_repository {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X POST "${NEXUS_URL}/service/rest/beta/repositories/maven/proxy" \
        -H "accept: application/json" \
        -H "Content-Type: application/json" \
        -d @data-maven-proxy-repo-temp.json
}

create_maven_proxy_repository
