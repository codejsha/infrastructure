#!/bin/bash

######################################################################

function install_docker_with_yum {
    sudo yum remove docker \
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
    DOCKER_VERSION="19.03.13"
    CONTAINERD_VERSION="1.3.7"

    sudo yum remove docker \
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

function install_docker_with_dnf {
    sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
    sudo dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.10-3.2.el7.x86_64.rpm
    sudo dnf install -y docker-ce

    sudo usermod -a -G docker ${USER}
    sudo systemctl enable --now docker
    sudo systemctl status docker

    exit
}

function install_docker_with_apt {
    curl -fsSL https://get.docker.com | sudo sh

    sudo usermod -a -G docker ${USER}

    exit
}

######################################################################

install_docker_with_yum
# install_docker_with_dnf
# install_docker_with_apt
