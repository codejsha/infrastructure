#!/bin/bash

# TOMCAT_MAJOR_VERSION="8"
# TOMCAT_VERSION="8.5.59"
TOMCAT_MAJOR_VERSION="9"
TOMCAT_VERSION="9.0.39"
# TOMCAT_MAJOR_VERSION="10"
# TOMCAT_VERSION="10.0.0-M9"

PARENT_TOMCAT_HOME="/svc/appsvr"
INSTALL_FILE_DIR="/mnt/share/apache-tomcat"

######################################################################

function install_from_online {
    curl -o ${PARENT_TOMCAT_HOME}/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
        -LJO http://mirror.apache-kr.org/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
    tar -C ${PARENT_TOMCAT_HOME} -xzf ${PARENT_TOMCAT_HOME}/apache-tomcat-${TOMCAT_VERSION}.tar.gz
    mv ${PARENT_TOMCAT_HOME}/apache-tomcat-${TOMCAT_VERSION} ${PARENT_TOMCAT_HOME}/tomcat${TOMCAT_MAJOR_VERSION}
    rm -f ${PARENT_TOMCAT_HOME}/apache-tomcat-${TOMCAT_VERSION}.tar.gz
}

function install_from_storage {
    cp ${INSTALL_FILE_DIR}/apache-tomcat-${TOMCAT_VERSION}.tar.gz ${PARENT_TOMCAT_HOME}
    tar -C ${PARENT_TOMCAT_HOME} -xzf ${PARENT_TOMCAT_HOME}/apache-tomcat-${TOMCAT_VERSION}.tar.gz
    mv ${PARENT_TOMCAT_HOME}/apache-tomcat-${TOMCAT_VERSION} ${PARENT_TOMCAT_HOME}/tomcat${TOMCAT_MAJOR_VERSION}
    rm -f ${PARENT_TOMCAT_HOME}/apache-tomcat-${TOMCAT_VERSION}.tar.gz
}

######################################################################

# install_from_online
install_from_storage
