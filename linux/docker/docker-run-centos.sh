#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

function docker_run_centos8 {
    docker container run \
        -it \
        --name centos8 \
        --mount type="bind",src="/mnt/share",dst="/mnt/share",readonly \
        --mount type="bind",src="/mnt/storage",dst="/mnt/storage" \
        centos:8.2.2004
}

function docker_run_centos7 {
    docker container run \
        -it \
        --name centos7 \
        --mount type="bind",src="/mnt/share",dst="/mnt/share",readonly \
        --mount type="bind",src="/mnt/storage",dst="/mnt/storage" \
        centos:7.8.2003
}

function docker_run_centos6 {
    docker container run \
        -it \
        --name centos6 \
        --mount type="bind",src="/mnt/share",dst="/mnt/share",readonly \
        --mount type="bind",src="/mnt/storage",dst="/mnt/storage" \
        centos:6.10
}

######################################################################

# docker_run_centos8
docker_run_centos7
# docker_run_centos6
