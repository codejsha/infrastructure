#!/usr/bin/bash

source ../env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

APP_NAME="failovertest.war"     # default

######################################################################

function undeploy_application {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
undeploy ${APP_NAME}
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
deploy -l
run-batch
quit
EOF
}

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

######################################################################

set_arguments ${@}

undeploy_application
# check_deployment_status_all
