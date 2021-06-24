#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

export NEXUS_URL="https://nexus.example.com"
export NEXUS_USER="admin"
export NEXUS_PASSWORD="admin123"
export REPOSITORY_NAME="${1}"
export BLOBSTORE_NAME="${2}"
export REPOSITORY_MEMBER_NAMES="${3}"

envsubst < ./data-docker-group-repo.json > ./data-docker-group-repo-temp.json

######################################################################

function update_docker_group_repository {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        --request PUT \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --data @data-docker-group-repo-temp.json \
        ${NEXUS_URL}/service/rest/beta/repositories/docker/group/${REPOSITORY_NAME}
}

######################################################################

update_docker_group_repository
