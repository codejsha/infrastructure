#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh
source ./env-jdbc-driver.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

DRIVER_FILE_DIR="${DRIVER_FILE_DIR}"
DRIVER_FILE="${DRIVER_FILE}"

MODULE_NAME="${MODULE_NAME}"

######################################################################

function add_jdbc_module {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --echo-command \
        --command="module add --name=${MODULE_NAME} --resources=${DRIVER_FILE_DIR}/${DRIVER_FILE} --dependencies=javax.api,javax.transaction.api"
}

######################################################################

add_jdbc_module
