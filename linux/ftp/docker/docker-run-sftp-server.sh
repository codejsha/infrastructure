#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

USERNAME="user"
PASSWORD="${PASSWORD}"

######################################################################

function docker_run_sftp_server_share {
    docker container run \
        --detach \
        --name sftp-server \
        --publish 2222:22 \
        --mount type="bind",src="/mnt/share",dst="/home/${USERNAME}/share" \
        atmoz/sftp \
        ${USERNAME}:${PASSWORD}:1000
}

function docker_run_sftp_server_pub {
    local SFTP_SERVER_VOLUME_DIR="/mnt/volume/ftp/pub"
    sudo mkdir -p ${SFTP_SERVER_VOLUME_DIR}
    # sudo mkdir -p ${SFTP_SERVER_VOLUME_DIR}/{data,error,finished}
    # sudo chown -R 1000 ${SFTP_SERVER_VOLUME_DIR}

    docker container run \
        --detach \
        --name sftp-server \
        --publish 2222:22 \
        --mount type="bind",src="${SFTP_SERVER_VOLUME_DIR}",dst="/home/${USERNAME}/pub" \
        atmoz/sftp \
        ${USERNAME}:${PASSWORD}:1000
}

######################################################################

docker_run_sftp_server_share
# docker_run_sftp_server_pub
