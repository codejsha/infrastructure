#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

######################################################################
### ADMIN SERVER
######################################################################

### CONFIGURE ADMIN SERVER
### bash ./set-server-config.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT}
### bash ./set-server-config.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT} ${CLUSTER_NAME}
### bash ./set-server-config.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT} ${CLUSTER_NAME} ${NODEMGR_NAME}

bash ./set-server-config.sh AdminServer test.example.com 7001

######################################################################

### CREATE SCRIPTS

bash ./create-boot-properties.sh
bash ./create-change-password-script.sh
bash ./create-change-store-user-config-script.sh

### bash ./create-admin-scripts.sh ${SERVER_NAME}
bash ./create-admin-scripts.sh AdminServer

### bash ./create-store-user-config-admin-scripts.sh ${SERVER_NAME}
bash ./create-store-user-config-admin-scripts.sh AdminServer




######################################################################
### SERVER
######################################################################

### CREATE SERVER
### bash ./create-server.sh ${MANAGED_SERVER_NAME}

bash ./create-server.sh ManagedServer1
bash ./create-server.sh ManagedServer2
# bash ./create-server.sh ManagedServer3
# bash ./create-server.sh ManagedServer4

######################################################################

### CONFIGURE SERVER
### bash ./set-server-config.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT}
### bash ./set-server-config.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT} ${CLUSTER_NAME}
### bash ./set-server-config.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT} ${CLUSTER_NAME} ${NODEMGR_NAME}

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

######################################################################

### CREATE SCRIPTS

### bash ./create-managed-scripts.sh ${SERVER_NAME}

bash ./create-managed-scripts.sh ManagedServer1
bash ./create-managed-scripts.sh ManagedServer2
# bash ./create-managed-scripts.sh ManagedServer3
# bash ./create-managed-scripts.sh ManagedServer4

### bash ./create-store-user-config-managed-scripts.sh ${SERVER_NAME}

bash ./create-store-user-config-managed-scripts.sh ManagedServer1
bash ./create-store-user-config-managed-scripts.sh ManagedServer2
# bash ./create-store-user-config-managed-scripts.sh ManagedServer3
# bash ./create-store-user-config-managed-scripts.sh ManagedServer4




######################################################################
### SERVER - JMS
######################################################################

### CREATE SERVER
### bash ./create-server.sh ${MANAGED_SERVER_NAME}

# bash ./create-server.sh JmsManagedServer1
# bash ./create-server.sh JmsManagedServer2

######################################################################

### CONFIGURE SERVER
### bash ./set-server-config.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT}
### bash ./set-server-config.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT} ${CLUSTER_NAME}
### bash ./set-server-config.sh ${MANAGED_SERVER_NAME} ${MANAGED_SERVER_ADDRESS} ${MANAGED_SERVER_PORT} ${CLUSTER_NAME} ${NODEMGR_NAME}

# bash ./set-server-config.sh JmsManagedServer1 test.example.com 7103 BaseJmsCluster1
# bash ./set-server-config.sh JmsManagedServer2 test.example.com 7104 BaseJmsCluster1

######################################################################

### CREATE SCRIPTS

### bash ./create-managed-scripts.sh ${SERVER_NAME}

# bash ./create-managed-scripts.sh JmsManagedServer1
# bash ./create-managed-scripts.sh JmsManagedServer2

### bash ./create-store-user-config-managed-scripts.sh ${SERVER_NAME}

# bash ./create-store-user-config-managed-scripts.sh ManagedServer1
# bash ./create-store-user-config-managed-scripts.sh ManagedServer2
