#!/bin/bash

source ./env-base.sh
source ./env-function.sh
source ./env-redisson.sh

######################################################################

### create catalina base
mkdir -p ${CATALINA_BASE}
/usr/bin/cp -rpf ${CATALINA_HOME}/conf ${CATALINA_BASE}
/usr/bin/cp -rpf ${CATALINA_HOME}/lib ${CATALINA_BASE}
/usr/bin/cp -rpf ${CATALINA_HOME}/temp ${CATALINA_BASE}
/usr/bin/cp -rpf ${CATALINA_HOME}/work ${CATALINA_BASE}
mkdir -p ${CATALINA_BASE}/webapps/ROOT
mkdir -p ${LOG_DIR}
mkdir -p ${DUMP_LOG_DIR}

######################################################################

### copy config files
envsubst < ./server-cluster-redis.xml > ${CATALINA_BASE}/conf/server.xml
envsubst < ./context-redis.xml > ${CATALINA_BASE}/conf/context.xml
envsubst < ./tomcat-users.xml > ${CATALINA_BASE}/conf/tomcat-users.xml

# /usr/bin/cp -pf ./server-cluster-redis.xml ${CATALINA_BASE}/conf/server.xml
# /usr/bin/cp -pf ./context-redis.xml ${CATALINA_BASE}/conf/context.xml
# /usr/bin/cp -pf ./tomcat-users.xml ${CATALINA_BASE}/conf/tomcat-users.xml

######################################################################

### copy redisson config file
if [ "${REDISSON_MODE}" == "CLUSTER_MODE" ]; then
    /usr/bin/cp -pf ./redisson-cluster.yaml ${CATALINA_BASE}/conf/redisson.yaml
elif [ "${REDISSON_MODE}" == "MASTER_SLAVE_MODE" ]; then
    /usr/bin/cp -pf ./redisson-master-slave.yaml ${CATALINA_BASE}/conf/redisson.yaml
elif [ "${REDISSON_MODE}" == "SINGLE_MODE" ]; then
    /usr/bin/cp -pf ./redisson-single.yaml ${CATALINA_BASE}/conf/redisson.yaml
fi

######################################################################

### format xml
# tidy_indent ${CATALINA_BASE}/conf/server.xml
# tidy_indent ${CATALINA_BASE}/conf/context.xml
# tidy_indent ${CATALINA_BASE}/conf/tomcat-users.xml
# tidy_indent ${CATALINA_BASE}/conf/redisson.yaml
# tidy_nowrap ${CATALINA_BASE}/conf/server.xml
# tidy_nowrap ${CATALINA_BASE}/conf/context.xml
# tidy_nowrap ${CATALINA_BASE}/conf/tomcat-users.xml
# tidy_nowrap ${CATALINA_BASE}/conf/redisson.yaml

### change permission
find ${CATALINA_BASE}/conf -type f | xargs chmod 600

######################################################################

echo "[INFO] An instance (${INSTANCE_NAME}) is created."
