#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

function docker_run_centos8 {
    docker container run \
        --interactive \
        --tty \
        --name centos8 \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        centos:8.2.2004
}

function docker_run_centos7 {
    docker container run \
        --interactive \
        --tty \
        --name centos7 \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        centos:7.8.2003
}

function docker_run_centos6 {
    docker container run \
        --interactive \
        --tty \
        --name centos6 \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        centos:6.10
}

######################################################################

# docker_run_centos8
docker_run_centos7
# docker_run_centos6
