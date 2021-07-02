#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

KIBANA_HOME="/usr/local/kibana"
INSTALL_FILE_DIR="/mnt/share/elastic-stack"
INSTALL_FILE="kibana-7.13.2-linux-x86_64.tar.gz"

KIBANA_VERSION="$(echo ${INSTALL_FILE} | grep -o -E "[0-9]*\.[0-9]*\.[0-9]*")"
PARENT_KIBANA_HOME="$(readlink --canonicalize-missing ${KIBANA_HOME}/../)"
KIBANA_DIR_NAME="${INSTALL_FILE/\.tar\.gz/}"

### check install home
if [ -d "${KIBANA_HOME}" ]; then
    echo "[ERROR] The KIBANA_HOME (${KIBANA_HOME}) already exists!"
    exit
fi

### download install file
if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
    sudo curl -o ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
        -LJO https://artifacts.elastic.co/downloads/kibana/${INSTALL_FILE}
fi

### check install file
if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
    echo "[ERROR] The install file (${INSTALL_FILE_DIR}/${INSTALL_FILE}) does not exist!"
    exit
fi

### install
sudo tar -xzf ${INSTALL_FILE_DIR}/${INSTALL_FILE} -C ${PARENT_KIBANA_HOME}
sudo mv ${PARENT_KIBANA_HOME}/${KIBANA_DIR_NAME} ${KIBANA_HOME}
sudo chown -R $(id -un):$(id -gn) ${KIBANA_HOME}
