#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

export DS_NAME="${1}"
export DS_JNDI="${2}"
export DS_URL="${3}"
export DS_DRIVER="${4}"
export DS_USERNAME="${5}"
export DS_PASSWORD="${6}"
export DS_INIT="${7}"
export DS_MIN="${8}"
export DS_MAX="${9}"
export DS_TARGET_TYPE="${10}"
export DS_TARGET="${11}"

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [[ ${WEBLOGIC_VERSION} =~ ^14.1|^12. ]]; then
  ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh set_datasource_config.py
elif [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
  ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh set_datasource_config.py
fi
