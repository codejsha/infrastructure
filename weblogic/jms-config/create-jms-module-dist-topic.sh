#!/usr/bin/bash

source ./env-base.sh

JMSMODULE_NAME="${1}"
DISTTOPIC_NAME="${2}"
DISTTOPIC_JNDI="${3}"
SUBDEPLOY_NAME="${4}"
SUBDEPLOY_TARGET="${5}"

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [ "${MAJOR_RELEASE}" == "11g" ]; then
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh create_jms_module_dist_topic.py
elif [ "${MAJOR_RELEASE}" == "12c" ] && [ "${MAJOR_RELEASE}" == "14c" ]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh create_jms_module_dist_topic.py
fi
