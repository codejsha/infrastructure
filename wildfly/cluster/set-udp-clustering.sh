#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh

######################################################################

function set_udp_clustering {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/subsystem=jgroups/stack=udp:remove()
/subsystem=jgroups/stack=udp:add()
/subsystem=jgroups/stack=udp/transport=UDP:add(socket-binding=jgroups-udp)
/subsystem=jgroups/stack=udp/protocol=PING:add()
/subsystem=jgroups/stack=udp/protocol=MERGE3:add()
/subsystem=jgroups/stack=udp/protocol=FD_SOCK:add(socket-binding=jgroups-tcp-fd)
/subsystem=jgroups/stack=udp/protocol=FD_ALL:add()
/subsystem=jgroups/stack=udp/protocol=VERIFY_SUSPECT:add()
/subsystem=jgroups/stack=udp/protocol=pbcast.NAKACK2:add()
/subsystem=jgroups/stack=udp/protocol=UNICAST3:add()
/subsystem=jgroups/stack=udp/protocol=pbcast.STABLE:add()
/subsystem=jgroups/stack=udp/protocol=pbcast.GMS:add()
/subsystem=jgroups/stack=udp/protocol=UFC:add()
/subsystem=jgroups/stack=udp/protocol=MFC:add()
/subsystem=jgroups/stack=udp/protocol=FRAG3:add()
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

set_udp_clustering
reload_server
