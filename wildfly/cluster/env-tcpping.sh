#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

INSTANCE_NAME1="inst1"
INSTANCE_NAME2="inst2"
BIND_ADDRESS1="${BIND_ADDRESS}"
BIND_ADDRESS2="${BIND_ADDRESS}"
JGROUPS_TCP_PORT1="7601"
JGROUPS_TCP_PORT2="7602"
TCPPING_SOCKET_BINDINGS="${INSTANCE_NAME1},${INSTANCE_NAME2}"

######################################################################

JGROUPS_TCP_PORT=""
if [ "${INSTANCE_NAME1}" == "${INSTANCE_NAME}" ]; then
    JGROUPS_TCP_PORT="${JGROUPS_TCP_PORT1}"
elif [ "${INSTANCE_NAME2}" == "${INSTANCE_NAME}" ]; then
    JGROUPS_TCP_PORT="${JGROUPS_TCP_PORT2}"
fi
