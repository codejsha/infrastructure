#!/usr/bin/bash

######################################################################

### CREATE NODEMANAGER
### bash ./create-nodemgr.sh ${NODEMGR_NAME} ${NODEMGR_ADDRESS} ${NODEMGR_PORT}
### bash ./create-nodemgr-scripts.sh ${NODEMGR_NAME} ${NODEMGR_ADDRESS} ${NODEMGR_PORT}
###

bash ./create-nodemgr.sh BaseMachine1 test.example.com 5556
# bash ./create-nodemgr.sh BaseMachine2 test.example.com 5557
bash ./create-nodemgr-scripts.sh BaseMachine1 test.example.com 5556
# bash ./create-nodemgr-scripts.sh BaseMachine2 test.example.com 5557

######################################################################

### CREATE CLUSTER
### bash ./create-cluster.sh ${CLUSTER_NAME} ${UNICAST}
### bash ./create-cluster.sh ${CLUSTER_NAME} ${MULTICAST} ${MULTICAST_ADDRESS} ${MULTICAST_PORT}
###

bash ./create-cluster.sh BaseCluster1 unicast
# bash ./create-cluster.sh BaseCluster2 multicast 239.192.0.0 7001
# bash ./create-cluster.sh BaseJmsCluster1 unicast
# bash ./create-cluster.sh BaseJmsCluster2 multicast 239.192.0.0 7001

######################################################################

### CREATE SERVER
### bash ./create-server.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT}
### bash ./create-server.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT} ${CLUSTER_NAME}
### bash ./create-server.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT} ${CLUSTER_NAME} ${NODEMGR_NAME}
### bash ./create-scripts.sh ${SERVER_NAME}
###

# bash ./create-server.sh ManagedServer1 test.example.com 7003
# bash ./create-server.sh ManagedServer2 test.example.com 7004
# bash ./create-server.sh ManagedServer1 test.example.com 7003 BaseCluster1
# bash ./create-server.sh ManagedServer2 test.example.com 7004 BaseCluster1
bash ./create-server.sh ManagedServer1 test.example.com 7003 BaseCluster1 BaseMachine1
bash ./create-server.sh ManagedServer2 test.example.com 7004 BaseCluster1 BaseMachine1
# bash ./create-server.sh JmsManagedServer1 test.example.com 7005 BaseJmsCluster1
# bash ./create-server.sh JmsManagedServer2 test.example.com 7006 BaseJmsCluster1
bash ./create-scripts.sh ManagedServer1
bash ./create-scripts.sh ManagedServer2
# bash ./create-scripts.sh JmsManagedServer1
# bash ./create-scripts.sh JmsManagedServer2

######################################################################

### DEPLOY APPLICATION
### bash ./deploy-app.sh ${APP_NAME} ${APP_PATH} ${APP_TARGET}
###

bash ./deploy-app.sh testweb /svc/app/testweb BaseCluster1
# bash ./deploy-app.sh sample1 /svc/app/sample1 ManagedServer1
# bash ./deploy-app.sh sample2 /svc/app/sample2 ManagedServer2

######################################################################

### CREATE DATASOURCE
### bash ./create-datasource.sh ${DS_NAME} ${DS_JNDI} \
###     ${DS_URL} \
###     ${DS_DRIVER} ${DS_USER} ${DS_PASSWORD} ${DS_INIT} ${DS_MIN} ${DS_MAX}
###     ${DS_TARGET_TYPE} ${DS_TARGET}
###

bash ./create-datasource.sh BaseDataSource1 "baseds1" \
    jdbc:oracle:thin:@192.168.137.1:1521:orclcdb \
    oracle.jdbc.OracleDriver system PASSWORD 1 1 15
    Cluster "BaseCluster1"
# bash ./create-datasource.sh BaseDataSource1 "baseds1" \
#     jdbc:oracle:thin:@192.168.137.1:1521:orclcdb \
#     oracle.jdbc.OracleDriver system PASSWORD 1 1 15
#     Server "ManagedServer1"
