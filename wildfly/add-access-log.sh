#!/usr/bin/bash

source ./env-base.sh

LOG_FORMAT="%h %l %u %t %r %s %b %{Referer}i %{User-Agent}i Cookie: %{COOKIE}i Set-Cookie: %{SET-COOKIE}o SessionID: %S Thread: %I TimeTaken: %T"

######################################################################

function add_access_log {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/subsystem=undertow/server=default-server/host=default-host/setting=access-log\
            :add(\
            pattern=\"${LOG_FORMAT}\", \
            relative-to=jboss.server.log.dir, \
            prefix=access., \
            use-server-log=true)"
}

######################################################################

add_access_log
