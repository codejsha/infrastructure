#!/usr/bin/bash

######################################################################

### Instance

# bash ./create-instance.sh
bash ./create-instance.sh --instance=inst1
bash ./create-instance.sh --instance=inst2

# bash create-scripts.sh
bash create-scripts.sh --instance=inst1 --port-offset=0
bash create-scripts.sh --instance=inst2 --port-offset=1

######################################################################

### Datasource

# bash ./datasource/add-jdbc-driver-by-module.sh
bash ./datasource/add-jdbc-driver-by-module.sh --port-offset=0
bash ./datasource/add-jdbc-driver-by-module.sh --port-offset=1
# bash ./datasource/add-jdbc-driver-by-deployment.sh
# bash ./datasource/add-jdbc-driver-by-deployment.sh --port-offset=0
# bash ./datasource/add-jdbc-driver-by-deployment.sh --port-offset=1

# bash ./datasource/add-datasource.sh
bash ./datasource/add-datasource.sh --port-offset=0
bash ./datasource/add-datasource.sh --port-offset=1
# bash ./datasource/set-datasource.sh --port-offset=0
# bash ./datasource/set-datasource.sh --port-offset=1

# bash ./datasource/delete-datasource.sh --name=baseds1
# bash ./datasource/delete-datasource.sh --port-offset=0 --name=baseds1
# bash ./datasource/delete-datasource.sh --port-offset=1 --name=baseds1

######################################################################

### Deployment

# bash ./deployment/deploy-app.sh --path=/svc/app/helloworld --name=helloworld.war --runtime-name=helloworld.war
bash ./deployment/deploy-app.sh --port-offset=0 --path=/svc/app/helloworld --name=helloworld.war --runtime-name=helloworld.war
bash ./deployment/deploy-app.sh --port-offset=1 --path=/svc/app/helloworld --name=helloworld.war --runtime-name=helloworld.war
# bash ./deployment/deploy-app.sh --port-offset=0 --path=/svc/app/failovertest --name=failovertest.war --runtime-name=failovertest.war
# bash ./deployment/deploy-app.sh --port-offset=1 --path=/svc/app/failovertest --name=failovertest.war --runtime-name=failovertest.war

# bash ./deployment/undeploy-app.sh --name=helloworld.war
# bash ./deployment/undeploy-app.sh --port-offset=0 --name=helloworld.war
# bash ./deployment/undeploy-app.sh --port-offset=1 --name=helloworld.war
# bash ./deployment/undeploy-app.sh --port-offset=0 --name=failovertest.war
# bash ./deployment/undeploy-app.sh --port-offset=1 --name=failovertest.war

# bash ./deployment/redeploy-app.sh --path=/svc/app/helloworld --name=helloworld.war --runtime-name=helloworld.war
# bash ./deployment/redeploy-app.sh --port-offset=0 --path=/svc/app/helloworld --name=helloworld.war --runtime-name=helloworld.war
# bash ./deployment/redeploy-app.sh --port-offset=1 --path=/svc/app/helloworld --name=helloworld.war --runtime-name=helloworld.war
# bash ./deployment/redeploy-app.sh --port-offset=0 --path=/svc/app/failovertest --name=failovertest.war --runtime-name=failovertest.war
# bash ./deployment/redeploy-app.sh --port-offset=1 --path=/svc/app/failovertest --name=failovertest.war --runtime-name=failovertest.war

######################################################################

### Filter

# bash ./filter/add-filter.sh
bash ./filter/add-filter.sh --port-offset=0
bash ./filter/add-filter.sh --port-offset=1

# bash ./filter/add-samesite-filter.sh
bash ./filter/add-samesite-filter.sh --port-offset=0
bash ./filter/add-samesite-filter.sh --port-offset=1

# bash ./filter/add-stuck-thread-detector.sh
bash ./filter/add-stuck-thread-detector.sh --port-offset=0
bash ./filter/add-stuck-thread-detector.sh --port-offset=1

# bash ./filter/hide-server-info.sh
bash ./filter/hide-server-info.sh --port-offset=0
bash ./filter/hide-server-info.sh --port-offset=1

######################################################################

### Logging

# bash ./logging/add-access-log.sh
bash ./logging/add-access-log.sh --port-offset=0
bash ./logging/add-access-log.sh --port-offset=1

# bash ./logging/set-logging.sh
bash ./logging/set-logging.sh --port-offset=0
bash ./logging/set-logging.sh --port-offset=1
