#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

function install_sysstat_with_dnf {
    sudo dnf install -y sysstat
}

function install_sysstat_with_yum {
    sudo yum install -y sysstat
}

function install_sysstat_with_apt {
    sudo apt-get install -y sysstat
}

######################################################################

install_sysstat_with_dnf
# install_sysstat_with_yum
# install_sysstat_with_apt
