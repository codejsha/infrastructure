#!/bin/bash

function print_help {
    echo ""
    echo "Usage:"
    echo "  --instance|--instance=        : set a instance name"
    echo "  --port-offset|--port-offset=  : set the port offset"
}

function set_arguments {
    while [[ $# -gt 0 ]]
    do
        ARGS="${1}"
        shift
        case "${ARGS}" in
            "--help")           print_help;                     ;;
            "--instance")       INSTANCE_NAME="${1}";           shift;;
            "--instance="*)     INSTANCE_NAME="${ARGS#*=}";     ;;
            "--port-offset")    PORT_OFFSET="${1}";             shift;;
            "--port-offset="*)  PORT_OFFSET="${ARGS#*=}";       ;;
        esac
    done
}

######################################################################

set_arguments ${@}
