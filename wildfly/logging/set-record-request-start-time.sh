#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

######################################################################

function set_record_request_start_time {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/subsystem=undertow/server=default-server/http-listener=default:write-attribute(name=record-request-start-time,value=true)
/subsystem=undertow/server=default-server/https-listener=https:write-attribute(name=record-request-start-time,value=true)
/subsystem=undertow/server=default-server/ajp-listener=ajp:write-attribute(name=record-request-start-time,value=true)
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

######################################################################

set_record_request_start_time
reload_server
