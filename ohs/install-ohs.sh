#!/usr/bin/bash

# INSTALL_FILE_DIR="/mnt/share/oracle-http-server/ohs11.1.1.9/ofm_webtier_linux_11.1.1.9.0_64_disk1_1of1"
# INSTALL_FILE_DIR="/mnt/share/oracle-http-server/ohs12.1.3/fmw_12.1.3.0.0_ohs_linux64"
# INSTALL_FILE_DIR="/mnt/share/oracle-http-server/ohs12.2.1.3/fmw_12.2.1.3.0_ohs_linux64_Disk1_1of1"
INSTALL_FILE_DIR="/mnt/share/oracle-http-server/ohs12.2.1.4/fmw_12.2.1.4.0_ohs_linux64_Disk1_1of1"

# INSTALL_FILE="Disk1/runInstaller"
# INSTALL_FILE="fmw_12.1.3.0.0_ohs_linux64.bin"
# INSTALL_FILE="fmw_12.2.1.3.0_ohs_linux64.bin"
INSTALL_FILE="fmw_12.2.1.4.0_ohs_linux64.bin"

# RESPONSE_FILE="response-sw-only-11g.rsp"
RESPONSE_FILE="response-sw-only.rsp"

INSTALL_SCRIPT_DIR="/svc/infrastructure/ohs"

######################################################################

function install_prerequisite_packages {
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

function install_ohs {
    ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
        -silent \
        -responseFile ${INSTALL_SCRIPT_DIR}/${RESPONSE_FILE} \
        -invPtrLoc ${INSTALL_SCRIPT_DIR}/oraInst.loc
}

######################################################################

install_prerequisite_packages
install_ohs
