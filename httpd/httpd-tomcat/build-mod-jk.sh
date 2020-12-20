#!/bin/bash

HTTPD_HOME="/usr/local/httpd"
JK_VERSION="1.2.48"

######################################################################

function install_required_packages {
    sudo yum install -y libtool automake autoconf
}

function extract_jk_archive_file {
    tar -xzf tomcat-connectors-${JK_VERSION}-src.tar.gz
}

function build_mod_jk {
    cd tomcat-connectors-${JK_VERSION}-src/native
    ./configure --with-apxs=${HTTPD_HOME}/bin/apxs
}

function install_mod_jk {
    make
    libtool --finish ${HTTPD_HOME}/modules
    make install
}

######################################################################

install_required_packages
extract_jk_archive_file
build_mod_jk
install_mod_jk
