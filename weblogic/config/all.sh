#!/bin/bash

bash ./print-env-base-info.sh

######################################################################

### CREATE SCRIPTS

bash ./create-boot-properties.sh
bash ./create-change-password-script.sh
bash ./create-change-store-user-config-script.sh
bash ./create-encrypt-password-script.sh
bash ./create-regen-demo-identity-script.sh

######################################################################

### CONFIG DOMAIN

bash ./conf-domain.sh
bash ./set-domain-config-archive.sh
# bash ./set-domain-connection-filter.sh
bash ./set-domain-cookie-name.sh
bash ./set-domain-jta.sh
bash ./set-domain-log.sh
# bash ./set-domain-output-compression.sh
bash ./set-domain-restful-mgmt-service.sh
bash ./set-domain-web-app.sh

######################################################################

### CONFIG ADMIN SERVER

bash ./set-server-config.sh AdminServer test.example.com 7001
bash ./create-admin-scripts.sh AdminServer

######################################################################

### CREATE NODEMANAGER
### bash ./create-nodemgr.sh ${NODEMGR_NAME}
### bash ./set-nodemgr-config.sh ${NODEMGR_NAME} ${NODEMGR_ADDRESS} ${NODEMGR_PORT}
### bash ./create-nodemgr-scripts.sh ${NODEMGR_NAME} ${NODEMGR_ADDRESS} ${NODEMGR_PORT}

bash ./create-nodemgr.sh BaseMachine1
# bash ./create-nodemgr.sh BaseMachine2
bash ./set-nodemgr-config.sh BaseMachine1 test.example.com 5556
# bash ./set-nodemgr-config.sh BaseMachine2 test.example.com 5557

bash ./create-nodemgr-scripts.sh BaseMachine1 test.example.com 5556
# bash ./create-nodemgr-scripts.sh BaseMachine2 test.example.com 5557

######################################################################

### CREATE CLUSTER
### bash ./create-cluster.sh ${CLUSTER_NAME}
### bash ./set-cluster-config.sh ${CLUSTER_NAME} ${UNICAST}
### bash ./set-cluster-config.sh ${CLUSTER_NAME} ${MULTICAST} ${MULTICAST_ADDRESS} ${MULTICAST_PORT}

bash ./create-cluster.sh BaseCluster1
# bash ./create-cluster.sh BaseCluster2
bash ./set-cluster-config.sh BaseCluster1 unicast
# bash ./set-cluster-config.sh BaseCluster2 unicast
# bash ./set-cluster-config.sh BaseCluster1 multicast 239.192.0.0 7001
# bash ./set-cluster-config.sh BaseCluster2 multicast 239.192.0.0 7001

######################################################################

### CREATE CLUSTER - JMS

# bash ./create-cluster.sh BaseJmsCluster1
# bash ./create-cluster.sh BaseJmsCluster2
# bash ./set-cluster-config.sh BaseJmsCluster1 unicast
# bash ./set-cluster-config.sh BaseJmsCluster2 unicast
# bash ./set-cluster-config.sh BaseJmsCluster1 multicast 239.192.0.0 7001
# bash ./set-cluster-config.sh BaseJmsCluster2 multicast 239.192.0.0 7001

######################################################################

### CREATE SERVER
### bash ./create-server.sh ${MANAGED_SERVER_NAME}
### bash ./set-server-config.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT}
### bash ./set-server-config.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT} ${CLUSTER_NAME}
### bash ./set-server-config.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT} ${CLUSTER_NAME} ${NODEMGR_NAME}
### bash ./create-managed-scripts.sh ${SERVER_NAME}
### bash ./create-store-user-config-scripts.sh ${SERVER_NAME}

bash ./create-server.sh ManagedServer1
bash ./create-server.sh ManagedServer2
# bash ./create-server.sh ManagedServer3
# bash ./create-server.sh ManagedServer4
# bash ./set-server-config.sh ManagedServer1 test.example.com 7003
# bash ./set-server-config.sh ManagedServer2 test.example.com 7004
# bash ./set-server-config.sh ManagedServer3 test.example.com 7005
# bash ./set-server-config.sh ManagedServer4 test.example.com 7006
# bash ./set-server-config.sh ManagedServer1 test.example.com 7003 BaseCluster1
# bash ./set-server-config.sh ManagedServer2 test.example.com 7004 BaseCluster1
# bash ./set-server-config.sh ManagedServer3 test.example.com 7005 BaseCluster2
# bash ./set-server-config.sh ManagedServer4 test.example.com 7006 BaseCluster2
bash ./set-server-config.sh ManagedServer1 test.example.com 7003 BaseCluster1 BaseMachine1
bash ./set-server-config.sh ManagedServer2 test.example.com 7004 BaseCluster1 BaseMachine1
# bash ./set-server-config.sh ManagedServer3 test.example.com 7005 BaseCluster2 BaseMachine2
# bash ./set-server-config.sh ManagedServer4 test.example.com 7006 BaseCluster2 BaseMachine2

bash ./create-managed-scripts.sh ManagedServer1
bash ./create-managed-scripts.sh ManagedServer2
# bash ./create-managed-scripts.sh ManagedServer3
# bash ./create-managed-scripts.sh ManagedServer4
bash ./create-store-user-config-scripts.sh ManagedServer1
bash ./create-store-user-config-scripts.sh ManagedServer2
# bash ./create-store-user-config-scripts.sh ManagedServer3
# bash ./create-store-user-config-scripts.sh ManagedServer4

######################################################################

### CREATE SERVER - JMS

# bash ./create-server.sh JmsManagedServer1
# bash ./create-server.sh JmsManagedServer2
# bash ./set-server-config.sh JmsManagedServer1 test.example.com 7103 BaseJmsCluster1
# bash ./set-server-config.sh JmsManagedServer2 test.example.com 7104 BaseJmsCluster1

# bash ./create-managed-scripts.sh JmsManagedServer1
# bash ./create-managed-scripts.sh JmsManagedServer2
# bash ./create-store-user-config-scripts.sh ManagedServer1
# bash ./create-store-user-config-scripts.sh ManagedServer2

######################################################################

### DEPLOY APPLICATION
### bash ./deploy-app.sh ${APP_NAME} ${APP_PATH} ${APP_TARGET}

bash ./deploy-app.sh failovertest /svc/app/failovertest BaseCluster1
bash ./deploy-app.sh cachetest /svc/app/cachetest BaseCluster1
bash ./deploy-app.sh jdbcdrivertest /svc/app/jdbcdrivertest BaseCluster1
# bash ./deploy-app.sh weblogic-versioned /svc/app/weblogic-versioned/deployversion1/sample.war BaseCluster1
# bash ./deploy-app.sh sample1 /svc/app/sample1 ManagedServer1
# bash ./deploy-app.sh sample2 /svc/app/sample2 ManagedServer2

######################################################################

### CREATE DATASOURCE
### bash ./set-datasource-config.sh ${DS_NAME}
### bash ./set-datasource-config.sh ${DS_NAME} ${DS_JNDI} ${DS_URL} \
###     ${DS_DRIVER} ${DS_USER} ${DS_PASSWORD} ${DS_INIT} ${DS_MIN} ${DS_MAX} ${DS_TARGET_TYPE} ${DS_TARGET}

### ORACLE DATABASE
bash ./create-datasource.sh BaseDataSource1
bash ./set-datasource-config.sh BaseDataSource1 "baseds1" "jdbc:oracle:thin:@test.example.com:1521:orclcdb" \
    oracle.jdbc.OracleDriver system PASSWORD 30 30 30 Cluster "BaseCluster1"
# bash ./set-datasource-config.sh BaseDataSource1 "baseds1" "jdbc:oracle:thin:@test.example.com:1521:orclcdb" \
#     oracle.jdbc.OracleDriver system PASSWORD 30 30 30 Server "ManagedServer1"

### MYSQL
# bash ./create-datasource.sh BaseDataSource2
# bash ./set-datasource-config.sh BaseDataSource2 "baseds2" "jdbc:mysql://test.example.com:3306/mysqldb" \
#     com.mysql.cj.jdbc.Driver mysql PASSWORD 30 30 30 Cluster "BaseCluster1"
# bash ./set-datasource-config.sh BaseDataSource2 "baseds2" "jdbc:mysql://test.example.com:3306/mysqldb" \
#     com.mysql.cj.jdbc.Driver mysql PASSWORD 30 30 30 Server "ManagedServer1"

### SQL SERVER
# bash ./create-datasource.sh BaseDataSource3
# bash ./set-datasource-config.sh BaseDataSource3 "baseds3" "jdbc:sqlserver://test.example.com:1433;database=sqlserverdb" \
#     com.microsoft.sqlserver.jdbc.SQLServerDriver sa PASSWORD 30 30 30 Cluster "BaseCluster1"
# bash ./set-datasource-config.sh BaseDataSource3 "baseds3" "jdbc:sqlserver://test.example.com:1433;database=sqlserverdb" \
#     com.microsoft.sqlserver.jdbc.SQLServerDriver sa PASSWORD 30 30 30 Server "ManagedServer1"
