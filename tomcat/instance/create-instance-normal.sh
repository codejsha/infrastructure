#!/usr/bin/bash

source ./env-base.sh
source ./env-function.sh

### create catalina base
mkdir -p ${CATALINA_BASE}
/usr/bin/cp -rpf ${CATALINA_HOME}/conf ${CATALINA_BASE}
/usr/bin/cp -rpf ${CATALINA_HOME}/lib ${CATALINA_BASE}
/usr/bin/cp -rpf ${CATALINA_HOME}/temp ${CATALINA_BASE}
/usr/bin/cp -rpf ${CATALINA_HOME}/work ${CATALINA_BASE}
mkdir -p ${CATALINA_BASE}/webapps/ROOT
mkdir -p "$(eval echo ${LOG_DIR})"
mkdir -p "$(eval echo $(eval echo ${DUMP_LOG_DIR}))"

######################################################################

### copy config files
mv ${CATALINA_BASE}/conf/server.xml ${CATALINA_BASE}/conf/server.xml_default
mv ${CATALINA_BASE}/conf/context.xml ${CATALINA_BASE}/conf/context.xml_default
# mv ${CATALINA_BASE}/conf/tomcat-users.xml ${CATALINA_BASE}/conf/tomcat-users.xml_default

envsubst < ./server.xml > ${CATALINA_BASE}/conf/server.xml
envsubst < ./context.xml > ${CATALINA_BASE}/conf/context.xml
# envsubst < ./tomcat-users.xml > ${CATALINA_BASE}/conf/tomcat-users.xml

# /usr/bin/cp -pf ./server.xml ${CATALINA_BASE}/conf/server.xml
# /usr/bin/cp -pf ./context.xml ${CATALINA_BASE}/conf/context.xml
# /usr/bin/cp -pf ./tomcat-users.xml ${CATALINA_BASE}/conf/tomcat-users.xml

######################################################################

### format xml
# tidy_indent ${CATALINA_BASE}/conf/server.xml
# tidy_indent ${CATALINA_BASE}/conf/context.xml
# tidy_nowrap ${CATALINA_BASE}/conf/server.xml
# tidy_nowrap ${CATALINA_BASE}/conf/context.xml

### change permission
chmod 600 ${CATALINA_BASE}/conf/server.xml
chmod 600 ${CATALINA_BASE}/conf/context.xml

######################################################################

echo "An instance (${INSTANCE_NAME}) is created."