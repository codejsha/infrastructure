#!/usr/bin/bash

######################################################################

### Deployment
# bash ./deploy-app.sh --path=/svc/app/test --name=test.war --runtime-name=test.war
# bash ./undeploy-app.sh --name=test.war
# bash ./redeploy-app.sh --path=/svc/app/test --name=test.war --runtime-name=test.war
bash ./deploy-app.sh --port-offset=0 --path=/svc/app/test --name=test.war --runtime-name=test.war
# bash ./undeploy-app.sh --port-offset=0 --name=test.war
# bash ./redeploy-app.sh --port-offset=0 --path=/svc/app/test --name=test.war --runtime-name=test.war
bash ./deploy-app.sh --port-offset=1 --path=/svc/app/test --name=test.war --runtime-name=test.war
# bash ./undeploy-app.sh --port-offset=1 --name=test.war
# bash ./redeploy-app.sh --port-offset=1 --path=/svc/app/test --name=test.war --runtime-name=test.war

######################################################################
