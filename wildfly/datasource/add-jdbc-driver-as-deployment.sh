#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh
source ./env-jdbc-driver.sh

APP_NAME="${DRIVER_NAME}"
APP_PATH="${DRIVER_FILE_DIR}/${DRIVER_FILE}"
APP_RUNTIME_NAME="${DRIVER_RUNTIME_NAME}"

######################################################################

function deploy_application {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
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

function get_deployment_status {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
        --echo-command \
        --command="deployment-info --name=${APP_NAME}"
}

function get_deployment_status_all {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
        --echo-command \
        --command="deploy -l"
}

######################################################################

add_jdbc_driver_with_deployment
get_deployment_status
# get_deployment_status_all
