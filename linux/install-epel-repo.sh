#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

sudo yum install -y epel-release
# sudo dnf config-manager --set-enabled PowerTools
