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
            initial-pool-size=${INITIAL_POOL_SIZE}, \
            min-pool-size=${MIN_POOL_SIZE}, \
            max-pool-size=${MAX_POOL_SIZE}, \
            user-name=${USERNAME}, \
            password=${PASSWORD}, \
            check-valid-connection-sql=\"${CHECK_VALID_CONNECTION_SQL}\", \
            background-validation=${BACKGROUND_VALIDATION}, \
            background-validation-millis=${BACKGROUND_VALIDATION_MILLIS}, \
            blocking-timeout-wait-millis=${BLOCKING_TIMEOUT_WAIT_MILLIS}, \
            query-timeout=${QUERY_TIMEOUT}, \
            track-statements=${TRACK_STATEMENTS}, \
            prepared-statements-cache-size=${PREPARED_STATEMENTS_CACHE_SIZE}, \
            share-prepared-statements=${SHARE_PREPARED_STATEMENTS})"
}

function reload_server {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command=":reload"
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
