#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

INSTALL_FILE_DIR="/mnt/share/redhat-jboss-eap"

# INSTALL_FILE="jboss-eap-7.0.0.zip"
# INSTALL_FILE="jboss-eap-7.1.0.zip"
# INSTALL_FILE="jboss-eap-7.2.0.zip"
INSTALL_FILE="jboss-eap-7.3.0.zip"

######################################################################

PARENT_JBOSS_HOME="$(readlink --canonicalize-missing ${JBOSS_HOME}/../)"
JBOSS_DIR_NAME="${INSTALL_FILE/\.0\.zip/}"

######################################################################

function check_jboss_home {
    if [ -d "${JBOSS_HOME}" ]; then
        echo "[ERROR] The JBOSS_HOME (${JBOSS_HOME}) already exists!"
        exit
    fi
}

function check_install_file {
    if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
        echo "[ERROR] The install file (${INSTALL_FILE_DIR}/${INSTALL_FILE}) does not exist!"
        exit
    fi
}

function install_jboss {
    sudo unzip -q -o ${INSTALL_FILE_DIR}/${INSTALL_FILE} -d ${PARENT_JBOSS_HOME}
    sudo mv ${PARENT_JBOSS_HOME}/${JBOSS_DIR_NAME} ${JBOSS_HOME}
    sudo chown -R $(id -un):$(id -gn) ${JBOSS_HOME}
}

######################################################################

check_jboss_home
check_install_file
install_jboss
