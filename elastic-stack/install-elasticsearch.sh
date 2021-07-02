#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

ELASTICSEARCH_HOME="/usr/local/elasticsearch"
INSTALL_FILE_DIR="/mnt/share/elastic-elasticsearch"
INSTALL_FILE="elasticsearch-7.13.2-linux-x86_64.tar.gz"

PARENT_ELASTICSEARCH_HOME="$(readlink --canonicalize-missing ${ELASTICSEARCH_HOME}/../)"
ELASTICSEARCH_DIR_NAME="${INSTALL_FILE/\.tar\.gz/}"
ELASTICSEARCH_VERSION="$(echo ${INSTALL_FILE} | grep -o -E "[0-9]*\.[0-9]*\.[0-9]*")"

### check elasticsearch home
if [ -d "${ELASTICSEARCH_HOME}" ]; then
    echo "[ERROR] The ELASTICSEARCH_HOME (${ELASTICSEARCH_HOME}) already exists!"
    exit
fi

### download install file
if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
    sudo curl -o ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
        -LJO https://artifacts.elastic.co/downloads/elasticsearch/${INSTALL_FILE}
fi

### check install file
if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
    echo "[ERROR] The install file (${INSTALL_FILE_DIR}/${INSTALL_FILE}) does not exist!"
    exit
fi

sudo tar -xzf ${INSTALL_FILE_DIR}/${INSTALL_FILE} -C ${PARENT_ELASTICSEARCH_HOME}
sudo mv ${PARENT_ELASTICSEARCH_HOME}/${ELASTICSEARCH_DIR_NAME} ${ELASTICSEARCH_HOME}
sudo chown -R $(id -un):$(id -gn) ${ELASTICSEARCH_HOME}
