#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

CATALINA_HOME="${CATALINA_HOME}"

INSTALL_FILE_DIR="/mnt/share/apache-log4j"
INSTALL_FILE="apache-log4j-2.14.0-bin.tar.gz"
INSTALL_SCRIPT_DIR="/svc/infrastructure/tomcat/log4j"

######################################################################

LOG4J_VERSION="$(echo ${INSTALL_FILE} | grep -o -E "([^apache-log4j-].*[^-bin\.tar\.gz])")"
LOG4J_DIR_NAME="$(echo ${INSTALL_FILE} | grep -o -E "(.*[^\.tar\.gz])")"

######################################################################

function check_install_home {
    if [ -d "${CATALINA_HOME}/log4j2" ]; then
        echo "[ERROR] The log4j2 directory (${CATALINA_HOME}/log4j2) already exists!"
        exit
    fi
}

function download_install_file {
    if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
        sudo curl -o ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
            -LJO https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/${INSTALL_FILE}
    fi
}

function extract_install_file {
    sudo tar -xzf ${INSTALL_FILE_DIR}/${INSTALL_FILE} -C ${INSTALL_FILE_DIR}
}

function create_log4j_dir {
    mkdir -p ${CATALINA_HOME}/log4j2/{conf,lib}
}

function copy_library {
    /bin/cp -f \
        ${INSTALL_FILE_DIR}/${LOG4J_DIR_NAME}/log4j-api-${LOG4J_VERSION}.jar \
        ${CATALINA_HOME}/log4j2/lib
    /bin/cp -f \
        ${INSTALL_FILE_DIR}/${LOG4J_DIR_NAME}/log4j-appserver-${LOG4J_VERSION}.jar \
        ${CATALINA_HOME}/log4j2/lib
    /bin/cp -f \
        ${INSTALL_FILE_DIR}/${LOG4J_DIR_NAME}/log4j-core-${LOG4J_VERSION}.jar \
        ${CATALINA_HOME}/log4j2/lib
}

function copy_config_file {
    /bin/cp -f ${INSTALL_SCRIPT_DIR}/log4j2-tomcat.xml ${CATALINA_HOME}/log4j2/conf
}

function copy_setenv_script {
    /bin/cp -f ${INSTALL_SCRIPT_DIR}/setenv.sh ${CATALINA_HOME}/bin
    chmod 750 ${CATALINA_HOME}/bin/setenv.sh
}

######################################################################

check_install_home
download_install_file
extract_install_file
create_log4j_dir
copy_library
copy_config_file
copy_setenv_script
