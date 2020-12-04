#!/bin/bash

export NEXUS_URL="https://nexus.example.com"
export NEXUS_USER="admin"
export NEXUS_PASSWORD="admin123"
export REPOSITORY_NAME="${1}"
export BLOBSTORE_NAME="${2}"
export REPOSITORY_MEMBER_NAMES="${3}"

envsubst < ./data-docker-group-repo.json > ./data-docker-group-repo-temp.json

function update_docker_group_repository {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X PUT "${NEXUS_URL}/service/rest/beta/repositories/docker/group/${REPOSITORY_NAME}" \
        -H "accept: application/json" \
        -H "Content-Type: application/json" \
        -d @data-docker-group-repo-temp.json
}

update_docker_group_repository
