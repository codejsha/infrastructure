#!/usr/bin/bash

source ./env-base.sh

APP_PATH="/svc/app/test"
APP_NAME="test.war"
APP_RUNTIME_NAME="test.war"

######################################################################

function deploy_application {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="deploy ${APP_PATH} --name=${APP_NAME} --runtime-name=${APP_RUNTIME_NAME} --unmanaged"
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
