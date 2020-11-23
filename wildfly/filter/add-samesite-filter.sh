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
/subsystem=undertow/configuration=filter/expression-filter=samesite-cookie:add(expression="samesite-cookie(mode=none)")
/subsystem=undertow/server=default-server/host=default-host/filter-ref=samesite-cookie:add()
run-batch
quit
EOF
}

######################################################################

add_filter
