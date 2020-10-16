#!/usr/bin/bash

source ./env-base.sh
source ./env-app.sh

APP_PATH="${1:-APP_PATH}"
APP_NAME="${2:-APP_NAME}"
APP_RUNTIME_NAME="${3:-APP_RUNTIME_NAME}"

bash ./undeploy-app.sh
bash ./deploy-app.sh
