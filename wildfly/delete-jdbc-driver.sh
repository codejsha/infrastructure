#!/usr/bin/bash

source ./env-base.sh

DRIVER_NAME="${1:-DRIVER_NAME}"

######################################################################

function remove_jdbc_driver {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/subsystem=datasources/jdbc-driver=${DRIVER_NAME}:remove"
}

######################################################################

remove_jdbc_driver
