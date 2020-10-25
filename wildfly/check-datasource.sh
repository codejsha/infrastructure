#!/usr/bin/bash

source ./env-base.sh

######################################################################

function print_help {
    echo "  --name|--name=                : set a datasource name."
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
                DATASOURCE_NAME="${1}"; shift;;
            "--name="*)
                DATASOURCE_NAME="${ARGS#*=}";;
        esac
    done
}

function test_connection_pool {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/subsystem=datasources/data-source=${DATASOURCE_NAME}:test-connection-in-pool"
}

######################################################################

DATASOURCE_NAME="baseds1"   # default
set_arguments ${@}

test_connection_pool
