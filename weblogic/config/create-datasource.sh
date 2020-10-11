#!/usr/bin/bash

source ./env-base.sh

export DS_NAME="${1}"
export DS_JNDI="${2}"
export DS_URL="${3}"
export DS_DRIVER="${4}"
export DS_USER="${5}"
export DS_PASSWORD="${6}"
export DS_INIT="${7}"
export DS_MIN="${8}"
export DS_MAX="${9}"
export DS_TARGET_TYPE="${10}"
export DS_TARGET="${11}"

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [ "${MAJOR_VERSION}" == "11g" ]; then
  ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh create_cluster.py
elif [ "${MAJOR_VERSION}" == "12c" ] && [ "${MAJOR_VERSION}" == "14c" ]; then
  ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh create_cluster.py
fi
