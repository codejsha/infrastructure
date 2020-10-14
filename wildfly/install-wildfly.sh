#!/usr/bin/bash

source ./env-base.sh

INSTALL_FILE_DIR="/mnt/share/wildfly"
# INSTALL_FILE_DIR="/mnt/share/redhat-jboss-eap"

INSTALL_FILE="wildfly-20.0.1.Final.tar.gz"
# INSTALL_FILE="jboss-eap-7.2.0.zip"
# INSTALL_FILE="jboss-eap-7.3.0.zip"

PARENT_JBOSS_HOME="$(readlink --canonicalize-missing ${JBOSS_HOME}/../)"
# unzip -q -o ${INSTALL_FILE_DIR}/${INSTALL_FILE} -d ${PARENT_JBOSS_HOME}
tar -C ${PARENT_JBOSS_HOME} -xzf ${INSTALL_FILE_DIR}/${INSTALL_FILE}

TEMP_JBOSS_DIR_NAME=${INSTALL_FILE/\.tar\.gz/}
JBOSS_DIR_NAME=${TEMP_JBOSS_DIR_NAME/\.zip/}
mv ${PARENT_JBOSS_HOME}/${JBOSS_DIR_NAME} ${JBOSS_HOME}
