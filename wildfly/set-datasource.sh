#!/usr/bin/bash

source ./env-base.sh
source ./env-datasource.sh

######################################################################

function set_datasource {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --commands=\
<<EOF
            batch
            /subsystem=datasources/data-source=${DATASOURCE_NAME}\
                :write-attribute(name=jndi-name, value=${JNDI_NAME}), \
            /subsystem=datasources/data-source=${DATASOURCE_NAME}\
                :write-attribute(name=enabled, value=${ENABLED}), \
            /subsystem=datasources/data-source=${DATASOURCE_NAME}\
                :write-attribute(name=connection-url, value=${CONNECTION_URL}), \
            /subsystem=datasources/data-source=${DATASOURCE_NAME}\
                :write-attribute(name=driver-name, value=${DRIVER_NAME}), \
            /subsystem=datasources/data-source=${DATASOURCE_NAME}\
                :write-attribute(name=min-pool-size, value=${MIN_POOL_SIZE}), \
            /subsystem=datasources/data-source=${DATASOURCE_NAME}\
                :write-attribute(name=max-pool-size, value=${MAX_POOL_SIZE}), \
            /subsystem=datasources/data-source=${DATASOURCE_NAME}\
                :write-attribute(name=user-name, value=${USERNAME}), \
            /subsystem=datasources/data-source=${DATASOURCE_NAME}\
                :write-attribute(name=password, value=${PASSWORD})
            run-batch
EOF
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

set_datasource
reload_server
test_connection_pool
