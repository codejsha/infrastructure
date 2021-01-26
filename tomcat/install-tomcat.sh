#!/bin/bash

source ./env-base.sh

CATALINA_HOME="${CATALINA_HOME}"

INSTALL_FILE_DIR="/mnt/share/apache-tomcat"

# INSTALL_FILE="apache-tomcat-8.5.59.tar.gz"
INSTALL_FILE="apache-tomcat-9.0.39.tar.gz"
# INSTALL_FILE="apache-tomcat-10.0.0-M9.tar.gz"

######################################################################

PARENT_CATALINA_HOME="$(readlink --canonicalize-missing ${CATALINA_HOME}/../)"
TOMCAT_VERSION="$(echo ${INSTALL_FILE} | grep -o -E "([^apache-tomcat-].*[^\.tar\.gz])")"
TOMCAT_MAJOR_VERSION="$(echo ${TOMCAT_VERSION} | grep -o -E "^[0-9]{1,3}")"

######################################################################

function check_catalina_home {
    if [ -d "${CATALINA_HOME}" ]; then
        echo "[ERROR] The CATALINA_HOME (${CATALINA_HOME}) already exists!"
        exit
    fi
}

function check_install_file {
    if [ ! -f "${INSTALL_FILE_DIR}/${INSTALL_FILE}" ]; then
        echo "[ERROR] The INSTALL_FILE (${INSTALL_FILE_DIR}/${INSTALL_FILE}) does not exist!"
        exit
    fi
}

function install_from_online {
    if [ ! -f "${INSTALL_FILE}" ]; then
        curl -LJO https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/${INSTALL_FILE}
    fi

    tar -xzf ${INSTALL_FILE} -C ${PARENT_CATALINA_HOME}
    mv ${PARENT_CATALINA_HOME}/apache-tomcat-${TOMCAT_VERSION} ${CATALINA_HOME}
}

function install_from_storage {
    check_install_file

    /usr/bin/cp -f ${INSTALL_FILE_DIR}/${INSTALL_FILE} .
    tar -xzf ${INSTALL_FILE} -C ${PARENT_CATALINA_HOME}
    mv ${PARENT_CATALINA_HOME}/apache-tomcat-${TOMCAT_VERSION} ${CATALINA_HOME}
}

function delete_install_file {
    rm -f ${INSTALL_FILE}
}

######################################################################

check_catalina_home
# install_from_online
install_from_storage
# delete_install_file
