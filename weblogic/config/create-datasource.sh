#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh

export DS_NAME="${1}"

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [[ ${WEBLOGIC_VERSION} =~ ^14.1|^12. ]]; then
  ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh create_datasource.py
elif [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
  ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh create_datasource.py
fi
