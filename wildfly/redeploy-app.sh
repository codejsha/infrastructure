#!/usr/bin/bash

source ./env-base.sh

APP_PATH="${1}"
APP_NAME="${2}"
APP_RUNTIME_NAME="${3}"

bash ./undeploy-app.sh ${APP_NAME}
bash ./deploy-app.sh ${APP_PATH} ${APP_NAME} ${APP_RUNTIME_NAME}
