#!/usr/bin/bash

source ../env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

MODULE_NAME="com.oracle"    # default

######################################################################

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

######################################################################

set_arguments ${@}

remove_module
