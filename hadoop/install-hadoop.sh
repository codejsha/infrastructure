#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

function install_hadoop  {
    local HADOOP_HOME="/usr/local/hadoop"
    local INSTALL_FILE_DIR="/mnt/share/apache-hadoop"
    local INSTALL_FILE="hadoop-3.1.2.tar.gz"

    local PARENT_HADOOP_HOME="$(readlink --canonicalize-missing ${HADOOP_HOME}/../)"
    local HADOOP_DIR_NAME="${INSTALL_FILE/\.tar\.gz/}"

    ### check install home
    if [ -d "${HADOOP_HOME}" ]; then
        echo "[ERROR] The HADOOP_HOME (${HADOOP_HOME}) already exists!"
        exit
    fi

    ### download install file
    if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
        sudo curl -o ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
            -LJO https://archive.apache.org/dist/hadoop/common/${HADOOP_DIR_NAME}/${INSTALL_FILE}
    fi

    ### check install file
    if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
        echo "[ERROR] The install file (${INSTALL_FILE_DIR}/${INSTALL_FILE}) does not exist!"
        exit
    fi

    ### install
    sudo tar -xzf ${INSTALL_FILE_DIR}/${INSTALL_FILE} -C ${PARENT_HADOOP_HOME}
    sudo mv ${PARENT_HADOOP_HOME}/${HADOOP_DIR_NAME} ${HADOOP_HOME}
    sudo chown -R $(id -un):$(id -gn) ${HADOOP_HOME}
}

######################################################################

install_hadoop
