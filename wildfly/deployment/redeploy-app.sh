#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

APP_PATH="${APP_PATH}"
APP_NAME="${APP_NAME}"
APP_RUNTIME_NAME="${APP_RUNTIME_NAME}"

######################################################################

bash ./undeploy-app.sh --name=${APP_NAME}
bash ./deploy-app.sh --path=${APP_PATH} --name=${APP_NAME} --runtime-name=${APP_RUNTIME_NAME}
