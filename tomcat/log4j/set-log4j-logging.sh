#!/bin/bash

CATALINA_HOME="/usr/local/tomcat"

INSTALL_FILE_DIR="/mnt/share/apache-log4j"
INSTALL_FILE="apache-log4j-2.14.0-bin.tar.gz"
INSTALL_SCRIPT_DIR="/svc/infrastructure/tomcat"

######################################################################

LOG4J_INSTALL_FILE_DIR_NAME="$(echo ${INSTALL_FILE} | grep -o -E "(.*[^\.tar\.gz])")"
LOG4J_VERSION="$(echo ${INSTALL_FILE} | grep -o -E "([^apache-log4j-].*[^-bin\.tar\.gz])")"

######################################################################

function extract_install_file {
    /usr/bin/cp -f \
        ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
        ${INSTALL_SCRIPT_DIR}/log4j
    cd ${INSTALL_SCRIPT_DIR}/log4j
    tar -xzf ${INSTALL_FILE}
}

function create_log4j_directory {
    mkdir -p ${CATALINA_HOME}/log4j2/{conf,lib}
}

function copy_library {
    /usr/bin/cp -f \
        ${INSTALL_SCRIPT_DIR}/log4j/${LOG4J_INSTALL_FILE_DIR_NAME}/log4j-api-${LOG4J_VERSION}.jar \
        ${CATALINA_HOME}/log4j2/lib
    /usr/bin/cp -f \
        ${INSTALL_SCRIPT_DIR}/log4j/${LOG4J_INSTALL_FILE_DIR_NAME}/log4j-appserver-${LOG4J_VERSION}.jar \
        ${CATALINA_HOME}/log4j2/lib
    /usr/bin/cp -f \
        ${INSTALL_SCRIPT_DIR}/log4j/${LOG4J_INSTALL_FILE_DIR_NAME}/log4j-core-${LOG4J_VERSION}.jar \
        ${CATALINA_HOME}/log4j2/lib
}

function copy_config_file {
    /usr/bin/cp -f \
        ${INSTALL_SCRIPT_DIR}/log4j/log4j2-tomcat.xml \
        ${CATALINA_HOME}/log4j2/conf
}

function copy_setenv_script {
    /usr/bin/cp -f \
        ${INSTALL_SCRIPT_DIR}/log4j/setenv.sh \
        ${CATALINA_HOME}/bin/setenv.sh
}

######################################################################

extract_install_file
create_log4j_directory
copy_library
copy_config_file
copy_setenv_script
