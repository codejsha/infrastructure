#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh
source ./env-http-thread-pool.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

WORKER_NAME="${WORKER_NAME}"
IO_THREADS="${IO_THREADS}"
STACK_SIZE="${STACK_SIZE}"
TASK_CORE_THREADS="${TASK_CORE_THREADS}"
TASK_KEEPALIVE="${TASK_KEEPALIVE}"
TASK_MAX_THREADS="${TASK_MAX_THREADS}"

######################################################################

function set_listener_thread_pool {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=undertow/server=default-server/http-listener=default:write-attribute(name=worker,value=${WORKER_NAME})

# /subsystem=io/worker=${WORKER_NAME}:write-attribute(name=io-threads,value=${IO_THREADS})
# /subsystem=io/worker=${WORKER_NAME}:write-attribute(name=stack-size,value=${STACK_SIZE})
/subsystem=io/worker=${WORKER_NAME}:write-attribute(name=task-core-threads,value=${TASK_CORE_THREADS})
# /subsystem=io/worker=${WORKER_NAME}:write-attribute(name=task-keepalive,value=${TASK_KEEPALIVE})
/subsystem=io/worker=${WORKER_NAME}:write-attribute(name=task-max-threads,value=${TASK_MAX_THREADS})
run-batch
quit
EOF
}

function reload_server {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --echo-command \
        --command=":reload()"
}

######################################################################

set_listener_thread_pool
reload_server
