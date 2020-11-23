#!/usr/bin/bash

source ../env-base.sh
source ./env-tcpping.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

INSTANCE_NAME1="${INSTANCE_NAME1}"
INSTANCE_NAME2="${INSTANCE_NAME2}"
BIND_ADDRESS1="${BIND_ADDRESS1}"
BIND_ADDRESS2="${BIND_ADDRESS2}"
JGROUPS_TCP_PORT1="${JGROUPS_TCP_PORT1}"
JGROUPS_TCP_PORT2="${JGROUPS_TCP_PORT2}"
TCPPING_SOCKET_BINDINGS="${TCPPING_SOCKET_BINDINGS}"
JGROUPS_TCP_PORT="${JGROUPS_TCP_PORT}"

######################################################################

function reset_tcp_stack {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=jgroups/stack=tcp:remove()
/subsystem=jgroups/stack=tcp:add(transport={type=TCP,socket-binding=jgroups-tcp})
/subsystem=jgroups/stack=tcp/protocol=TCPPING:add(socket-bindings=[${TCPPING_SOCKET_BINDINGS}])
/subsystem=jgroups/stack=tcp:add-protocol(type=MERGE3)
/subsystem=jgroups/stack=tcp:add-protocol(type=FD_SOCK,socket-binding=jgroups-tcp-fd)
/subsystem=jgroups/stack=tcp:add-protocol(type=FD_ALL)
/subsystem=jgroups/stack=tcp:add-protocol(type=VERIFY_SUSPECT)
/subsystem=jgroups/stack=tcp:add-protocol(type=pbcast.NAKACK2)
/subsystem=jgroups/stack=tcp:add-protocol(type=UNICAST3)
/subsystem=jgroups/stack=tcp:add-protocol(type=pbcast.STABLE)
/subsystem=jgroups/stack=tcp:add-protocol(type=pbcast.GMS)
/subsystem=jgroups/stack=tcp:add-protocol(type=MFC)
/subsystem=jgroups/stack=tcp:add-protocol(type=FRAG3)
run-batch
quit
EOF
}

function add_outbound_socket_binding {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${INSTANCE_NAME1}:add(host=${BIND_ADDRESS1},port=${JGROUPS_TCP_PORT1})
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${INSTANCE_NAME2}:add(host=${BIND_ADDRESS2},port=${JGROUPS_TCP_PORT2})
run-batch
quit
EOF
}

function set_standard_sockets {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/socket-binding-group=standard-sockets/socket-binding=jgroups-tcp:write-attribute(name=port,value=${JGROUPS_TCP_PORT})
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${INSTANCE_NAME1}:write-attribute(name=host,value=${BIND_ADDRESS1})
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${INSTANCE_NAME2}:write-attribute(name=host,value=${BIND_ADDRESS2})
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${INSTANCE_NAME1}:write-attribute(name=port,value=${JGROUPS_TCP_PORT1})
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${INSTANCE_NAME2}:write-attribute(name=port,value=${JGROUPS_TCP_PORT2})
run-batch
quit
EOF
}

function set_tcp_clustering {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=jgroups/channel=ee:write-attribute(name=stack,value=tcp)
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

reset_tcp_stack
add_outbound_socket_binding
set_standard_sockets
set_tcp_clustering
reload_server
