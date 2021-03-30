#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

######################################################################

function docker_run_ubuntu {
    docker container run \
        --interactive \
        --tty \
        --name ubuntu \
        --mount type="bind",src="/mnt/share",dst="/mnt/share",readonly \
        --mount type="bind",src="/mnt/storage",dst="/mnt/storage" \
        ubuntu:20.04
}

######################################################################

docker_run_ubuntu
