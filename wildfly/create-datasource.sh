#!/usr/bin/bash

source ./env-base.sh
source ./env-datasource.sh

######################################################################

function add_datasource {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/subsystem=datasources/data-source=${DATASOURCE_NAME}\
            :add(\
            jndi-name=${JNDI_NAME}, \
            enabled=${ENABLED}, \
            connection-url=${CONNECTION_URL}, \
            driver-name=${DRIVER_NAME}, \
            min-pool-size=${MIN_POOL_SIZE}, \
            max-pool-size=${MAX_POOL_SIZE}, \
            user-name=${USERNAME}, \
            password=${PASSWORD})"
}

function reload_server {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command=":reload(use-current-server-config=false)"
}

function test_connection_pool {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/subsystem=datasources/data-source=${DATASOURCE_NAME}:test-connection-in-pool"
}

######################################################################

add_datasource
reload_server
test_connection_pool
