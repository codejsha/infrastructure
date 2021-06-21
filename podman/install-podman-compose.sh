#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

function install_podman_compose_with_dnf {
	sudo dnf install -y podman-compose
}

function install_podman_compose_with_yum {
	sudo yum install -y podman-compose
}

######################################################################

install_podman_compose_with_dnf
# install_podman_compose_with_yum
