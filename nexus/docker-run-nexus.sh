#!/bin/bash

NEXUS_VOLUME_DIR="/mnt/volume/nexus"
sudo mkdir -p ${NEXUS_VOLUME_DIR}

docker container run \
    --detach \
    --name nexus \
    --publish 8081:8081 \
    --mount type=bind,src=${NEXUS_VOLUME_DIR},dst=/nexus-data sonatype/nexus3 \
    sonatype/nexus3
