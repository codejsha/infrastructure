#!/usr/bin/bash

source ../env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

DATASOURCE_NAME="baseds1"   # default

######################################################################

function disable_datasource {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=datasources/data-source=${DATASOURCE_NAME}\
    :write-attribute(name=enabled,value=false)"
run-batch
quit
EOF
}

function reload_server {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command=":reload()"
}

function remove_datasource {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=datasources/data-source=${DATASOURCE_NAME}:remove
run-batch
quit
EOF
}

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

######################################################################

set_arguments ${@}

disable_datasource
reload_server
remove_datasource
