#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh
source ./env-tcpping.sh

INSTANCE_NAME="${INSTANCE_NAME}"
JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"
USERNAME="${USERNAME}"
PASSWORD="${PASSWORD}"

CLUSTER_INSTANCE_NAME1="${CLUSTER_INSTANCE_NAME1}"
CLUSTER_INSTANCE_NAME2="${CLUSTER_INSTANCE_NAME2}"
CLUSTER_BIND_ADDRESS1="${CLUSTER_BIND_ADDRESS1}"
CLUSTER_BIND_ADDRESS2="${CLUSTER_BIND_ADDRESS2}"
CLUSTER_TCP_PORT1="${CLUSTER_TCP_PORT1}"
CLUSTER_TCP_PORT2="${CLUSTER_TCP_PORT2}"

JGROUPS_TCP_PORT="${JGROUPS_TCP_PORT}"
REMOTE_DEST_PORT1="${REMOTE_DEST_PORT1}"
REMOTE_DEST_PORT2="${REMOTE_DEST_PORT2}"

######################################################################

function set_node_name {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/:write-attribute(name=name,value=${INSTANCE_NAME})
run-batch
quit
EOF
}

function delete_outbound_socket_binding {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${CLUSTER_INSTANCE_NAME1}:remove()
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${CLUSTER_INSTANCE_NAME2}:remove()
run-batch
quit
EOF
}

function set_standard_sockets {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/socket-binding-group=standard-sockets/socket-binding=jgroups-tcp:write-attribute(name=port,value=${JGROUPS_TCP_PORT})
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${CLUSTER_INSTANCE_NAME1}:add(host=${CLUSTER_BIND_ADDRESS1},port=${REMOTE_DEST_PORT1})
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${CLUSTER_INSTANCE_NAME2}:add(host=${CLUSTER_BIND_ADDRESS2},port=${REMOTE_DEST_PORT2})
run-batch
quit
EOF

# /socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${CLUSTER_INSTANCE_NAME1}:write-attribute(name=host,value=${CLUSTER_BIND_ADDRESS1})
# /socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${CLUSTER_INSTANCE_NAME2}:write-attribute(name=host,value=${CLUSTER_BIND_ADDRESS2})
# /socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${CLUSTER_INSTANCE_NAME1}:write-attribute(name=port,value=${REMOTE_DEST_PORT1})
# /socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=${CLUSTER_INSTANCE_NAME2}:write-attribute(name=port,value=${REMOTE_DEST_PORT2})
}

function set_tcp_stack {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/subsystem=jgroups/stack=tcp:remove()
/subsystem=jgroups/stack=tcp:add()
/subsystem=jgroups/stack=tcp/transport=TCP:add(socket-binding=jgroups-tcp)
/subsystem=jgroups/stack=tcp/protocol=TCPPING:add()
/subsystem=jgroups/stack=tcp/protocol=TCPPING/property=initial_hosts/:add(value="${CLUSTER_BIND_ADDRESS1}[${CLUSTER_TCP_PORT1}],${CLUSTER_BIND_ADDRESS2}[${CLUSTER_TCP_PORT2}]")
/subsystem=jgroups/stack=tcp/protocol=TCPPING/property=port_range/:add(value=0)
/subsystem=jgroups/stack=tcp/protocol=MERGE3:add()
/subsystem=jgroups/stack=tcp/protocol=FD_SOCK:add(socket-binding=jgroups-tcp-fd)
/subsystem=jgroups/stack=tcp/protocol=FD_ALL:add()
/subsystem=jgroups/stack=tcp/protocol=VERIFY_SUSPECT:add()
/subsystem=jgroups/stack=tcp/protocol=pbcast.NAKACK2:add()
/subsystem=jgroups/stack=tcp/protocol=UNICAST3:add()
/subsystem=jgroups/stack=tcp/protocol=pbcast.STABLE:add()
/subsystem=jgroups/stack=tcp/protocol=pbcast.GMS:add()
/subsystem=jgroups/stack=tcp/protocol=MFC:add()
/subsystem=jgroups/stack=tcp/protocol=FRAG2:add()
run-batch
quit
EOF

### legacy
# batch
# /subsystem=jgroups/stack=tcp:remove()
# /subsystem=jgroups/stack=tcp:add(transport={type=TCP,socket-binding=jgroups-tcp})
# /subsystem=jgroups/stack=tcp:add-protocol(type=TCPPING)
# /subsystem=jgroups/stack=tcp/protocol=TCPPING/property=initial_hosts/:add(value="${CLUSTER_BIND_ADDRESS1}[${CLUSTER_TCP_PORT1}],${CLUSTER_BIND_ADDRESS2}[${CLUSTER_TCP_PORT2}]")
# /subsystem=jgroups/stack=tcp/protocol=TCPPING/property=port_range/:add(value=0)
# /subsystem=jgroups/stack=tcp:add-protocol(type=MERGE3)
# /subsystem=jgroups/stack=tcp:add-protocol(type=FD_SOCK,socket-binding=jgroups-tcp-fd)
# /subsystem=jgroups/stack=tcp:add-protocol(type=FD_ALL)
# /subsystem=jgroups/stack=tcp:add-protocol(type=VERIFY_SUSPECT)
# /subsystem=jgroups/stack=tcp:add-protocol(type=pbcast.NAKACK2)
# /subsystem=jgroups/stack=tcp:add-protocol(type=UNICAST3)
# /subsystem=jgroups/stack=tcp:add-protocol(type=pbcast.STABLE)
# /subsystem=jgroups/stack=tcp:add-protocol(type=pbcast.GMS)
# /subsystem=jgroups/stack=tcp:add-protocol(type=MFC)
# /subsystem=jgroups/stack=tcp:add-protocol(type=FRAG2)
}

function set_default_stack {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
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
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
        --echo-command \
        --command=":reload()"
}

######################################################################

set_node_name
delete_outbound_socket_binding
set_standard_sockets
set_tcp_stack
set_default_stack
reload_server
