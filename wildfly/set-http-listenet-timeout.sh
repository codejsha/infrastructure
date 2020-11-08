#!/usr/bin/bash

source ./env-base.sh

######################################################################

function set_listener_timeout {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
 /subsystem/undertow/server=default-server/http-listener=default:write-attribute(name=no-request-timeout,value=60000)
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

######################################################################

set_listener_timeout
reload_server