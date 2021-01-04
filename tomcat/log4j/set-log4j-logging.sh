#!/bin/bash

source ./env-base.sh

CATALINA_HOME="${CATALINA_HOME}"

INSTALL_FILE_DIR="/mnt/share/apache-log4j"
INSTALL_FILE="apache-log4j-2.14.0-bin.tar.gz"

######################################################################

LOG4J_INSTALL_FILE_DIR_NAME="$(echo ${INSTALL_FILE} | grep -o -E "(.*[^\.tar\.gz])")"
LOG4J_VERSION="$(echo ${INSTALL_FILE} | grep -o -E "([^apache-log4j-].*[^-bin\.tar\.gz])")"

######################################################################

function check_log4j_dir {
    if [ -d "${CATALINA_HOME}/log4j2" ]; then
        echo "[ERROR] The log4j2 directory (${CATALINA_HOME}/log4j2) already exists!"
        exit
    fi
}

function check_install_file {
    if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
        echo "[ERROR] The INSTALL_FILE (${INSTALL_FILE_DIR}/${INSTALL_FILE}) does not exists!"
        exit
    fi
}

function download_install_file_from_online {
    if [ ! -f "${INSTALL_FILE}" ]; then
        curl -LJO https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/${INSTALL_FILE}
    fi
}

function copy_install_file_from_storage {
    check_install_file

    /usr/bin/cp -f ${INSTALL_FILE_DIR}/${INSTALL_FILE} .
}

function extract_install_file {
    tar -xzf ${INSTALL_FILE}
}

function create_log4j_directory {
    mkdir -p ${CATALINA_HOME}/log4j2/{conf,lib}
}

function copy_library {
    /usr/bin/cp -f \
        ${LOG4J_INSTALL_FILE_DIR_NAME}/log4j-api-${LOG4J_VERSION}.jar \
        ${CATALINA_HOME}/log4j2/lib
    /usr/bin/cp -f \
        ${LOG4J_INSTALL_FILE_DIR_NAME}/log4j-appserver-${LOG4J_VERSION}.jar \
        ${CATALINA_HOME}/log4j2/lib
    /usr/bin/cp -f \
        ${LOG4J_INSTALL_FILE_DIR_NAME}/log4j-core-${LOG4J_VERSION}.jar \
        ${CATALINA_HOME}/log4j2/lib
}

function copy_config_file {
    /usr/bin/cp -f \
        log4j2-tomcat.xml \
        ${CATALINA_HOME}/log4j2/conf
}

function copy_setenv_script {
    /usr/bin/cp -f \
        setenv.sh \
        ${CATALINA_HOME}/bin/setenv.sh
    chmod 750 ${CATALINA_HOME}/bin/setenv.sh
}

######################################################################

check_log4j_dir
# download_install_file_from_online
copy_install_file_from_storage
extract_install_file
create_log4j_directory
copy_library
copy_config_file
copy_setenv_script
