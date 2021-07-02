#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

function install_hive  {
    local HIVE_HOME="/usr/local/hive"
    local INSTALL_FILE_DIR="/mnt/share/apache-hive"
    local INSTALL_FILE="apache-hive-3.1.2-bin.tar.gz"

    local PARENT_HIVE_HOME="$(readlink --canonicalize-missing ${HIVE_HOME}/../)"
    local HIVE_DIR_NAME="${INSTALL_FILE/\.tar\.gz/}"

    ### check install home
    if [ -d "${HIVE_HOME}" ]; then
        echo "[ERROR] The HIVE_HOME (${HIVE_HOME}) already exists!"
        exit
    fi

    ### download install file
    if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
        sudo curl -o ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
            -LJO https://archive.apache.org/dist/hadoop/common/${HIVE_DIR_NAME}/${INSTALL_FILE}
    fi

    ### check install file
    if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
        echo "[ERROR] The install file (${INSTALL_FILE_DIR}/${INSTALL_FILE}) does not exist!"
        exit
    fi

    ### install
    sudo tar -xzf ${INSTALL_FILE_DIR}/${INSTALL_FILE} -C ${PARENT_HIVE_HOME}
    sudo mv ${PARENT_HIVE_HOME}/${HIVE_DIR_NAME} ${HIVE_HOME}
    sudo chown -R $(id -un):$(id -gn) ${HIVE_HOME}
}

######################################################################

install_hive
