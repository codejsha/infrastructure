#!/bin/bash

source ./env-base.sh

export JMSMODULE_NAME="${1}"
export JMSMODULE_TARGET_TYPE="${2}"
export JMSMODULE_TARGET="${3}"

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh create_jms_module.py
elif [[ ${WEBLOGIC_VERSION} =~ ^12.|^14.1 ]]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh create_jms_module.py
fi
