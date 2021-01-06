#!/bin/bash

INSTALL_FILE_DIR="/mnt/share/oracle-http-server/ohs11.1.1.9/p20995453_111190_Linux-x86-64"
INSTALL_FILE="Disk1/runInstaller"
INSTALL_SCRIPT_DIR="/svc/infrastructure/ohs"
RESPONSE_FILE="response-sw-only-11g.rsp"
INVENTORY_FILE="oraInst.loc"

######################################################################

function install_required_packages {
    sudo yum install -y \
        binutils \
        compat-libcap1 \
        compat-libstdc++-33 \
        libgcc \
        libstdc++ \
        libstdc++-devel \
        sysstat \
        gcc \
        gcc-c++ \
        ksh \
        make \
        glibc \
        glibc-devel \
        libaio \
        libaio-devel
}

function upgrade_ohs {
    ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
        -silent \
        -responseFile ${INSTALL_SCRIPT_DIR}/${RESPONSE_FILE} \
        -invPtrLoc ${INSTALL_SCRIPT_DIR}/${INVENTORY_FILE}
}

######################################################################

install_required_packages
upgrade_ohs
