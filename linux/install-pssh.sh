#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

sudo dnf install -y epel-release
sudo dnf install -y pssh

# sudo yum install -y epel-release
# sudo yum install -y pssh
