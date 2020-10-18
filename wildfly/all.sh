#!/usr/bin/bash

######################################################################

### Deployment
### ./deploy-app.sh ${APP_PATH} ${APP_NAME} ${APP_RUNTIME_NAME}
### ./undeploy-app.sh ${APP_NAME}
### ./redeploy-app.sh ${APP_PATH} ${APP_NAME} ${APP_RUNTIME_NAME}

bash ./deploy-app.sh "/svc/app/test" "test.war" "test.war"
# bash ./undeploy-app.sh "test.war"
# bash ./redeploy-app.sh "/svc/app/test" "test.war" "test.war"

######################################################################
