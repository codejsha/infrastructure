#!/bia/bash

source ./env-base.sh

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
