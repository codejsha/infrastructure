#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh
source ./env-instance.sh
# source ./env-function.sh

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
envsubst < ./context.xml > ${CATALINA_BASE}/conf/Catalina/localhost/ROOT.xml
envsubst < ./tomcat-users.xml > ${CATALINA_BASE}/conf/tomcat-users.xml

# /bin/cp -pf ./server-cluster-full.xml ${CATALINA_BASE}/conf/server.xml
# /bin/cp -pf ./context.xml ${CATALINA_BASE}/conf/context.xml
# /bin/cp -pf ./tomcat-users.xml ${CATALINA_BASE}/conf/tomcat-users.xml

######################################################################

### format xml
# tidy_indent ${CATALINA_BASE}/conf/server.xml
# tidy_indent ${CATALINA_BASE}/conf/context.xml
# tidy_indent ${CATALINA_BASE}/conf/tomcat-users.xml
# tidy_nowrap ${CATALINA_BASE}/conf/server.xml
# tidy_nowrap ${CATALINA_BASE}/conf/context.xml
# tidy_nowrap ${CATALINA_BASE}/conf/tomcat-users.xml

### change permission
find ${CATALINA_BASE}/conf -type f | xargs chmod 600

######################################################################

echo "[INFO] An instance (${INSTANCE_NAME}) is created."
