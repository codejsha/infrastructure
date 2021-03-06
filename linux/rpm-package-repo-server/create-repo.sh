#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

sudo yum install -y yum-utils createrepo

PACKAGE_REPO_VOLUME_DIR="/mnt/volume/example-repo"
sudo mkdir -p ${PACKAGE_REPO_VOLUME_DIR}/package

sudo createrepo ${PACKAGE_REPO_VOLUME_DIR}
