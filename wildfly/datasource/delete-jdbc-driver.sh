#!/bin/bash

source ../env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

DRIVER_NAME="oracle"    # default

######################################################################

function remove_jdbc_driver {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=datasources/jdbc-driver=${DRIVER_NAME}:remove
run-batch
quit
EOF
}

######################################################################

function print_help {
    echo "  --name|--name=                : set a jdbc driver name."
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
                DRIVER_NAME="${1}"; shift;;
            "--name="*)
                DRIVER_NAME="${ARGS#*=}";;
        esac
    done
}

######################################################################

set_arguments ${@}

remove_jdbc_driver
