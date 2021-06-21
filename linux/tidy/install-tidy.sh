#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

function install_tidy_with_dnf {
    sudo dnf install -y tidy
}

function install_tidy_with_yum {
    sudo yum install -y tidy
}

function install_tidy_with_apt {
    sudo apt-get install -y tidy
}

######################################################################

install_tidy_with_dnf
# install_tidy_with_yum
# install_tidy_with_apt
