#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

######################################################################

function install_kafka_with_download {
    local KAFKA_HOME="/usr/local/kafka"
    local INSTALL_FILE_DIR="/mnt/share/apache-kafka"
    local INSTALL_FILE="kafka_2.13-2.8.0.tgz"

    local PARENT_KAFKA_HOME="$(readlink --canonicalize-missing ${KAFKA_HOME}/../)"
    local KAFKA_DIR_NAME="$(echo ${INSTALL_FILE} | grep -o -E "(.*[^\.tgz])")"
    local KAFKA_VERSION="$(echo ${INSTALL_FILE} | grep -o -E "([^kafka_][1-9]{1}\.[1-9]{1,2}.*[^\.tgz])" | tr -d "-")"

    function check_kafka_home {
        if [ -d "${KAFKA_HOME}" ]; then
            echo "[ERROR] The KAFKA_HOME (${KAFKA_HOME}) already exists!"
            exit
        fi
    }

    function download_install_file {
        if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
            sudo curl -o ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
                -LJO https://downloads.apache.org/kafka/${KAFKA_VERSION}/${INSTALL_FILE}
        fi
    }

    function check_install_file {
        if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
            echo "[ERROR] The install file (${INSTALL_FILE_DIR}/${INSTALL_FILE}) does not exist!"
            exit
        fi
    }

    function install_kafka {
        sudo tar -xzf ${INSTALL_FILE_DIR}/${INSTALL_FILE} -C ${PARENT_KAFKA_HOME}
        sudo mv ${PARENT_KAFKA_HOME}/${KAFKA_DIR_NAME} ${KAFKA_HOME}
        sudo chown -R $(id -un):$(id -gn) ${KAFKA_HOME}
    }

    check_kafka_home
    download_install_file
    check_install_file
    install_kafka

    ### add path
    # KAFKA_HOME="/usr/local/kafka"
    # PATH="${PATH}:${KAFKA_HOME}/bin"
    # export PATH
}

######################################################################

install_kafka_with_download
