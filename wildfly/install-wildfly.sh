#!/bin/bash

source ./env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

INSTALL_FILE_DIR="/mnt/share/wildfly"

# INSTALL_FILE="wildfly-17.0.1.Final.zip"
# INSTALL_FILE="wildfly-19.0.0.Final.zip"
# INSTALL_FILE="wildfly-20.0.0.Final.zip"
INSTALL_FILE="wildfly-20.0.1.Final.tar.gz"

######################################################################

PARENT_JBOSS_HOME="$(readlink --canonicalize-missing ${JBOSS_HOME}/../)"
JBOSS_DIR_NAME="${INSTALL_FILE/\.tar\.gz/}"

######################################################################

function check_jboss_home {
    if [ -d "${JBOSS_HOME}" ]; then
        echo "[ERROR] The JBOSS_HOME (${JBOSS_HOME}) already exists!"
        exit
    fi
}

function check_install_file {
    if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
        echo "[ERROR] The INSTALL_FILE (${INSTALL_FILE_DIR}/${INSTALL_FILE}) does not exist!"
        exit
    fi
}

######################################################################

check_jboss_home
check_install_file

tar -C ${PARENT_JBOSS_HOME} -xzf ${INSTALL_FILE_DIR}/${INSTALL_FILE}
mv ${PARENT_JBOSS_HOME}/${JBOSS_DIR_NAME} ${JBOSS_HOME}
