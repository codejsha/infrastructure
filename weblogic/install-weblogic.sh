#!/bin/bash

# JAVA_HOME="/usr/java/java-1.7.0"
JAVA_HOME="/usr/java/java-1.8.0"
# JAVA_HOME="/usr/java/java-11"

# INSTALL_FILE_DIR="/mnt/share/oracle-weblogic-server/wls10.3.6"
# INSTALL_FILE_DIR="/mnt/share/oracle-weblogic-server/wls12.1.3"
# INSTALL_FILE_DIR="/mnt/share/oracle-weblogic-server/wls12.2.1.3/fmw_12.2.1.3.0_wls_Disk1_1of1"
INSTALL_FILE_DIR="/mnt/share/oracle-weblogic-server/wls12.2.1.4/fmw_12.2.1.4.0_wls_Disk1_1of1"
# INSTALL_FILE_DIR="/mnt/share/oracle-weblogic-server/wls14.1.1/fmw_14.1.1.0.0_wls_Disk1_1of1"

# INSTALL_FILE="wls1036_generic.jar"
# INSTALL_FILE="fmw_12.1.3.0.0_wls.jar"
# INSTALL_FILE="fmw_12.2.1.3.0_wls.jar"
INSTALL_FILE="fmw_12.2.1.4.0_wls.jar"
# INSTALL_FILE="fmw_14.1.1.0.0_wls.jar"

INSTALL_SCRIPT_DIR="/svc/infrastructure/weblogic"

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

function install_weblogic_11g {
    ${JAVA_HOME}/bin/java \
        -jar ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
        -mode=silent \
        -silent_xml=${INSTALL_SCRIPT_DIR}/silent.xml
}

function install_weblogic {
    ${JAVA_HOME}/bin/java \
        -Djava.security.egd=file:///dev/urandom \
        -jar ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
        -silent \
        -responseFile ${INSTALL_SCRIPT_DIR}/response.rsp \
        -invPtrLoc ${INSTALL_SCRIPT_DIR}/oraInst.loc

    # ${JAVA_HOME}/bin/java \
    #     -Djava.security.egd=file:///dev/urandom \
    #     -jar ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
    #     -silent \
    #     -responseFile ${INSTALL_SCRIPT_DIR}/response.rsp \
    #     -invPtrLoc ${INSTALL_SCRIPT_DIR}/oraInst.loc \
    #     -jreLoc ${JAVA_HOME} \
    #     -ignoreSysPrereqs \
    #     -force \
    #     -novalidation
}

######################################################################

# install_required_packages_11g
# install_required_packages_14c_rhel8
# install_required_packages_14c_rhel7
# install_required_packages_12c_rhel8
install_required_packages_12c_rhel7

# install_weblogic_11g
install_weblogic
