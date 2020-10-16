#!/usr/bin/bash

source ./env-base.sh
source ./env-app.sh

APP_PATH="${1:-APP_PATH}"
APP_NAME="${2:-APP_NAME}"
APP_RUNTIME_NAME="${3:-APP_RUNTIME_NAME}"

######################################################################

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

undeploy_application
# check_deployment_status_all
