#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh
source ./env-jdbc-driver.sh
source ./env-datasource.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"
USERNAME="${USERNAME}"
PASSWORD="${PASSWORD}"

DRIVER_NAME="${DRIVER_NAME}"

DATASOURCE_NAME="${DATASOURCE_NAME}"
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

function add_datasource {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/subsystem=datasources/data-source=${DATASOURCE_NAME}\
    :add(jndi-name=${JNDI_NAME},\
        enabled=${ENABLED},\
        connection-url=${CONNECTION_URL},\
        driver-name=${DRIVER_NAME},\
        initial-pool-size=${INITIAL_POOL_SIZE},\
        min-pool-size=${MIN_POOL_SIZE},\
        max-pool-size=${MAX_POOL_SIZE},\
        user-name=${USERNAME},\
        password=${PASSWORD},\
        check-valid-connection-sql="${CHECK_VALID_CONNECTION_SQL}",\
        background-validation=${BACKGROUND_VALIDATION},\
        background-validation-millis=${BACKGROUND_VALIDATION_MILLIS},\
        blocking-timeout-wait-millis=${BLOCKING_TIMEOUT_WAIT_MILLIS},\
        query-timeout=${QUERY_TIMEOUT},\
        track-statements=${TRACK_STATEMENTS},\
        pool-prefill="${POOL_PREFILL}",\
        pool-use-strict-min="${POOL_USE_STRICT_MIN}",\
        prepared-statements-cache-size=${PREPARED_STATEMENTS_CACHE_SIZE},\
        share-prepared-statements=${SHARE_PREPARED_STATEMENTS},\
        use-ccm="${USE_CCM}")
run-batch
quit
EOF
}

function reload_server {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
        --echo-command \
        --command=":reload()"
}

function test_connection_pool {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
        --echo-command \
        --command="/subsystem=datasources/data-source=${DATASOURCE_NAME}:test-connection-in-pool()"
}

######################################################################

add_datasource
reload_server
test_connection_pool
