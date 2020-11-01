#!/usr/bin/bash

source ../env-base.sh

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

function deploy_application {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
deploy ${APP_PATH}\
    --name=${APP_NAME}\
    --runtime-name=${APP_RUNTIME_NAME}\
    --unmanaged
run-batch
quit
EOF
}

function check_deployment_status {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
deployment-info --name=${APP_NAME}
run-batch
quit
EOF
}

function check_deployment_status_all {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
deploy -l"
run-batch
quit
EOF
}

######################################################################

APP_PATH="/svc/app/helloworld"        # default
APP_NAME="helloworld.war"             # default
APP_RUNTIME_NAME="helloworld.war"     # default
set_arguments ${@}

deploy_application
check_deployment_status
# check_deployment_status_all
