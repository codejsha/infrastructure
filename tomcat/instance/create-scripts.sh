#!/usr/bin/bash

source ../env-base.sh

######################################################################

### create start script
cat <<EOF > ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh
#!/usr/bin/bash

INSTANCE_NAME="${INSTANCE_NAME}"
export JAVA_HOME="${JAVA_HOME}"
export CATALINA_HOME="${CATALINA_HOME}"
export CATALINA_BASE="${CATALINA_BASE}"

LOG_DIR="${LOG_DIR}"
GET_DATE="\$(date +'%Y%m%d-%H%M%S')"
export CATALINA_OUT="${CATALINA_OUT}"
export CATALINA_PID="\${CATALINA_BASE}/tomcat.pid"

CATALINA_OPTS="\${CATALINA_OPTS} -Xms1024m -Xmx1024m"
EOF

if [[ ${JAVA_VERSION} =~ ^1.8 ]]; then
cat <<EOF >> ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh
CATALINA_OPTS="\${CATALINA_OPTS} -Xloggc:${GC_LOG_OUT}"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintGCDetails"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintTenuringDistribution"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintGCDateStamps"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintGCTimeStamps"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:HeapDumpPath=${DUMP_LOG_DIR}"
# CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintFlagsFinal"
# CATALINA_OPTS="\${CATALINA_OPTS} -verbose:class"
# CATALINA_OPTS="\${CATALINA_OPTS} -verbose:module"
# CATALINA_OPTS="\${CATALINA_OPTS} -verbose:jni"
export CATALINA_OPTS
EOF
elif [[ ${JAVA_VERSION} =~ ^11 ]]; then
cat <<EOF >> ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh
CATALINA_OPTS="\${CATALINA_OPTS} -Xlog:gc*=info:file=${GC_LOG_OUT}:time,pid,tid,level,tags"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:HeapDumpPath=${DUMP_LOG_DIR}"
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
tail -f ${CATALINA_OUT}
EOF

######################################################################

### create stop script
cat <<EOF > ${CATALINA_BASE}/stop-${INSTANCE_NAME}.sh
#!/usr/bin/bash

INSTANCE_NAME="${INSTANCE_NAME}"
export JAVA_HOME="${JAVA_HOME}"
export CATALINA_HOME="${CATALINA_HOME}"
export CATALINA_BASE="${CATALINA_BASE}"

\${CATALINA_HOME}/bin/shutdown.sh
EOF

######################################################################

### create version script
cat <<EOF > ${CATALINA_HOME}/bin/get-version.sh
#!/usr/bin/bash

export CATALINA_HOME="${CATALINA_HOME}"

\${CATALINA_HOME}/bin/version.sh
EOF

######################################################################

### create configtest script
cat <<EOF > ${CATALINA_HOME}/bin/check-config.sh
#!/usr/bin/bash

export CATALINA_HOME="${CATALINA_HOME}"

\${CATALINA_HOME}/bin/configtest.sh
EOF

######################################################################

### change permission
chmod 750 ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh
chmod 750 ${CATALINA_BASE}/stop-${INSTANCE_NAME}.sh

### create symbolic link
ln -snf ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh \
    ${CATALINA_HOME}/start-${INSTANCE_NAME}.sh
ln -snf ${CATALINA_BASE}/stop-${INSTANCE_NAME}.sh \
    ${CATALINA_HOME}/stop-${INSTANCE_NAME}.sh
