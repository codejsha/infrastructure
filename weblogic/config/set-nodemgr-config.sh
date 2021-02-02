#!/bin/bash

source ./env-base.sh

export NODEMGR_NAME="${1}"
export NODEMGR_LISTEN_ADDRESS="${2}"
export NODEMGR_LISTEN_PORT="${3}"

######################################################################

mkdir -p ${LOG_DIR}/nodemanager

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh set_nodemgr_config.py
elif [[ ${WEBLOGIC_VERSION} =~ ^12.|^14.1 ]]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh set_nodemgr_config.py
fi