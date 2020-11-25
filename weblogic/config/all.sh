#!/bin/bash

######################################################################

bash ./create-boot-properties.sh
bash ./create-change-password-script.sh
bash ./create-change-store-user-config-script.sh
bash ./create-encrypt-password-script.sh
bash ./create-regen-demo-identity-script.sh
bash ./create-store-user-config-scripts.sh ManagedServer1
bash ./create-store-user-config-scripts.sh ManagedServer2

######################################################################

bash ./conf-domain.sh
bash ./create-server.sh AdminServer test.example.com 7001
bash ./create-scripts.sh AdminServer
# bash ./set-connection-filter.sh
bash ./set-domain-config-archive.sh
bash ./set-domain-cookie-name.sh
bash ./set-domain-log.sh

######################################################################

### CREATE NODEMANAGER
### bash ./create-nodemgr.sh ${NODEMGR_NAME} ${NODEMGR_ADDRESS} ${NODEMGR_PORT}
### bash ./create-nodemgr-scripts.sh ${NODEMGR_NAME} ${NODEMGR_ADDRESS} ${NODEMGR_PORT}

bash ./create-nodemgr.sh BaseMachine1 test.example.com 5556
# bash ./create-nodemgr.sh BaseMachine2 test.example.com 5557
bash ./create-nodemgr-scripts.sh BaseMachine1 test.example.com 5556
# bash ./create-nodemgr-scripts.sh BaseMachine2 test.example.com 5557

######################################################################

### CREATE CLUSTER
### bash ./create-cluster.sh ${CLUSTER_NAME} ${UNICAST}
### bash ./create-cluster.sh ${CLUSTER_NAME} ${MULTICAST} ${MULTICAST_ADDRESS} ${MULTICAST_PORT}

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

# bash ./create-server.sh ManagedServer1 test.example.com 7003
# bash ./create-server.sh ManagedServer2 test.example.com 7004
# bash ./create-server.sh ManagedServer3 test.example.com 7005
# bash ./create-server.sh ManagedServer4 test.example.com 7006
# bash ./create-server.sh ManagedServer1 test.example.com 7003 BaseCluster1
# bash ./create-server.sh ManagedServer2 test.example.com 7004 BaseCluster1
# bash ./create-server.sh ManagedServer3 test.example.com 7005 BaseCluster2
# bash ./create-server.sh ManagedServer4 test.example.com 7006 BaseCluster2
bash ./create-server.sh ManagedServer1 test.example.com 7003 BaseCluster1 BaseMachine1
bash ./create-server.sh ManagedServer2 test.example.com 7004 BaseCluster1 BaseMachine1
# bash ./create-server.sh ManagedServer3 test.example.com 7005 BaseCluster2 BaseMachine2
# bash ./create-server.sh ManagedServer4 test.example.com 7006 BaseCluster2 BaseMachine2
bash ./create-scripts.sh ManagedServer1
bash ./create-scripts.sh ManagedServer2
# bash ./create-scripts.sh ManagedServer3
# bash ./create-scripts.sh ManagedServer4

# bash ./create-server.sh JmsManagedServer1 test.example.com 7103 BaseJmsCluster1
# bash ./create-server.sh JmsManagedServer2 test.example.com 7104 BaseJmsCluster1
# bash ./create-scripts.sh JmsManagedServer1
# bash ./create-scripts.sh JmsManagedServer2

######################################################################

### DEPLOY APPLICATION
### bash ./deploy-app.sh ${APP_NAME} ${APP_PATH} ${APP_TARGET}

bash ./deploy-app.sh failovertest /svc/app/failovertest BaseCluster1
# bash ./deploy-app.sh sample1 /svc/app/sample1 ManagedServer1
# bash ./deploy-app.sh sample2 /svc/app/sample2 ManagedServer2

######################################################################

### CREATE DATASOURCE
### bash ./create-datasource.sh ${DS_NAME} ${DS_JNDI} ${DS_URL} \
###     ${DS_DRIVER} ${DS_USER} ${DS_PASSWORD} ${DS_INIT} ${DS_MIN} ${DS_MAX} ${DS_TARGET_TYPE} ${DS_TARGET}

bash ./create-datasource.sh BaseDataSource1 "baseds1" "jdbc:oracle:thin:@192.168.137.1:1521:orclcdb" \
    oracle.jdbc.OracleDriver system PASSWORD 1 1 15 Cluster "BaseCluster1"
# bash ./create-datasource.sh BaseDataSource1 "baseds1" "jdbc:oracle:thin:@192.168.137.1:1521:orclcdb" \
#     oracle.jdbc.OracleDriver system PASSWORD 1 1 15 Server "ManagedServer1"
# bash ./create-datasource.sh BaseDataSource2 "baseds2" "jdbc:mysql://192.168.137.1:3306/mysqldb" \
#     com.mysql.cj.jdbc.Driver mysql PASSWORD 1 1 15 Cluster "BaseCluster1"
# bash ./create-datasource.sh BaseDataSource2 "baseds2" "jdbc:mysql://192.168.137.1:3306/mysqldb" \
#     com.mysql.cj.jdbc.Driver mysql PASSWORD 1 1 15 Server "ManagedServer1"
# bash ./create-datasource.sh BaseDataSource3 "baseds3" "jdbc:sqlserver://192.168.137.1:1433;database=sqlserverdb" \
#     com.microsoft.sqlserver.jdbc.SQLServerDriver sa PASSWORD 1 1 15 Cluster "BaseCluster1"
# bash ./create-datasource.sh BaseDataSource3 "baseds3" "jdbc:sqlserver://192.168.137.1:1433;database=sqlserverdb" \
#     com.microsoft.sqlserver.jdbc.SQLServerDriver sa PASSWORD 1 1 15 Server "ManagedServer1"
