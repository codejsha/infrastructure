#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

INSTALL_FILE_DIR="/mnt/share/oracle-iplanet-web-server/Oracle-iPlanet-Web-Server-7.0.27-linux-x64"
INSTALL_SCRIPT_DIR="/svc/infrastructure/iplanet"

sudo yum install -y \
    glibc.i686 \
    compat-libstdc++-33.x86_64

${INSTALL_FILE_DIR}/setup --silent ${INSTALL_SCRIPT_DIR}/statefile
