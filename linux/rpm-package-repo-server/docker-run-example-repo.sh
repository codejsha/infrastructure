#!/bin/bash

REPO_VOLUME_DIR="/mnt/volume/example-repo"
# sudo mkdir -p ${REPO_VOLUME_DIR}

docker container run \
    --detach \
    --name example-repo-server \
    --publish 8888:8888 \
    --mount type=bind,src=${REPO_VOLUME_DIR},dst=/var/www/html/example-repo \
    example-repo-server
