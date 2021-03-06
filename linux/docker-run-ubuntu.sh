#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

function docker_run_ubuntu20 {
    docker container run \
        --interactive \
        --tty \
        --name ubuntu20 \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        ubuntu:20.04
}

######################################################################

docker_run_ubuntu20
