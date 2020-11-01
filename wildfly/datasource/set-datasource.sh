#!/usr/bin/bash

source ../env-base.sh
source ./env-datasource.sh

######################################################################

function set_datasource {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=jndi-name,value="${JNDI_NAME}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=enabled,value="${ENABLED}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=connection-url,value="${CONNECTION_URL}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=driver-name,value="${DRIVER_NAME}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=initial-pool-size,value="${INITIAL_POOL_SIZE}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=min-pool-size,value="${MIN_POOL_SIZE}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=max-pool-size,value="${MAX_POOL_SIZE}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=user-name,value="${USERNAME}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=password,value="${PASSWORD}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=check-valid-connection-sql,value="${CHECK_VALID_CONNECTION_SQL}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=background-validation,value="${BACKGROUND_VALIDATION}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=background-validation-millis,value="${BACKGROUND_VALIDATION_MILLIS}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=blocking-timeout-wait-millis,value="${BLOCKING_TIMEOUT_WAIT_MILLIS}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=query-timeout,value="${QUERY_TIMEOUT}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=track-statements,value="${TRACK_STATEMENTS}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=pool-prefill,value="${POOL_PREFILL}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=pool-use-strict-min,value="${POOL_USE_STRICT_MIN}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=prepared-statements-cache-size,value="${PREPARED_STATEMENTS_CACHE_SIZE}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=share-prepared-statements,value="${SHARE_PREPARED_STATEMENTS}")
/subsystem=datasources/data-source=${DATASOURCE_NAME}:write-attribute(name=use-ccm,value="${USE_CCM}")
run-batch
quit
EOF
}

function reload_server {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command=":reload()"
}

function test_connection_pool {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=datasources/data-source=${DATASOURCE_NAME}:test-connection-in-pool
run-batch
quit
EOF
}

######################################################################

set_datasource
reload_server
test_connection_pool
