#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

sudo yum install -y dnf

sudo yum install -y dnf-plugins-core
# sudo dnf install 'dnf-command(config-manager)'

# sudo dnf config-manager --set-enabled PowerTools
