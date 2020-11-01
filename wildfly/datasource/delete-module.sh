#!/usr/bin/bash

source ../env-base.sh

######################################################################

function print_help {
    echo "  --name|--name=                : set a module name."
}

function set_arguments {
    while [[ $# -gt 0 ]]
    do
        ARGS="${1}"
        shift
        case "${ARGS}" in
            "--help")
                print_help; exit;;
            "--name")
                MODULE_NAME="${1}"; shift;;
            "--name="*)
                MODULE_NAME="${ARGS#*=}";;
        esac
    done
}

function remove_module {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
module remove --name=${MODULE_NAME}
run-batch
quit
EOF
}

######################################################################

MODULE_NAME="com.oracle"    # default
set_arguments ${@}

remove_module
