#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

function install_openjdk_with_dnf {
    sudo dnf install -y java-11-openjdk-devel
    sudo dnf install -y java-1.8.0-openjdk-devel
}

function install_openjdk_with_yum {
    sudo yum install -y java-11-openjdk-devel
    sudo yum install -y java-1.8.0-openjdk-devel
    sudo yum install -y java-1.7.0-openjdk-devel
}

function install_openjdk_with_apt {
    sudo apt-get install openjdk-11-jdk
    sudo apt-get install openjdk-8-jdk
    sudo apt-get install openjdk-7-jdk
}

######################################################################

install_openjdk_with_dnf
# install_openjdk_with_yum
# install_openjdk_with_apt
