#!/bin/bash

### requirement: mysql yum repository

INSTALL_FILE_DIR="/mnt/share/oracle-mysql"
INSTALL_FILE="mysql80-community-release-el7-3.noarch.rpm"
# INSTALL_FILE="mysql80-community-release-el8-1.noarch.rpm"
# INSTALL_FILE="mysql-apt-config_0.8.16-1_all.deb"

######################################################################

function install_mysql_cli_with_yum {
    sudo rpm -ivh ${INSTALL_FILE_DIR}/${INSTALL_FILE}
    sudo yum install mysql-shell
}

function install_mysql_cli_with_dnf {
    sudo rpm -ivh ${INSTALL_FILE_DIR}/${INSTALL_FILE}
    sudo dnf install mysql-shell
}

function install_mysql_cli_with_apt {
    sudo rpm -ivh ${INSTALL_FILE_DIR}/${INSTALL_FILE}
    sudo apt-get install mysql-shell
}

######################################################################

install_mysql_cli_with_yum
# install_mysql_cli_with_dnf
# install_mysql_cli_with_apt
