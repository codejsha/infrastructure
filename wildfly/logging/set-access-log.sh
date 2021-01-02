#!/bin/bash

source ./env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

LOG_FORMAT="%h %l %u %t %r %s %b %{Referer}i %{User-Agent}i Cookie: %{COOKIE}i Set-Cookie: %{SET-COOKIE}o SessionID: %S Thread: %I TimeTaken: %T"

######################################################################

function set_access_log {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=undertow/server=default-server/host=default-host/setting=access-log:write-attribute(name=prefix,value=access.)
/subsystem=undertow/server=default-server/host=default-host/setting=access-log:write-attribute(name=pattern,value="${LOG_FORMAT}")
/subsystem=undertow/server=default-server/host=default-host/setting=access-log:write-attribute(name=relative-to,value=jboss.server.log.dir)
/subsystem=undertow/server=default-server/host=default-host/setting=access-log:write-attribute(name=use-server-log,value=true)
run-batch
quit
EOF
}

function remove_access_log {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=undertow/server=default-server/host=default-host/setting=access-log:remove()
run-batch
quit
EOF
}

######################################################################

set_access_log
# remove_access_log
