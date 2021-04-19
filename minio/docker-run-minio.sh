#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

USERNAME="minio"
PASSWORD="minio123"
# PASSWORD="${PASSWORD}"

MINIO_VOLUME_DIR="/mnt/volume/minio"
sudo mkdir -p ${MINIO_VOLUME_DIR}

######################################################################

function docker_run_minio {
    docker container run \
        --detach \
        --name minio \
        --publish 9000:9000 \
        --env MINIO_ROOT_USER="${USERNAME}" \
        --env MINIO_ROOT_PASSWORD="${PASSWORD}" \
        --mount type="bind",src="${MINIO_VOLUME_DIR}",dst="/data" \
        minio/minio server ${MINIO_VOLUME_DIR}
}

######################################################################

docker_run_minio
