#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

function docker_run_burrow {
    docker container run \
        --detach \
        --name burrow \
        --network stream-network \
        --publish 8000:8000 \
        docker.pkg.github.com/linkedin/burrow/burrow:latest
}

######################################################################

docker_run_burrow
