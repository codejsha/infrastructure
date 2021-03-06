#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh
source ./env-jdbc-driver.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

DRIVER_FILE_DIR="${DRIVER_FILE_DIR}"
DRIVER_FILE="${DRIVER_FILE}"
DRIVER_NAME="${DRIVER_NAME}"
MODULE_NAME="${MODULE_NAME}"

######################################################################

function add_jdbc_module {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --echo-command \
        --command="module add --name=${MODULE_NAME} --resources=${DRIVER_FILE_DIR}/${DRIVER_FILE} --dependencies=javax.api,javax.transaction.api"
}

function add_jdbc_driver_with_module {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=datasources/jdbc-driver=${DRIVER_NAME}\
    :add(\
    driver-name=${DRIVER_NAME},\
    driver-module-name=${MODULE_NAME},\
    driver-xa-datasource-class-name=oracle.jdbc.xa.client.OracleXADataSource)
run-batch
quit
EOF
}

######################################################################

add_jdbc_module
add_jdbc_driver_with_module
