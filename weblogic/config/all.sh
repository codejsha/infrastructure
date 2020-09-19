#!/usr/bin/bash

######################################################################

### CREATE NODEMANAGER
###
### ./create-nodemgr.sh NODEMGR_NAME NODEMGR_ADDRESS NODEMGR_PORT
###

./create-nodemgr.sh BaseMachine1 test.example.com 5556
# ./create-nodemgr.sh BaseMachine2 test.example.com 5557

######################################################################

### CREATE CLUSTER
###
### ./create-cluster.sh CLUSTER_NAME UNICAST
### ./create-cluster.sh CLUSTER_NAME MULTICAST MULTICAST_ADDRESS MULTICAST_PORT
###

./create-cluster.sh BaseCluster1 unicast
# ./create-cluster.sh BaseCluster2 multicast 239.192.0.0 7001
# ./create-cluster.sh BaseJmsCluster1 unicast
# ./create-cluster.sh BaseJmsCluster2 multicast 239.192.0.0 7001

######################################################################

### CREATE SERVER
###
### ./create-server.sh MANAGED_SERVER_NAME MANAGED_SERVER_ADDRESS MANAGED_SERVER_PORT
### ./create-server.sh MANAGED_SERVER_NAME MANAGED_SERVER_ADDRESS MANAGED_SERVER_PORT CLUSTER_NAME
### ./create-server.sh MANAGED_SERVER_NAME MANAGED_SERVER_ADDRESS MANAGED_SERVER_PORT CLUSTER_NAME NODEMGR_NAME
###

# ./create-server.sh ManagedServer1 test.example.com 7003
# ./create-server.sh ManagedServer2 test.example.com 7004
# ./create-server.sh ManagedServer1 test.example.com 7003 BaseCluster1
# ./create-server.sh ManagedServer2 test.example.com 7004 BaseCluster1
./create-server.sh ManagedServer1 test.example.com 7003 BaseCluster1 BaseMachine1
./create-server.sh ManagedServer2 test.example.com 7004 BaseCluster1 BaseMachine1
# ./create-server.sh JmsManagedServer1 test.example.com 7005 BaseJmsCluster1
# ./create-server.sh JmsManagedServer2 test.example.com 7006 BaseJmsCluster1

######################################################################

### DEPLOY APPLICATION
###
### ./deploy-app.sh APP_NAME APP_PATH APP_TARGET
###

./deploy-app.sh testweb /svc/app/testweb BaseCluster1
# ./deploy-app.sh sample1 /svc/app/sample1 ManagedServer1
# ./deploy-app.sh sample2 /svc/app/sample2 ManagedServer2

######################################################################

### CREATE DATASOURCE
### 
### ./create-datasource.sh DS_NAME DS_JNDI \
###     DS_URL \
###     DS_DRIVER DS_USER DS_PASSWORD DS_INIT DS_MIN DS_MAX 
###     DS_TARGET_TYPE DS_TARGET
### 

./create-datasource.sh BaseDataSource1 "baseds1" \
    jdbc:oracle:thin:@192.168.137.1:1521:orclcdb \
    oracle.jdbc.OracleDriver system PASSWORD 1 1 15 
    Cluster "BaseCluster1"
# ./create-datasource.sh BaseDataSource1 "baseds1" \
#     jdbc:oracle:thin:@192.168.137.1:1521:orclcdb \
#     oracle.jdbc.OracleDriver system PASSWORD 1 1 15 
#     Server "ManagedServer1"
