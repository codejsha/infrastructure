#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

curl -s https://packagecloud.io/install/repositories/datawireio/telepresence/script.rpm.sh | sudo bash
sudo dnf install telepresence
