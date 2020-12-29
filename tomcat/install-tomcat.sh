#!/bin/bash

CATALINA_HOME="/usr/local/tomcat"

INSTALL_FILE_DIR="/mnt/share/apache-tomcat"

# INSTALL_FILE="apache-tomcat-8.5.59.tar.gz"
INSTALL_FILE="apache-tomcat-9.0.39.tar.gz"
# INSTALL_FILE="apache-tomcat-10.0.0-M9.tar.gz"

######################################################################

CATALINA_HOME_DIR_NAME="$(echo ${CATALINA_HOME} | grep -E "([^\/]+$)")"
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

function install_from_online {
    curl -o ${PARENT_CATALINA_HOME}/${INSTALL_FILE} \
        -LJO http://mirror.apache-kr.org/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/${INSTALL_FILE}
    cd ${PARENT_CATALINA_HOME}
    tar -xzf ${INSTALL_FILE} -C ${PARENT_CATALINA_HOME}
    mv ${PARENT_CATALINA_HOME}/apache-tomcat-${TOMCAT_VERSION} ${PARENT_CATALINA_HOME}/${CATALINA_HOME_DIR_NAME}
    rm -f ${PARENT_CATALINA_HOME}/${INSTALL_FILE}
}

function install_from_storage {
    /usr/bin/cp -f ${INSTALL_FILE_DIR}/${INSTALL_FILE} ${PARENT_CATALINA_HOME}
    cd ${PARENT_CATALINA_HOME}
    tar -xzf ${INSTALL_FILE} -C ${PARENT_CATALINA_HOME}
    mv ${PARENT_CATALINA_HOME}/apache-tomcat-${TOMCAT_VERSION} ${PARENT_CATALINA_HOME}/${CATALINA_HOME_DIR_NAME}
}

function delete_install_file {
    rm -f ${PARENT_CATALINA_HOME}/${INSTALL_FILE}
}

######################################################################

check_catalina_home
# install_from_online
install_from_storage
# delete_install_file
