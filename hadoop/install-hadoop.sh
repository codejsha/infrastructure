#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

######################################################################

function install_hadoop  {
    local HADOOP_HOME="/usr/local/hadoop"
    local INSTALL_FILE_DIR="/mnt/share/apache-hadoop"
    local INSTALL_FILE="hadoop-3.1.2.tar.gz"

    local PARENT_HADOOP_HOME="$(readlink --canonicalize-missing ${HADOOP_HOME}/../)"
    local HADOOP_DIR_NAME="${INSTALL_FILE/\.tar\.gz/}"

    if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
        sudo curl -o ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
            -LJO https://archive.apache.org/dist/hadoop/common/${HADOOP_DIR_NAME}/${INSTALL_FILE}
    fi

    sudo tar -xzf ${INSTALL_FILE_DIR}/${INSTALL_FILE} -C ${PARENT_HADOOP_HOME}
    sudo mv ${PARENT_HADOOP_HOME}/${HADOOP_DIR_NAME} ${HADOOP_HOME}
    sudo chown -R $(id -un):$(id -gn) ${HADOOP_HOME}
}

######################################################################

install_hadoop
