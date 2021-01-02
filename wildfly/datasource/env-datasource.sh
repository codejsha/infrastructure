#!/bin/bash

# DRIVER_NAME=""

DATASOURCE_NAME="baseds1"
JNDI_NAME="java:/base/ds1"
ENABLED="true"
CONNECTION_URL="jdbc:oracle:thin:@192.168.137.1:1521:orclcdb"
INITIAL_POOL_SIZE="20"
MIN_POOL_SIZE="20"
MAX_POOL_SIZE="20"
USERNAME="system"
PASSWORD="\${VAULT::datasource::password::1}"
CHECK_VALID_CONNECTION_SQL="SQL ISVALID"
BACKGROUND_VALIDATION="true"
BACKGROUND_VALIDATION_MILLIS="120000"
BLOCKING_TIMEOUT_WAIT_MILLIS="2000"
QUERY_TIMEOUT="3600"
TRACK_STATEMENTS="true"
POOL_PREFILL="true"
POOL_USE_STRICT_MIN="true"
PREPARED_STATEMENTS_CACHE_SIZE="10"
SHARE_PREPARED_STATEMENTS="true"
USE_CCM="true"

######################################################################

function print_help {
    echo "  --name|--name=                : set a datasource name"
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

######################################################################

set_arguments ${@}
