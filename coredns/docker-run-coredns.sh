#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

COREDNS_VOLUME_DIR="/mnt/volume/coredns"
sudo mkdir -p ${COREDNS_VOLUME_DIR}
sudo /bin/cp -f corefile-server.conf ${COREDNS_VOLUME_DIR}/Corefile

######################################################################

function docker_run_coredns {
    docker container run \
        --detach \
        --name coredns \
        --restart unless-stopped \
        --publish 53:53/udp \
        --mount type="bind",src="${COREDNS_VOLUME_DIR}",dst="/root/coredns" \
        coredns/coredns:latest \
        -conf /root/coredns/Corefile
}

function podman_run_coredns {
    sudo podman container run \
        --detach \
        --name coredns \
        --restart unless-stopped \
        --publish 53:53/udp \
        --mount type="bind",src="${COREDNS_VOLUME_DIR}",dst="/root/coredns" \
        coredns/coredns:latest \
        -conf /root/coredns/Corefile
}

######################################################################

docker_run_coredns
# podman_run_coredns
