#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

LOG_FORMAT="%h %l %u %t &quot;%r&quot; %s %b &quot;%{i,Referer}&quot; &quot;%{i,User-Agent}&quot; Cookie: &quot;%{i,COOKIE}&quot; Set-Cookie: &quot;%{o,SET-COOKIE}&quot; SessionID: %S Thread: &quot;%I&quot; TimeTaken: %T"

######################################################################

function set_access_log {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/subsystem=undertow/server=default-server/host=default-host/setting=access-log:write-attribute(name=prefix,value=access.)
/subsystem=undertow/server=default-server/host=default-host/setting=access-log:write-attribute(name=pattern,value="${LOG_FORMAT}")
/subsystem=undertow/server=default-server/host=default-host/setting=access-log:write-attribute(name=directory,value=.)
/subsystem=undertow/server=default-server/host=default-host/setting=access-log:write-attribute(name=relative-to,value=jboss.server.log.dir)
# /subsystem=undertow/server=default-server/host=default-host/setting=access-log:write-attribute(name=use-server-log,value=true)
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

set_access_log
reload_server
