#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

WORKER_NAME="default"
# WORKER_NAME="http-worker"
# WORKER_NAME="https-worker"
# WORKER_NAME="ajp-worker"

######################################################################

function print_help {
    echo ""
    echo "Usage:"
    echo "  --worker-name|--worker-name=  : set a worker name"
}

function set_arguments {
    while [[ $# -gt 0 ]]
    do
        ARGS="${1}"
        shift
        case "${ARGS}" in
            "--help")           print_help;                     ;;
            "--worker-name")    WORKER_NAME="${1}";             shift;;
            "--worker-name="*)  WORKER_NAME="${ARGS#*=}";       ;;
        esac
    done
}

######################################################################

set_arguments ${@}
