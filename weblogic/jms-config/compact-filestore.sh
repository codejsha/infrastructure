#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh

export FILESTORE_DIR="${1}"
export TEMP_DIR="${2}"

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh compact_filestore.py
elif [[ ${WEBLOGIC_VERSION} =~ ^12.|^14.1 ]]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh compact_filestore.py
fi
