#!/bin/bash

source ./env-base.sh

######################################################################

### replace pattern with string
TEMP="\${CATALINA_HOME}"
VAR_CATALINA_BASE="${CATALINA_BASE/${CATALINA_HOME}/${TEMP}}"
TEMP="\${INSTANCE_NAME}"
VAR_CATALINA_BASE="${CATALINA_BASE/${INSTANCE_NAME}/${TEMP}}"
TEMP="\${CATALINA_BASE}"
VAR_LOG_DIR="${LOG_DIR/${CATALINA_BASE}/${TEMP}}"
TEMP="\${LOG_DIR}"
VAR_DUMP_LOG_DIR="${DUMP_LOG_DIR/${LOG_DIR}/${TEMP}}"
TEMP="\${LOG_DIR}"
VAR_CATALINA_OUT="${CATALINA_OUT/${LOG_DIR}/${TEMP}}"
TEMP="\${LOG_DIR}"
VAR_GC_LOG_OUT="${GC_LOG_OUT/${LOG_DIR}/${TEMP}}"
TEMP="\${INSTANCE_NAME}"
VAR_GC_LOG_OUT="${VAR_GC_LOG_OUT/${INSTANCE_NAME}/${TEMP}}"

######################################################################

### create start script
cat <<EOF > ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh
#!/bin/bash

INSTANCE_NAME="${INSTANCE_NAME}"
export JAVA_HOME="${JAVA_HOME}"
export CATALINA_HOME="${CATALINA_HOME}"
export CATALINA_BASE="${VAR_CATALINA_BASE}"

LOG_DIR="${VAR_LOG_DIR}"
GET_DATE="\$(date +'%Y%m%d-%H%M%S')"
export CATALINA_OUT="${VAR_CATALINA_OUT}"
export CATALINA_PID="\${CATALINA_BASE}/tomcat.pid"

CATALINA_OPTS="\${CATALINA_OPTS} -D\${INSTANCE_NAME}"
CATALINA_OPTS="\${CATALINA_OPTS} -Xms1024m -Xmx1024m"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:NewSize=384m -XX:MaxNewSize=384m"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m"
EOF

if [[ ${JAVA_VERSION} =~ ^1.8 ]]; then
cat <<EOF >> ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh
CATALINA_OPTS="\${CATALINA_OPTS} -Xloggc:${VAR_GC_LOG_OUT}"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintGCDetails"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintTenuringDistribution"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintGCDateStamps"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintGCTimeStamps"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:HeapDumpPath=${VAR_DUMP_LOG_DIR}"
# CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintFlagsFinal"
# CATALINA_OPTS="\${CATALINA_OPTS} -verbose:class"
# CATALINA_OPTS="\${CATALINA_OPTS} -verbose:module"
# CATALINA_OPTS="\${CATALINA_OPTS} -verbose:jni"
export CATALINA_OPTS
EOF
elif [[ ${JAVA_VERSION} =~ ^11 ]]; then
cat <<EOF >> ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh
CATALINA_OPTS="\${CATALINA_OPTS} -Xlog:gc*=info:file=${VAR_GC_LOG_OUT}:time,pid,tid,level,tags"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:HeapDumpPath=${VAR_DUMP_LOG_DIR}"
# CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintFlagsFinal"
# CATALINA_OPTS="\${CATALINA_OPTS} -Xlog:class+load=info,class+unload=info:stdout:time,level,tags"
# CATALINA_OPTS="\${CATALINA_OPTS} -Xlog:module*=info:stdout:time,level,tags"
# CATALINA_OPTS="\${CATALINA_OPTS} -verbose:jni"
export CATALINA_OPTS
EOF
fi

cat <<EOF >> ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh

# CATALINA_OPTS="\${CATALINA_OPTS} -Dcom.sun.management.jmxremote"
# CATALINA_OPTS="\${CATALINA_OPTS} -Dcom.sun.management.jmxremote.port=${TOMCAT_JMX_PORT}"
# CATALINA_OPTS="\${CATALINA_OPTS} -Dcom.sun.management.jmxremote.ssl=false"
# CATALINA_OPTS="\${CATALINA_OPTS} -Dcom.sun.management.jmxremote.authenticate=false"
export CATALINA_OPTS

touch \${CATALINA_OUT}
\${CATALINA_HOME}/bin/startup.sh
tail -f \${CATALINA_OUT}
EOF

######################################################################

### create stop script
cat <<EOF > ${CATALINA_BASE}/stop-${INSTANCE_NAME}.sh
#!/bin/bash

INSTANCE_NAME="${INSTANCE_NAME}"
export JAVA_HOME="${JAVA_HOME}"
export CATALINA_HOME="${CATALINA_HOME}"
export CATALINA_BASE="${CATALINA_BASE}"

\${CATALINA_HOME}/bin/shutdown.sh
EOF

######################################################################

### create configtest script
cat <<EOF > ${CATALINA_BASE}/check-config.sh
#!/bin/bash

INSTANCE_NAME="${INSTANCE_NAME}"
export CATALINA_HOME="${CATALINA_HOME}"
export CATALINA_BASE="${VAR_CATALINA_BASE}"

\${CATALINA_HOME}/bin/configtest.sh
EOF

######################################################################

### create version script
cat <<EOF > ${CATALINA_BASE}/get-version.sh
#!/bin/bash

INSTANCE_NAME="${INSTANCE_NAME}"
export CATALINA_HOME="${CATALINA_HOME}"
export CATALINA_BASE="${VAR_CATALINA_BASE}"

\${CATALINA_HOME}/bin/version.sh
EOF

######################################################################

### change permission
chmod 750 ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh
chmod 750 ${CATALINA_BASE}/stop-${INSTANCE_NAME}.sh
chmod 750 ${CATALINA_BASE}/check-config.sh
chmod 750 ${CATALINA_BASE}/get-version.sh

### create symbolic link
ln -snf ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh \
    ${CATALINA_HOME}/start-${INSTANCE_NAME}.sh
ln -snf ${CATALINA_BASE}/stop-${INSTANCE_NAME}.sh \
    ${CATALINA_HOME}/stop-${INSTANCE_NAME}.sh
