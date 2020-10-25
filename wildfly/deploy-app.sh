#!/usr/bin/bash

source ./env-base.sh

######################################################################

function print_help {
    echo "  --path|--path=                : set a application path."
    echo "  --name|--name=                : set a application name."
    echo "  --runtime-name|--runtime-name=  : set a application runtime name."
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
            "--path")
                APP_PATH="${1}"
                shift
                ;;
            "--path="*)
                APP_PATH="${ARGS#*=}"
                ;;
            "--name")
                APP_NAME="${1}"
                shift
                ;;
            "--name="*)
                APP_NAME="${ARGS#*=}"
                ;;
            "--runtime-name")
                APP_RUNTIME_NAME="${1}"
                shift
                ;;
            "--runtime-name="*)
                APP_RUNTIME_NAME="${ARGS#*=}"
                ;;
        esac
    done
}

function deploy_application {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="deploy ${APP_PATH} \
            --name=${APP_NAME} \
            --runtime-name=${APP_RUNTIME_NAME} \
            --unmanaged"
}

function check_deployment_status {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="deployment-info --name=${APP_NAME}"
}

function check_deployment_status_all {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="deploy -l"
}

######################################################################

APP_PATH="/svc/app/test"        # default
APP_NAME="test.war"             # default
APP_RUNTIME_NAME="test.war"     # default
set_arguments ${@}

deploy_application
check_deployment_status
# check_deployment_status_all
