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
cd datasource

# bash ./add-jdbc-driver-with-module.sh
bash ./add-jdbc-driver-with-module.sh --port-offset=0
bash ./add-jdbc-driver-with-module.sh --port-offset=1
# bash ./add-jdbc-driver-with-deployment.sh
# bash ./add-jdbc-driver-with-deployment.sh --port-offset=0
# bash ./add-jdbc-driver-with-deployment.sh --port-offset=1

# bash ./add-datasource.sh
bash ./add-datasource.sh --port-offset=0
bash ./add-datasource.sh --port-offset=1
# bash ./set-datasource.sh --port-offset=0
# bash ./set-datasource.sh --port-offset=1

# bash ./delete-datasource.sh --name=baseds1
# bash ./delete-datasource.sh --port-offset=0 --name=baseds1
# bash ./delete-datasource.sh --port-offset=1 --name=baseds1

cd ..

######################################################################

### Deployment
cd deployment

# bash ./deploy-app.sh --path=/svc/app/helloworld --name=helloworld.war --runtime-name=helloworld.war
# bash ./deploy-app.sh --port-offset=0 --path=/svc/app/helloworld --name=helloworld.war --runtime-name=helloworld.war
# bash ./deploy-app.sh --port-offset=1 --path=/svc/app/helloworld --name=helloworld.war --runtime-name=helloworld.war
bash ./deploy-app.sh --port-offset=0 --path=/svc/app/failovertest --name=failovertest.war --runtime-name=failovertest.war
bash ./deploy-app.sh --port-offset=1 --path=/svc/app/failovertest --name=failovertest.war --runtime-name=failovertest.war

# bash ./undeploy-app.sh --name=helloworld.war
# bash ./undeploy-app.sh --port-offset=0 --name=helloworld.war
# bash ./undeploy-app.sh --port-offset=1 --name=helloworld.war
# bash ./undeploy-app.sh --port-offset=0 --name=failovertest.war
# bash ./undeploy-app.sh --port-offset=1 --name=failovertest.war

# bash ./redeploy-app.sh --path=/svc/app/helloworld --name=helloworld.war --runtime-name=helloworld.war
# bash ./redeploy-app.sh --port-offset=0 --path=/svc/app/helloworld --name=helloworld.war --runtime-name=helloworld.war
# bash ./redeploy-app.sh --port-offset=1 --path=/svc/app/helloworld --name=helloworld.war --runtime-name=helloworld.war
# bash ./redeploy-app.sh --port-offset=0 --path=/svc/app/failovertest --name=failovertest.war --runtime-name=failovertest.war
# bash ./redeploy-app.sh --port-offset=1 --path=/svc/app/failovertest --name=failovertest.war --runtime-name=failovertest.war

cd ..

######################################################################

### Filter
cd filter

# bash ./add-filter.sh
bash ./add-filter.sh --port-offset=0
bash ./add-filter.sh --port-offset=1

# bash ./add-samesite-filter.sh
bash ./add-samesite-filter.sh --port-offset=0
bash ./add-samesite-filter.sh --port-offset=1

# bash ./add-stuck-thread-detector.sh
bash ./add-stuck-thread-detector.sh --port-offset=0
bash ./add-stuck-thread-detector.sh --port-offset=1

# bash ./hide-server-info.sh
bash ./hide-server-info.sh --port-offset=0
bash ./hide-server-info.sh --port-offset=1

cd ..

######################################################################

### Logging
cd logging

# bash ./add-access-log.sh
bash ./add-access-log.sh --port-offset=0
bash ./add-access-log.sh --port-offset=1

# bash ./set-logging.sh
bash ./set-logging.sh --port-offset=0
bash ./set-logging.sh --port-offset=1

cd ..
