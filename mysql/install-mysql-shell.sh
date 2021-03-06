#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

### requirement: mysql yum repository

INSTALL_FILE_DIR="/mnt/share/oracle-mysql"
INSTALL_FILE="mysql80-community-release-el7-3.noarch.rpm"
# INSTALL_FILE="mysql80-community-release-el8-1.noarch.rpm"
# INSTALL_FILE="mysql-apt-config_0.8.16-1_all.deb"

######################################################################

function install_mysql_shell_with_dnf {
    sudo rpm -ivh ${INSTALL_FILE_DIR}/${INSTALL_FILE}
    sudo dnf install mysql-shell
}

function install_mysql_shell_with_yum {
    sudo rpm -ivh ${INSTALL_FILE_DIR}/${INSTALL_FILE}
    sudo yum install mysql-shell
}

function install_mysql_shell_with_apt {
    sudo rpm -ivh ${INSTALL_FILE_DIR}/${INSTALL_FILE}
    sudo apt-get install mysql-shell
}

######################################################################

install_mysql_shell_with_dnf
# install_mysql_shell_with_yum
# install_mysql_shell_with_apt
