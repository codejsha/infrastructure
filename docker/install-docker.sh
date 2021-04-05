#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

######################################################################

function install_docker_with_dnf {
    sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io

    sudo usermod -a -G docker ${USER}
    sudo systemctl enable docker
    sudo systemctl start docker

    exit
}

function install_docker_with_yum {
    sudo yum remove -y \
        docker \
        docker-client \
        docker-client-latest \
        docker-common \
        docker-latest \
        docker-latest-logrotate \
        docker-logrotate \
        docker-engine

    sudo yum install -y yum-utils
    sudo yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io

    sudo usermod -a -G docker ${USER}
    sudo systemctl enable docker
    sudo systemctl start docker

    exit
}

function install_docker_specific_version_with_yum {
    local DOCKER_VERSION="19.03.15"
    local CONTAINERD_VERSION="1.3.9"

    sudo yum remove -y \
        docker \
        docker-client \
        docker-client-latest \
        docker-common \
        docker-latest \
        docker-latest-logrotate \
        docker-logrotate \
        docker-engine

    sudo yum install -y yum-utils
    sudo yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y \
        docker-ce-${DOCKER_VERSION} \
        docker-ce-cli-${DOCKER_VERSION} \
        containerd.io-${CONTAINERD_VERSION}

    sudo usermod -a -G docker ${USER}
    sudo systemctl enable docker
    sudo systemctl start docker

    exit
}

function install_docker_with_apt {
    curl -fsSL https://get.docker.com | sudo sh

    sudo usermod -a -G docker ${USER}

    exit
}

######################################################################

install_docker_with_dnf
# install_docker_with_yum
# install_docker_specific_version_with_yum
# install_docker_with_apt
