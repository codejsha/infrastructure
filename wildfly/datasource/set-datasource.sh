#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh
source ./env-jdbc-driver.sh
source ./env-datasource.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

DATASOURCE_NAME="${DATASOURCE_NAME}"
DRIVER_NAME="${DRIVER_NAME}"
JNDI_NAME="${JNDI_NAME}"
ENABLED="${ENABLED}"
CONNECTION_URL="${CONNECTION_URL}"
INITIAL_POOL_SIZE="${INITIAL_POOL_SIZE}"
MIN_POOL_SIZE="${MIN_POOL_SIZE}"
MAX_POOL_SIZE="${MAX_POOL_SIZE}"
USERNAME="${USERNAME}"
PASSWORD="${PASSWORD}"
CHECK_VALID_CONNECTION_SQL="${CHECK_VALID_CONNECTION_SQL}"
BACKGROUND_VALIDATION="${BACKGROUND_VALIDATION}"
BACKGROUND_VALIDATION_MILLIS="${BACKGROUND_VALIDATION_MILLIS}"
BLOCKING_TIMEOUT_WAIT_MILLIS="${BLOCKING_TIMEOUT_WAIT_MILLIS}"
QUERY_TIMEOUT="${QUERY_TIMEOUT}"
TRACK_STATEMENTS="${TRACK_STATEMENTS}"
POOL_PREFILL="${POOL_PREFILL}"
POOL_USE_STRICT_MIN="${POOL_USE_STRICT_MIN}"
PREPARED_STATEMENTS_CACHE_SIZE="${PREPARED_STATEMENTS_CACHE_SIZE}"
SHARE_PREPARED_STATEMENTS="${SHARE_PREPARED_STATEMENTS}"
USE_CCM="${USE_CCM}"

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
        --echo-command \
        --command=":reload()"
}

function test_connection_pool {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --echo-command \
        --command="/subsystem=datasources/data-source=${DATASOURCE_NAME}:test-connection-in-pool()"
}

######################################################################

set_datasource
reload_server
test_connection_pool
