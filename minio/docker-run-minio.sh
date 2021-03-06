#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

PASSWORD="${PASSWORD}"

MINIO_VOLUME_DIR="/mnt/volume/minio"

######################################################################

function docker_run_minio {
    docker container run \
        --detach \
        --name minio-server \
        --publish 9000:9000 \
        --env MINIO_ROOT_USER=admin \
        --env MINIO_ROOT_PASSWORD=${PASSWORD} \
        --mount type=bind,src=${MINIO_VOLUME_DIR},dst=/data \
        minio/minio server ${MINIO_VOLUME_DIR}
}

######################################################################

docker_run_minio
