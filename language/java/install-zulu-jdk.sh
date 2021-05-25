#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

######################################################################

function install_zulujdk_with_yum {
    sudo yum install -y https://cdn.azul.com/zulu/bin/zulu-repo-1.0.0-1.noarch.rpm

    sudo yum install zulu11-jdk
    sudo yum install zulu8-jdk
}

######################################################################

install_zulujdk_with_yum
