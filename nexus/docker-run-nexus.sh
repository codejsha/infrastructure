#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

NEXUS_VOLUME_DIR="/mnt/volume/nexus"
sudo mkdir -p ${NEXUS_VOLUME_DIR}

docker container run \
    --detach \
    --name nexus \
    --publish 8081:8081 \
    --mount type=bind,src=${NEXUS_VOLUME_DIR},dst=/nexus-data sonatype/nexus3 \
    sonatype/nexus3
