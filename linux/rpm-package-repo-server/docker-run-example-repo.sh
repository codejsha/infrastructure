#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

REPO_VOLUME_DIR="/mnt/volume/example-repo"
# sudo mkdir -p ${REPO_VOLUME_DIR}

######################################################################

function docker_run_example_repo {
    docker container run \
        --detach \
        --name example-repo \
        --publish 8888:8888 \
        --mount type="bind",src="${REPO_VOLUME_DIR}",dst="/var/www/html/example-repo" \
        example-repo
}

######################################################################

docker_run_example_repo
