#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

function install_docker_compose_with_download {
    local DOCKER_COMPOSE_VERSION="1.29.1"

    sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    # sudo ln -snf /usr/local/bin/docker-compose /usr/bin/docker-compose
}

######################################################################

install_docker_compose_with_download
