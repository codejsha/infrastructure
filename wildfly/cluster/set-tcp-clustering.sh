#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh
source ./env-tcpping.sh

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
set_tcp_stack
reload_server
