#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh
source ./env-instance.sh
source ./env-redisson.sh

######################################################################

### create catalina base
mkdir -p ${CATALINA_BASE}
/bin/cp -rpf ${CATALINA_HOME}/conf ${CATALINA_BASE}
/bin/cp -rpf ${CATALINA_HOME}/lib ${CATALINA_BASE}
/bin/cp -rpf ${CATALINA_HOME}/temp ${CATALINA_BASE}
/bin/cp -rpf ${CATALINA_HOME}/work ${CATALINA_BASE}
mkdir -p ${CATALINA_BASE}/conf/Catalina/localhost
mkdir -p ${CATALINA_BASE}/webapps/ROOT
mkdir -p ${LOG_DIR}
mkdir -p ${DUMP_LOG_DIR}

######################################################################

### copy config files
envsubst < ./server-cluster-full.xml > ${CATALINA_BASE}/conf/server.xml
envsubst < ./context-redis.xml > ${CATALINA_BASE}/conf/Catalina/localhost/ROOT.xml
envsubst < ./tomcat-users.xml > ${CATALINA_BASE}/conf/tomcat-users.xml

# /bin/cp -pf ./server-cluster-redis.xml ${CATALINA_BASE}/conf/server.xml
# /bin/cp -pf ./context-redis.xml ${CATALINA_BASE}/conf/context.xml
# /bin/cp -pf ./tomcat-users.xml ${CATALINA_BASE}/conf/tomcat-users.xml

######################################################################

### copy redisson config file
if [ "${REDISSON_MODE}" == "CLUSTER_MODE" ]; then
    /bin/cp -pf ./redisson-cluster.yaml ${CATALINA_BASE}/conf/redisson.yaml
elif [ "${REDISSON_MODE}" == "MASTER_SLAVE_MODE" ]; then
    /bin/cp -pf ./redisson-master-slave.yaml ${CATALINA_BASE}/conf/redisson.yaml
elif [ "${REDISSON_MODE}" == "SINGLE_MODE" ]; then
    /bin/cp -pf ./redisson-single.yaml ${CATALINA_BASE}/conf/redisson.yaml
fi

######################################################################

### change permission
find ${CATALINA_BASE}/conf -type f | xargs chmod 600

######################################################################

echo "[INFO] An instance (${INSTANCE_NAME}) is created."
