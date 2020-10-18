#!/usr/bin/bash

source ./env-base.sh

APP_NAME="${1}"
APP_PATH="${2}"
APP_TARGET="${3}"

######################################################################

if [ ! -d "${APP_PATH}" ] && [ ! -f "${APP_PATH}" ] ; then
    echo "ERROR: The APP_PATH (${JAVA_HOME}) does not exist!"
    exit
fi

######################################################################

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
if [ "${MAJOR_VERSION}" == "11g" ]; then
    ${MW_HOME}/wlserver_10.3/common/bin/wlst.sh deploy_app.py
elif [ "${MAJOR_VERSION}" == "12c" ] || [ "${MAJOR_VERSION}" == "14c" ]; then
    ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh deploy_app.py
fi
