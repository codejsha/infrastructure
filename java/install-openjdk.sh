#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

######################################################################

function install_openjdk_with_yum {
    sudo yum install -y java-1.7.0-openjdk-devel
    sudo yum install -y java-1.8.0-openjdk-devel
    sudo yum install -y java-11-openjdk-devel
}

function install_openjdk_with_apt {
    sudo apt-get install openjdk-7-jdk
    sudo apt-get install openjdk-8-jdk
    sudo apt-get install openjdk-11-jdk
}

######################################################################

install_openjdk_with_yum
# install_openjdk_with_apt
