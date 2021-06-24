#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

NEXUS_VOLUME_DIR="/mnt/volume/nexus"
sudo mkdir -p ${NEXUS_VOLUME_DIR}

######################################################################

function docker_run_nexus {
    docker container run \
        --detach \
        --name nexus \
        --publish 8081:8081 \
        --mount type="bind",src="${NEXUS_VOLUME_DIR}",dst="/nexus-data" \
        sonatype/nexus3
}

######################################################################

docker_run_nexus
