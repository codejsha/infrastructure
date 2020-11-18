#!/usr/bin/bash

source ./env-base.sh

export JMSMODULE_NAME="${1}"
export SUBDEPLOY_NAME="${2}"
export SUBDEPLOY_TARGET="${3}"
export SUBDEPLOY_TARGET_TYPE="${4}"

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [ "${MAJOR_VERSION}" == "11g" ]; then
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh create_jms_module_subdeploy.py
elif [ "${MAJOR_VERSION}" == "12c" ] || [ "${MAJOR_VERSION}" == "14c" ]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh create_jms_module_subdeploy.py
fi
