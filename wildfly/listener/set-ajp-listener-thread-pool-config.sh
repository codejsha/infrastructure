#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh
source ./env-ajp-thread-pool.sh

######################################################################

function set_listener_thread_pool_config {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/subsystem=undertow/server=default-server/ajp-listener=ajp:write-attribute(name=worker,value=${WORKER_NAME})\

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
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
        --echo-command \
        --command=":reload()"
}

######################################################################

set_listener_thread_pool_config
reload_server
