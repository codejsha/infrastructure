#!/usr/bin/bash

source ./env-base.sh

DATASOURCE_NAME="${1}"

######################################################################

function test_connection_pool {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/subsystem=datasources/data-source=${DATASOURCE_NAME}:test-connection-in-pool"
}

######################################################################

test_connection_pool
