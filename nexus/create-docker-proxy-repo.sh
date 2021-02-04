#!/bin/bash

export NEXUS_URL="https://nexus.example.com"
export NEXUS_USER="admin"
export NEXUS_PASSWORD="admin123"
export REPOSITORY_NAME="${1}"
export BLOBSTORE_NAME="${2}"
export REMOTE_URL="${3}"
export DOCKER_INDEX_TYPE="${4}"

envsubst < ./data-docker-proxy-repo.json > ./data-docker-proxy-repo-temp.json

function create_docker_proxy_repository {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X POST \
        -H "Accept:application/json" \
        -H "Content-Type:application/json" \
        -d @data-docker-proxy-repo-temp.json \
        ${NEXUS_URL}/service/rest/beta/repositories/docker/proxy
}

create_docker_proxy_repository
