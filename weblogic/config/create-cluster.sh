#!/bin/bash

source ./env-base.sh

export CLUSTER_NAME="${1}"
export TRANSMISSION="${2}"             # unicast/multicast (possible: unicast, multicast)
export MULTICAST_LISTEN_ADDRESS="${3}" # optional (only multicast)
export MULTICAST_LISTEN_PORT="${4}"    # optional (only multicast)

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [ "${MAJOR_VERSION}" == "11g" ]; then
  ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh create_cluster.py
elif [ "${MAJOR_VERSION}" == "12c" ] || [ "${MAJOR_VERSION}" == "14c" ]; then
  ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh create_cluster.py
fi
