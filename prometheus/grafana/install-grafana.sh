#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

GRAFANA_HOME="/usr/local/grafana"
INSTALL_FILE_DIR="/mnt/share/grafana"
INSTALL_FILE="grafana-8.0.3.linux-amd64.tar.gz"

PARENT_GRAFANA_HOME="$(readlink --canonicalize-missing ${GRAFANA_HOME}/../)"
GRAFANA_DIR_NAME="${INSTALL_FILE/\.tar\.gz/}"

### check install home
if [ -d "${GRAFANA_HOME}" ]; then
    echo "[ERROR] The GRAFANA_HOME (${GRAFANA_HOME}) already exists!"
    exit
fi

### download install file
if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
    sudo curl -o ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
        -LJO https://dl.grafana.com/oss/release/${INSTALL_FILE}
fi

### check install file
if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
    echo "[ERROR] The install file (${INSTALL_FILE_DIR}/${INSTALL_FILE}) does not exist!"
    exit
fi

### install
sudo tar -xzf ${INSTALL_FILE_DIR}/${INSTALL_FILE} -C ${PARENT_GRAFANA_HOME}
sudo mv ${PARENT_GRAFANA_HOME}/${GRAFANA_DIR_NAME} ${GRAFANA_HOME}
sudo chown -R $(id -un):$(id -gn) ${GRAFANA_HOME}
