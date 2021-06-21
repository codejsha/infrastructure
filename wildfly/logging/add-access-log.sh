#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

LOG_FORMAT="%h %l %u %t %r %s %b %{Referer}i %{User-Agent}i Cookie: %{COOKIE}i Set-Cookie: %{SET-COOKIE}o SessionID: %S Thread: %I TimeTaken: %T"

######################################################################

function add_access_log {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/subsystem=undertow/server=default-server/host=default-host/setting=access-log\
    :add(pattern="${LOG_FORMAT}",relative-to=jboss.server.log.dir,prefix=access.,use-server-log=true)
run-batch
quit
EOF
}

######################################################################

add_access_log
