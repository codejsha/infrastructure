#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ./env-app.sh

######################################################################

bash ./undeploy-app.sh --name=${APP_NAME}
bash ./deploy-app.sh --path=${APP_PATH} --name=${APP_NAME} --runtime-name=${APP_RUNTIME_NAME}
