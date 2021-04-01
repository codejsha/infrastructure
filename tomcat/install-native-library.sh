#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh

JAVA_HOME="${JAVA_HOME}"
CATALINA_HOME="${CATALINA_HOME}"

INSTALL_FILE_DIR="/mnt/share/apache-tomcat"
INSTALL_FILE="tomcat-native-1.2.26-src.tar.gz"
INSTALL_SCRIPT_DIR="/svc/infrastructure/tomcat"

######################################################################

TOMCAT_NATIVE_CONNECTOR_DIR="$(echo ${INSTALL_FILE} | grep -o -E "(.*[^\.tar\.gz])")"

######################################################################

function check_catalina_home {
    if [ ! -d "${CATALINA_HOME}" ]; then
        echo "[ERROR] The CATALINA_HOME (${CATALINA_HOME}) does not exist!"
        exit
    fi
}

function check_install_file {
    if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
        echo "[ERROR] The install file (${INSTALL_FILE_DIR}/${INSTALL_FILE}) does not exist!"
        exit
    fi
}

function extract_install_file {
    /bin/cp -f ${INSTALL_FILE_DIR}/${INSTALL_FILE} ${INSTALL_SCRIPT_DIR}/tomcat
    cd ${INSTALL_SCRIPT_DIR}/tomcat
    tar -xzf ${INSTALL_FILE}
}

function build_native_connector {
    cd ${INSTALL_SCRIPT_DIR}/tomcat
    cd ${TOMCAT_NATIVE_CONNECTOR_DIR}
    cd jni/native

    ./configure \
        --with-java-home=${JAVA_HOME} \
        --with-apr=/usr/bin/apr-1-config \
        --with-ssl \
        --prefix=${TOMCAT_HOME}

    make
    make install
}

function delete_install_file {
    rm -f ${INSTALL_FILE}
}

######################################################################

check_catalina_home
check_install_file
extract_install_file
build_native_connector
# delete_install_file
