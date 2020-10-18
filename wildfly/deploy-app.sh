#!/usr/bin/bash

source ./env-base.sh

APP_PATH="${1}"
APP_NAME="${2}"
APP_RUNTIME_NAME="${3}"

######################################################################

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

deploy_application
check_deployment_status
# check_deployment_status_all
