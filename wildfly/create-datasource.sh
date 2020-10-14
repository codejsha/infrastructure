#!/usr/bin/bash

source ./env-base.sh

DATASOURCE_NAME="baseds1"
DRIVER_NAME="oracle"

JNDI_NAME="java:/base/ds1"
ENABLED="true"
CONNECTION_URL="jdbc:oracle:thin:@192.168.137.150:1521:orclcdb"
MIN_POOL_SIZE="10"
MAX_POOL_SIZE="10"
USERNAME="system"
PASSWORD="\${VAULT::datasource::password::1}"

######################################################################

function create_datasource {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/subsystem=datasources/data-source=${DATASOURCE_NAME}:add(\
            jndi-name=${JNDI_NAME},\
            enabled=${ENABLED},\
            connection-url=${CONNECTION_URL},\
            driver-name=${DRIVER_NAME},\
            min-pool-size=${MIN_POOL_SIZE},\
            max-pool-size=${MAX_POOL_SIZE},\
            user-name=${USERNAME},\
            password=${PASSWORD})"
}

function reload {
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

create_datasource
reload
test_connection_pool
