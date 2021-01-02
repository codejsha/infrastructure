#!/bin/bash

source ./env-base.sh
source ./env-thread-pool.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

WORKER_NAME="${WORKER_NAME}"

######################################################################

function set_thread_pool {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=io/worker=${WORKER_NAME}:write-attribute(name=io-threads,value=)
/subsystem=io/worker=${WORKER_NAME}:write-attribute(name=stack-size,value=)
/subsystem=io/worker=${WORKER_NAME}:write-attribute(name=task-core-threads,value=)
/subsystem=io/worker=${WORKER_NAME}:write-attribute(name=task-keepalive,value=)
/subsystem=io/worker=${WORKER_NAME}:write-attribute(name=task-max-threads,value=)
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

set_thread_pool
reload_server
