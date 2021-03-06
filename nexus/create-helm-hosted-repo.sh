#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

export NEXUS_URL="https://nexus.example.com"
export NEXUS_USER="admin"
export NEXUS_PASSWORD="admin123"
export REPOSITORY_NAME="${1}"
export BLOBSTORE_NAME="${2}"

envsubst < ./data-helm-hosted-repo.json > ./data-helm-hosted-repo-temp.json

######################################################################

function create_helm_hosted_repository {
    curl --insecure \
        --user ${NEXUS_USER}:${NEXUS_PASSWORD} \
        -X POST \
        -H "Accept:application/json" \
        -H "Content-Type:application/json" \
        -d @data-helm-hosted-repo-temp.json \
        ${NEXUS_URL}/service/rest/beta/repositories/helm/hosted
}

######################################################################

create_helm_hosted_repository
