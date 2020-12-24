#!/bin/bash

source ./env-base.sh

COMPRESS_CONTENT_TYPE="${COMPRESS_CONTENT_TYPE}, text/html"
COMPRESS_CONTENT_TYPE="${COMPRESS_CONTENT_TYPE}, text/xml"
COMPRESS_CONTENT_TYPE="${COMPRESS_CONTENT_TYPE}, text/plain"
export COMPRESS_CONTENT_TYPE

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [ "${MAJOR_VERSION}" == "11g" ]; then
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh set_domain_output_compression.py
elif [ "${MAJOR_VERSION}" == "12c" ] || [ "${MAJOR_VERSION}" == "14c" ]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh set_domain_output_compression.py
fi
