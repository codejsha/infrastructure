#!/bin/bash

source ./env-base.sh

export APP_NAME="${1}"
export APP_PATH="${2}"
export APP_TARGET="${3}"

######################################################################

if [ ! -d "${APP_PATH}" ] && [ ! -f "${APP_PATH}" ] ; then
    echo "[ERROR] The APP_PATH (${APP_PATH}) does not exist!"
    exit
fi

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh deploy_app.py
elif [[ ${WEBLOGIC_VERSION} =~ ^12.|^14.1 ]]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh deploy_app.py
fi
