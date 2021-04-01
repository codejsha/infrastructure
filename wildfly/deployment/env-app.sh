#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

APP_PATH="/svc/app/failovertest"
APP_NAME="failovertest.war"
APP_RUNTIME_NAME="failovertest.war"

######################################################################

function print_help {
    echo "  --path|--path=                : set the path of application"
    echo "  --name|--name=                : set the name of application"
    echo "  --runtime-name|--runtime-name=  : set the runtime name of application"
}

function set_arguments {
    while [[ $# -gt 0 ]]
    do
        ARGS="${1}"
        shift
        case "${ARGS}" in
            "--help")               print_help;                     exit;;
            "--path")               APP_PATH="${1}";                shift;;
            "--path="*)             APP_PATH="${ARGS#*=}";          ;;
            "--name")               APP_NAME="${1}";                shift;;
            "--name="*)             APP_NAME="${ARGS#*=}";          ;;
            "--runtime-name")       APP_RUNTIME_NAME="${1}";        shift;;
            "--runtime-name="*)     APP_RUNTIME_NAME="${ARGS#*=}";  ;;
        esac
    done
}

######################################################################

set_arguments ${@}
