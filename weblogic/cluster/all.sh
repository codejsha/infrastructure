#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

######################################################################
### CLUSTER
######################################################################

### CREATE CLUSTER
### bash ./create-cluster.sh ${CLUSTER_NAME}

bash ./create-cluster.sh BaseCluster1
# bash ./create-cluster.sh BaseCluster2

######################################################################

### CONFIGURE CLUSTER
### bash ./set-cluster-config.sh ${CLUSTER_NAME} ${TRANSMISSION}
### bash ./set-cluster-config.sh ${CLUSTER_NAME} ${TRANSMISSION} ${MULTICAST_ADDRESS} ${MULTICAST_PORT}

bash ./set-cluster-config.sh BaseCluster1 unicast
# bash ./set-cluster-config.sh BaseCluster2 unicast
# bash ./set-cluster-config.sh BaseCluster1 multicast 239.192.0.0 7001
# bash ./set-cluster-config.sh BaseCluster2 multicast 239.192.0.0 7001




######################################################################
### CLUSTER - JMS
######################################################################

### CREATE CLUSTER
### bash ./create-cluster.sh ${CLUSTER_NAME}

# bash ./create-cluster.sh BaseJmsCluster1
# bash ./create-cluster.sh BaseJmsCluster2

######################################################################

### CONFIGURE CLUSTER
### bash ./set-cluster-config.sh ${CLUSTER_NAME} ${TRANSMISSION}
### bash ./set-cluster-config.sh ${CLUSTER_NAME} ${TRANSMISSION} ${MULTICAST_ADDRESS} ${MULTICAST_PORT}

# bash ./set-cluster-config.sh BaseJmsCluster1 unicast
# bash ./set-cluster-config.sh BaseJmsCluster2 unicast
# bash ./set-cluster-config.sh BaseJmsCluster1 multicast 239.192.0.0 7001
# bash ./set-cluster-config.sh BaseJmsCluster2 multicast 239.192.0.0 7001
