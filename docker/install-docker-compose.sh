#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

function install_docker_with_download {
    local DOCKER_COMPOSE_VERSION="1.27.4"

    sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    # sudo ln -snf /usr/local/bin/docker-compose /usr/bin/docker-compose
}

function install_docker_with_yum {
    sudo yum install -y docker-compose
}

######################################################################

install_docker_with_download
install_docker_with_yum
