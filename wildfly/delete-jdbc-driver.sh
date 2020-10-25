#!/usr/bin/bash

source ./env-base.sh

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
                print_help
                exit
                ;;
            "--name")
                DRIVER_NAME="${1}"
                shift
                ;;
            "--name="*)
                DRIVER_NAME="${ARGS#*=}"
                ;;
        esac
    done
}

function remove_jdbc_driver {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/subsystem=datasources/jdbc-driver=${DRIVER_NAME}:remove"
}

######################################################################

DRIVER_NAME="oracle"    # default
set_arguments ${@}

remove_jdbc_driver
