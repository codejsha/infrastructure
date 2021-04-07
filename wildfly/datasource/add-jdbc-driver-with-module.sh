#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh
source ./env-jdbc-driver.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"
USERNAME="${USERNAME}"
PASSWORD="${PASSWORD}"

DRIVER_CLASS_NAME="${DRIVER_CLASS_NAME}"

DRIVER_NAME="${DRIVER_NAME}"
MODULE_NAME="${MODULE_NAME}"

######################################################################

function add_jdbc_driver_with_module {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/subsystem=datasources/jdbc-driver=${DRIVER_NAME}\
    :add(\
    driver-name=${DRIVER_NAME},\
    driver-module-name=${MODULE_NAME},\
    driver-xa-datasource-class-name=${DRIVER_CLASS_NAME})
run-batch
quit
EOF
}

######################################################################

add_jdbc_driver_with_module
