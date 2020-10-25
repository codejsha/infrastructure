#!/usr/bin/bash

source ./env-base.sh

######################################################################

function print_help {
    echo "  --name|--name=                : set a application name."
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
                APP_NAME="${1}"; shift;;
            "--name="*)
                APP_NAME="${ARGS#*=}";;
        esac
    done
}

function undeploy_application {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="undeploy ${APP_NAME}"
}

function check_deployment_status_all {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="deploy -l"
}

######################################################################

APP_NAME="test.war"     # default
set_arguments ${@}

undeploy_application
# check_deployment_status_all
