#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-app.sh

######################################################################

bash ./undeploy-app.sh --name=${APP_NAME}
bash ./deploy-app.sh --path=${APP_PATH} --name=${APP_NAME} --runtime-name=${APP_RUNTIME_NAME}
