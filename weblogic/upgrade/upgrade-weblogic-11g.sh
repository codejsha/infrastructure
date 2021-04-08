#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

JAVA_HOME="/usr/java/java-1.7.0"
INSTALL_FILE_DIR="/mnt/share/oracle-weblogic-server/wls10.3.6"
INSTALL_FILE="wls1036_upgrade_generic.jar"
SILENT_FILE="silent.xml"

INSTALL_SCRIPT_DIR="/svc/infrastructure/weblogic"

######################################################################

function install_required_package_11g {
    sudo yum install -y binutils compat-libcap1 compat-libstdc++-33.x86_64 compat-libstdc++-33.i686 gcc gcc-c++ glibc.x86_64 glibc.i686 glibc-devel.x86_64 glibc-devel.i686 libaio.x86_64 libaio-devel.x86_64 libgcc.x86_64 libgcc.i686 libstdc++.x86_64 libstdc++.i686 libstdc++-devel.x86_64 ksh make sysstat numactl.x86_64 numactl-devel.x86_64 motif.x86_64 motif-devel.x86_64 redhat-lsb.x86_64 redhat-lsb-core.x86_64
}

function upgrade_weblogic_11g {
    ${JAVA_HOME}/bin/java \
        -jar ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
        -mode=silent \
        -silent_xml=${INSTALL_SCRIPT_DIR}/${SILENT_FILE}
    # ${JAVA_HOME}/bin/java \
    #     -jar ${INSTALL_FILE_DIR}/${INSTALL_FILE} \
    #     -mode=silent \
    #     -silent_xml=${INSTALL_SCRIPT_DIR}/${SILENT_FILE} \
    #     -silent_priority=debug \
    #     -silent_log=upgrade-silent-install.log \
    #     -log_priority=debug \
    #     -log=upgrade-install.log
}

######################################################################

install_required_package_11g
upgrade_weblogic_11g
