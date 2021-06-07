#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### Requiremets:
### Servers and Clusters (for JMS configurations)

source ../env-base.sh

######################################################################
### FILESTORE
######################################################################

### CREATE FILESTORE
### bash ./create-filestore.sh ${FILESTORE_NAME} ${FILESTORE_DIR} ${FILESTORE_TARGET}

bash ./create-filestore.sh BaseFileStore1 ${DOMAIN_HOME}/filestore/BaseFileStore1 JmsManagedServer1
bash ./create-filestore.sh BaseFileStore2 ${DOMAIN_HOME}/filestore/BaseFileStore2 JmsManagedServer2




######################################################################
### JMSSERVER
######################################################################

### CREATE JMSSERVER
### bash ./create-jms-server.sh ${JMSSERVER_NAME} ${JMSSERVER_STORE} ${JMSSERVER_TARGET}

bash ./create-jms-server.sh BaseJmsServer1 BaseFileStore1 JmsManagedServer1
bash ./create-jms-server.sh BaseJmsServer2 BaseFileStore2 JmsManagedServer2




######################################################################
### JMSMODULE
######################################################################

### CREATE JMSMODULE
### bash ./create-jms-module.sh ${JMSMODULE_NAME} ${JMSMODULE_TARGET_TYPE} ${JMSMODULE_TARGET}

bash ./create-jms-module.sh BaseSystemModule1 Cluster "BaseJmsCluster1"
# bash ./create-jms-module.sh BaseSystemModule1 Cluster "BaseJmsCluster2"
# bash ./create-jms-module.sh BaseSystemModule1 Cluster "BaseJmsCluster1,BaseJmsCluster2"
# bash ./create-jms-module.sh BaseSystemModule1 Server "JmsManagedServer1"
# bash ./create-jms-module.sh BaseSystemModule1 Server "JmsManagedServer2"
# bash ./create-jms-module.sh BaseSystemModule1 Server "JmsManagedServer1,JmsManagedServer2"

######################################################################

### CREATE JMSMODULE SUBDEPLOY
### bash ./create-jms-module-subdeploy.sh ${JMSMODULE_NAME} ${SUBDEPLOY_NAME} ${SUBDEPLOY_TARGET_TYPE} ${SUBDEPLOY_TARGET}

bash ./create-jms-module-subdeploy.sh BaseSystemModule1 BaseSubdeployment1
# bash ./create-jms-module-subdeploy.sh BaseSystemModule1 BaseSubdeployment1 Cluster "BaseJmsCluster1,BaseJmsCluster2"
# bash ./create-jms-module-subdeploy.sh BaseSystemModule1 BaseSubdeployment1 Cluster "BaseJmsCluster1"
# bash ./create-jms-module-subdeploy.sh BaseSystemModule1 BaseSubdeployment1 Cluster "BaseJmsCluster2"
# bash ./create-jms-module-subdeploy.sh BaseSystemModule1 BaseSubdeployment1 Server "JmsManagedServer1,JmsManagedServer2"
# bash ./create-jms-module-subdeploy.sh BaseSystemModule1 BaseSubdeployment1 Server "JmsManagedServer1"
# bash ./create-jms-module-subdeploy.sh BaseSystemModule1 BaseSubdeployment1 Server "JmsManagedServer2"
bash ./create-jms-module-subdeploy.sh BaseSystemModule1 BaseSubdeployment1 JMSServer "BaseJmsServer1,BaseJmsServer2"
# bash ./create-jms-module-subdeploy.sh BaseSystemModule1 BaseSubdeployment1 JMSServer "BaseJmsServer1"
# bash ./create-jms-module-subdeploy.sh BaseSystemModule1 BaseSubdeployment1 JMSServer "BaseJmsServer2"

######################################################################

### CREATE JMSMODULE CONNECTION FACTORY
### bash ./create-jms-module-conn-factory.sh ${JMSMODULE_NAME} ${CONNFACTORY_NAME} ${CONNFACTORY_JNDI} ${SUBDEPLOY_NAME}

# bash ./create-jms-module-conn-factory.sh BaseSystemModule1 BaseConnectionFactory1 "basemodule1/connfactory1"
bash ./create-jms-module-conn-factory.sh BaseSystemModule1 BaseConnectionFactory1 "basemodule1/connfactory1" BaseSubdeployment1
# bash ./create-jms-module-conn-factory.sh BaseSystemModule1 BaseConnectionFactory2 "basemodule1/connfactory2" BaseSubdeployment2

######################################################################

### CREATE JMSMODULE DISTRIBUTED QUEUE
### bash ./create-jms-module-dist-queue.sh ${JMSMODULE_NAME} ${DISTQUEUE_NAME} ${DISTQUEUE_JNDI} ${SUBDEPLOY_NAME}

# bash ./create-jms-module-dist-queue.sh BaseSystemModule1 BaseDistributedQueue1 "basemodule1/distqueue1"
bash ./create-jms-module-dist-queue.sh BaseSystemModule1 BaseDistributedQueue1 "basemodule1/distqueue1" BaseSubdeployment1
# bash ./create-jms-module-dist-queue.sh BaseSystemModule1 BaseDistributedQueue2 "basemodule1/distqueue2" BaseSubdeployment2

######################################################################

### CREATE JMSMODULE DISTRIBUTED TOPIC
### bash ./create-jms-module-dist-topic.sh ${JMSMODULE_NAME} ${DISTTOPIC_NAME} ${DISTTOPIC_JNDI} ${SUBDEPLOY_NAME}

# bash ./create-jms-module-dist-topic.sh BaseSystemModule1 BaseDistributedTopic1 "basemodule1/disttopic1"
bash ./create-jms-module-dist-topic.sh BaseSystemModule1 BaseDistributedTopic1 "basemodule1/disttopic1" BaseSubdeployment1
# bash ./create-jms-module-dist-topic.sh BaseSystemModule1 BaseDistributedTopic2 "basemodule1/disttopic2" BaseSubdeployment2
