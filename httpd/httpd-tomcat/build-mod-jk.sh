#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

HTTPD_HOME="/usr/local/httpd"

INSTALL_FILE_DIR="/mnt/share/apache-tomcat"
INSTALL_FILE="tomcat-connectors-1.2.48-src.tar.gz"
INSTALL_SCRIPT_DIR="/svc/infrastructure/tomcat"

######################################################################

TOMCAT_CONNECTOR_DIR="$(echo ${INSTALL_FILE} | grep -o -E "(.*[^\.tar\.gz])")"

######################################################################

function install_required_package {
    sudo yum install -y libtool automake autoconf
}

function extract_install_file {
    /bin/cp -f ${INSTALL_FILE_DIR}/${INSTALL_FILE} ${INSTALL_SCRIPT_DIR}/httpd-tomcat
    cd ${INSTALL_SCRIPT_DIR}/httpd-tomcat
    tar -xzf ${INSTALL_FILE}
}

function build_mod_jk {
    cd ${INSTALL_SCRIPT_DIR}/httpd-tomcat/${TOMCAT_CONNECTOR_DIR}/native
    ./configure --with-apxs=${HTTPD_HOME}/bin/apxs
}

function install_mod_jk {
    make
    libtool --finish ${HTTPD_HOME}/modules
    make install
}

function delete_install_file {
    rm -f ${INSTALL_SCRIPT_DIR}/httpd-tomcat/${INSTALL_FILE}
    rm -rf ${INSTALL_SCRIPT_DIR}/httpd-tomcat/${TOMCAT_CONNECTOR_DIR}
}

######################################################################

install_required_package
extract_install_file
build_mod_jk
install_mod_jk
# delete_install_file
