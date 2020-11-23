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
/subsystem=undertow/configuration=filter/expression-filter=stuck:add(expression="blocking; stuck-thread-detector(600)")
/subsystem=undertow/server=default-server/host=default-host/filter-ref=stuck:add()
run-batch
quit
EOF
}

######################################################################

add_filter
