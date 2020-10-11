#!/usr/bin/bash

source ./env-base.sh

FILESTORE_NAME="${1}"
FILESTORE_DIR="${2}"
FILESTORE_TARGET="${3}"

######################################################################

mkdir -p ${FILESTORE_DIR}

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [ "${MAJOR_RELEASE}" == "11g" ]; then
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh create_filestore.py
elif [ "${MAJOR_RELEASE}" == "12c" ] && [ "${MAJOR_RELEASE}" == "14c" ]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh create_filestore.py
fi
