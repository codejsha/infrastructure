#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

STACK_NAME="udp"

######################################################################

function print_help {
    echo ""
    echo "Usage:"
    echo "  --stack-name|--stack-name=     : set the clustering type"


function set_arguments {
    while [[ $# -gt 0 ]]
    do
        ARGS="${1}"
        shift
        case "${ARGS}" in
            "--help")           print_help;                     ;;
            "--stack-name")     STACK_NAME="${1}";              shift;;
            "--stack-name="*)   STACK_NAME="${ARGS#*=}";        ;;
        esac
    done
}

######################################################################

set_arguments ${@}
