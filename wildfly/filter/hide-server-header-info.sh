#!/usr/bin/bash

source ../env-base.sh

######################################################################

function add_filter {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=undertow/configuration=filter/response-header=server-header:add(header-name=Server,header-value=WildFly)
/subsystem=undertow/server=default-server/host=default-host/filter-ref=server-header:add()
run-batch
quit
EOF
}

######################################################################

add_filter