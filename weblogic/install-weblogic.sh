#!/usr/bin/bash

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
        -invPtrLoc ${INSTALL_SCRIPT_DIR}/oraInst.loc \
        -jreLoc ${JAVA_HOME} \
        -ignoreSysPrereqs \
        -force \
        -novalidation
}

# install_weblogic_11g
install_weblogic
