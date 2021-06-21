#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh
source ./env-jdbc-driver.sh

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
