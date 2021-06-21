#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

WORKER_NAME="default"
# WORKER_NAME="https-worker"

# IO_THREADS=""
# STACK_SIZE=""
TASK_CORE_THREADS="150"
# TASK_KEEPALIVE=""
TASK_MAX_THREADS="150"
