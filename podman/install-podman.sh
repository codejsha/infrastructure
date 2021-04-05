#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

######################################################################

function install_podman_with_dnf {
	sudo dnf install -y podman
}

function install_podman_with_yum {
	sudo yum install -y podman
}

######################################################################

install_podman_with_dnf
# install_podman_with_yum
