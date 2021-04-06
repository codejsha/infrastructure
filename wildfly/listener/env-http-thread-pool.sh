# !/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

WORKER_NAME="default"
# WORKER_NAME="http-worker"

# IO_THREADS=""
# STACK_SIZE=""
TASK_CORE_THREADS="150"
# TASK_KEEPALIVE=""
TASK_MAX_THREADS="150"
