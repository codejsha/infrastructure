#!/usr/bin/bash

source ../env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

######################################################################

function add_filter {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
# /subsystem=undertow/configuration=filter/custom-filter=example-handler:add(class-name=com.example.ExampleHandler,module=com.example.undertow.handler)
# /subsystem=undertow/server=default-server/host=default-host/filter-ref=example-handler:add()
run-batch
quit
EOF
}

######################################################################

add_filter
