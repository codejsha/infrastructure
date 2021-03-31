#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh

COMPRESS_CONTENT_TYPE="${COMPRESS_CONTENT_TYPE}, text/html"
COMPRESS_CONTENT_TYPE="${COMPRESS_CONTENT_TYPE}, text/xml"
COMPRESS_CONTENT_TYPE="${COMPRESS_CONTENT_TYPE}, text/plain"
export COMPRESS_CONTENT_TYPE

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [[ ${WEBLOGIC_VERSION} =~ ^14.1|^12.2 ]]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh set_domain_output_compression.py
elif [[ ${WEBLOGIC_VERSION} =~ ^12.1 ]]; then
    echo "[INFO] Not available in this version."
elif [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
    echo "[INFO] Not available in this version."
fi
