#!/usr/bin/bash

source ./env-base.sh

ORACLE_HOME="${ORACLE_HOME}"   # for 12g, 14c
MW_HOME="${MW_HOME}"           # for 11g

INSTALL_SCRIPT_DIR="${INSTALL_SCRIPT_DIR}"

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"

function weblogic_create_domain_11g {
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh ${INSTALL_SCRIPT_DIR}/create_domain_11g.py
}

function weblogic_create_domain_12cr1 {
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh ${INSTALL_SCRIPT_DIR}/create_domain_12cr1.py
}

function weblogic_create_domain {
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh ${INSTALL_SCRIPT_DIR}/create_domain.py
}

######################################################################

# weblogic_create_domain_11g
# weblogic_create_domain_12cr1
weblogic_create_domain
