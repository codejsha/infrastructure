#!/usr/bin/bash

source ../env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

APP_PATH="/svc/app/failovertest"        # default
APP_NAME="failovertest.war"             # default
APP_RUNTIME_NAME="failovertest.war"     # default

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
                print_help; exit;;
            "--path")
                APP_PATH="${1}"; shift;;
            "--path="*)
                APP_PATH="${ARGS#*=}";;
            "--name")
                APP_NAME="${1}"; shift;;
            "--name="*)
                APP_NAME="${ARGS#*=}";;
            "--runtime-name")
                APP_RUNTIME_NAME="${1}"; shift;;
            "--runtime-name="*)
                APP_RUNTIME_NAME="${ARGS#*=}";;
        esac
    done
}

######################################################################

set_arguments ${@}

bash ./undeploy-app.sh --name=${APP_NAME}
bash ./deploy-app.sh --path=${APP_PATH} --name=${APP_NAME} --runtime-name=${APP_RUNTIME_NAME}
