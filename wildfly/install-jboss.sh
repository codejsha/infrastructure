#!/usr/bin/bash

source ./env-base.sh

INSTALL_FILE_DIR="/mnt/share/redhat-jboss-eap"

# INSTALL_FILE="jboss-eap-7.0.0.zip"
# INSTALL_FILE="jboss-eap-7.1.0.zip"
# INSTALL_FILE="jboss-eap-7.2.0.zip"
INSTALL_FILE="jboss-eap-7.3.0.zip"

######################################################################

PARENT_JBOSS_HOME="$(readlink --canonicalize-missing ${JBOSS_HOME}/../)"
JBOSS_DIR_NAME=${INSTALL_FILE/\.0\.zip/}

######################################################################

function check_jboss_home {
    if [ -d "${JBOSS_HOME}" ]; then
        echo "[ERROR] The JBOSS_HOME (${JBOSS_HOME}) already exists!"
        exit
    fi
}

function check_install_file {
    if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
        echo "[ERROR] The INSTALL_FILE (${INSTALL_FILE_DIR}/${INSTALL_FILE}) does not exists!"
        exit
    fi
}

######################################################################

check_jboss_home
check_install_file

unzip -q -o ${INSTALL_FILE_DIR}/${INSTALL_FILE} -d ${PARENT_JBOSS_HOME}
mv ${PARENT_JBOSS_HOME}/${JBOSS_DIR_NAME} ${JBOSS_HOME}