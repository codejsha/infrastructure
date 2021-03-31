#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

bash ./print-env-base-info.sh

######################################################################

### DEPLOY APPLICATION
### bash ./deploy-app.sh ${APP_NAME} ${APP_PATH} ${APP_TARGET}

bash ./deploy-app.sh failovertest /svc/app/failovertest BaseCluster1
bash ./deploy-app.sh cachetest /svc/app/cachetest BaseCluster1
bash ./deploy-app.sh jdbcdrivertest /svc/app/jdbcdrivertest BaseCluster1
# bash ./deploy-app.sh weblogic-versioned /svc/app/weblogic-versioned/deployversion1/sample.war BaseCluster1
# bash ./deploy-app.sh sample1 /svc/app/sample1 ManagedServer1
# bash ./deploy-app.sh sample2 /svc/app/sample2 ManagedServer2
