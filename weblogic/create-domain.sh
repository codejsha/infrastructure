#!/usr/bin/bash

ORACLE_HOME="/usr/local/weblogic"
INSTALL_SCRIPT_DIR="/svc/infrastructure/weblogic"

######################################################################

MW_HOME=${ORACLE_HOME}
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
