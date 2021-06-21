#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

APP_PATH="${1}"
DD_DIR="dd"

mkdir -p ${DD_DIR}

######################################################################

function convert_deployment_descriptor {
    ${JAVA_HOME}/bin/java \
        -cp ${WL_HOME}/server/lib/weblogic.jar weblogic.DDConverter \
        -d ${DD_DIR} \
        ${APP_PATH}
}

######################################################################

convert_deployment_descriptor
