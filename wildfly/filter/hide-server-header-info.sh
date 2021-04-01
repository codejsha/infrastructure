#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh

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
/subsystem=undertow/configuration=filter/response-header=x-powered-by-header:add(header-name=X-Powered-By,header-value=Undertow/1)
/subsystem=undertow/server=default-server/host=default-host/filter-ref=x-powered-by-header:add()

/subsystem=undertow/configuration=filter/response-header=server-header:add(header-name=Server,header-value=WildFly)
/subsystem=undertow/server=default-server/host=default-host/filter-ref=server-header:add()
run-batch
quit
EOF
}

######################################################################

add_filter
