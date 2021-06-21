#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh
source ./env-instance.sh

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
envsubst < ./server.xml > ${CATALINA_BASE}/conf/server.xml
envsubst < ./context.xml > ${CATALINA_BASE}/conf/Catalina/localhost/ROOT.xml
envsubst < ./tomcat-users.xml > ${CATALINA_BASE}/conf/tomcat-users.xml

# /bin/cp -pf ./server.xml ${CATALINA_BASE}/conf/server.xml
# /bin/cp -pf ./context.xml ${CATALINA_BASE}/conf/context.xml
# /bin/cp -pf ./tomcat-users.xml ${CATALINA_BASE}/conf/tomcat-users.xml

######################################################################

### change permission
find ${CATALINA_BASE}/conf -type f | xargs chmod 600

######################################################################

echo "[INFO] An instance (${INSTANCE_NAME}) is created."
