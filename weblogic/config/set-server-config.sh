#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh
source ./env-server.sh

export MANAGED_SERVER_NAME="${1}"
export MANAGED_SERVER_LISTEN_ADDRESS="${2}"
export MANAGED_SERVER_LISTEN_PORT="${3}"
export CLUSTER_NAME="${4}"
export NODEMGR_NAME="${5}"

export SERVER_START_JAVA_VENDOR="${SERVER_START_JAVA_VENDOR}"
export SERVER_START_ROOT_DIR="${SERVER_START_ROOT_DIR}"
export SERVER_START_ARGUMENTS="${SERVER_START_ARGUMENTS}"
export SERVER_START_CLASSPATH="${SERVER_START_CLASSPATH}"

######################################################################

mkdir -p ${LOG_DIR}/${MANAGED_SERVER_NAME}

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh set_server_config.py
elif [[ ${WEBLOGIC_VERSION} =~ ^12.|^14.1 ]]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh set_server_config.py
fi
