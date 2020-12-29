#!/bin/bash

# INSTALL_FILE_DIR="/mnt/share/oracle-http-server/ohs11.1.1.9/ofm_webtier_linux_11.1.1.9.0_64_disk1_1of1"
# INSTALL_FILE_DIR="/mnt/share/oracle-http-server/ohs12.1.3/fmw_12.1.3.0.0_ohs_linux64"
# INSTALL_FILE_DIR="/mnt/share/oracle-http-server/ohs12.2.1.3/fmw_12.2.1.3.0_ohs_linux64_Disk1_1of1"
INSTALL_FILE_DIR="/mnt/share/oracle-http-server/ohs12.2.1.4/fmw_12.2.1.4.0_ohs_linux64_Disk1_1of1"

# INSTALL_FILE="Disk1/runInstaller"
# INSTALL_FILE="fmw_12.1.3.0.0_ohs_linux64.bin"
# INSTALL_FILE="fmw_12.2.1.3.0_ohs_linux64.bin"
INSTALL_FILE="fmw_12.2.1.4.0_ohs_linux64.bin"

INSTALL_SCRIPT_DIR="/svc/infrastructure/ohs"

# RESPONSE_FILE="response-sw-only-11g.rsp"
RESPONSE_FILE="response-sw-only.rsp"

######################################################################

function install_required_packages_11g {
    sudo yum install -y binutils compat-libcap1 compat-libstdc++-33.x86_64 compat-libstdc++-33.i686 gcc gcc-c++ glibc.x86_64 glibc.i686 glibc-devel.x86_64 glibc-devel.i686 libaio.x86_64 libaio-devel.x86_64 libgcc.x86_64 libgcc.i686 libstdc++.x86_64 libstdc++.i686 libstdc++-devel.x86_64 ksh make sysstat numactl.x86_64 numactl-devel.x86_64 motif.x86_64 motif-devel.x86_64 redhat-lsb.x86_64 redhat-lsb-core.x86_64
}

function install_required_packages_14c_rhel8 {
    sudo yum install -y binutils gcc gcc-c++ glibc.x86_64 glibc-devel.x86_64 libaio.x86_64 libaio-devel.x86_64 libgcc.x86_64 libstdc++.x86_64 libstdc++-devel.x86_64 libnsl.x86_64 sysstat motif.x86_64 motif-devel.x86_64 redhat-lsb.x86_64 redhat-lsb-core.x86_64 openssl make
}

function install_required_packages_14c_rhel7 {
    sudo yum install -y binutils compat-libcap1 compat-libstdc++.x86_64 compat-libstdc++.i686 gcc gcc-c++ glibc.x86_64 glibc.i686 glibc-devel.x86_64 libaio.x86_64 libaio-devel.x86_64 libgcc.x86_64 libgcc.i686 libstdc++.x86_64 libstdc++.i686 libstdc++-devel.x86_64 dejavu-serif-fonts ksh make sysstat numactl.x86_64 numactl-devel.x86_64 motif.x86_64 motif-devel.x86_64 redhat-lsb.x86_64 redhat-lsb-core.x86_64 openssl
}

function install_required_packages_12c_rhel8 {
    sudo yum install -y binutils gcc gcc-c++ glibc.x86_64 glibc-devel.x86_64 libaio.x86_64 libaio-devel.x86_64 libgcc.x86_64 libstdc++.x86_64 libstdc++-devel.x86_64 libnsl.x86_64 sysstat motif.x86_64 motif-devel.x86_64 redhat-lsb.x86_64 redhat-lsb-core.x86_64 openssl make xorg-x11-utils
}

function install_required_packages_12c_rhel7 {
    sudo yum install -y binutils compat-libcap1 compat-libstdc++-33.x86_64 compat-libstdc++-33.i686 gcc gcc-c++ glibc.x86_64 glibc.i686 glibc-devel.x86_64 libaio.x86_64 libaio-devel.x86_64 libgcc.x86_64 libgcc.i686 libstdc++.x86_64 libstdc++.i686 libstdc++-devel.x86_64 dejavu-serif-fonts ksh make sysstat numactl.x86_64 numactl-devel.x86_64 motif.x86_64 motif-devel.x86_64 redhat-lsb.x86_64 redhat-lsb-core.x86_64 openssl xorg-x11-utils
}

function install_ohs {
    ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
        -silent \
        -responseFile ${INSTALL_SCRIPT_DIR}/${RESPONSE_FILE} \
        -invPtrLoc ${INSTALL_SCRIPT_DIR}/oraInst.loc
}

######################################################################

# install_required_packages_11g
# install_required_packages_14c_rhel8
# install_required_packages_14c_rhel7
# install_required_packages_12c_rhel8
install_required_packages_12c_rhel7

install_ohs
