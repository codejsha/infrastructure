#!/bin/bash

source ./env-base.sh
source ./env-instance.sh

######################################################################

### replace pattern with string
TEMP="\${CATALINA_HOME}"
VAR_CATALINA_BASE="${CATALINA_BASE/${CATALINA_HOME}/${TEMP}}"
TEMP="\${INSTANCE_NAME}"
VAR_CATALINA_BASE="${VAR_CATALINA_BASE/${INSTANCE_NAME}/${TEMP}}"
TEMP="\${CATALINA_BASE}"
VAR_LOG_DIR="${LOG_DIR/${CATALINA_BASE}/${TEMP}}"

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
export CATALINA_OUT="\${LOG_DIR}/catalina.out"
export CATALINA_PID="\${CATALINA_BASE}/tomcat.pid"

CURRENT_USER="\$(id -un)"
if [ "\${CURRENT_USER}" == "root" ]; then
  echo "[ERROR] The current user is root!"
  exit
fi

CATALINA_OPTS="\${CATALINA_OPTS} -D\${INSTANCE_NAME}"
CATALINA_OPTS="\${CATALINA_OPTS} -Xms1024m -Xmx1024m"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:NewSize=384m -XX:MaxNewSize=384m"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m"
EOF

if [[ ${JAVA_VERSION} =~ ^1.8 ]]; then
cat <<EOF >> ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+UseParallelGC"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:-UseAdaptiveSizePolicy"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+DisableExplicitGC"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintGCDetails"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintGCDateStamps"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintGCTimeStamps"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintHeapAtGC"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintTenuringDistribution"
CATALINA_OPTS="\${CATALINA_OPTS} -Xloggc:\${LOG_DIR}/gc.\${INSTANCE_NAME}.log"
# CATALINA_OPTS="\${CATALINA_OPTS} -XX:+UseGCLogFileRotation"
# CATALINA_OPTS="\${CATALINA_OPTS} -XX:+NumberOfGCLogFiles=30"
# CATALINA_OPTS="\${CATALINA_OPTS} -XX:+GCLogFileSize=8K"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:HeapDumpPath=\${LOG_DIR}/dump"
export CATALINA_OPTS
EOF
elif [[ ${JAVA_VERSION} =~ ^11 ]]; then
cat <<EOF >> ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh
# CATALINA_OPTS="\${CATALINA_OPTS} -XX:+UseParallelGC"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+UseG1GC"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:MaxGCPauseMillis=200"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:InitiatingHeapOccupancyPercent=45"
CATALINA_OPTS="\${CATALINA_OPTS} -Xlog:gc*=info:file=\${LOG_DIR}/gc.\${INSTANCE_NAME}.log:time,pid,tid,level,tags"
# CATALINA_OPTS="\${CATALINA_OPTS} -Xlog:gc*=info:file=\${LOG_DIR}/gc.\${INSTANCE_NAME}.log:time,pid,tid,level,tags:filecount=30,filesize=8K"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"
CATALINA_OPTS="\${CATALINA_OPTS} -XX:HeapDumpPath=\${LOG_DIR}/dump"
export CATALINA_OPTS
EOF
fi

cat <<EOF >> ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh

CATALINA_OPTS="\${CATALINA_OPTS} -Djava.net.preferIPv4Stack=true"
CATALINA_OPTS="\${CATALINA_OPTS} -Djava.net.preferIPv6Addresses=false"
CATALINA_OPTS="\${CATALINA_OPTS} -Djava.security.egd=file:///dev/urandom"
export CATALINA_OPTS

EOF

if [[ ${JAVA_VERSION} =~ ^1.8 ]]; then
cat <<EOF >> ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh
# CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintFlagsFinal"
# CATALINA_OPTS="\${CATALINA_OPTS} -verbose:class"
# CATALINA_OPTS="\${CATALINA_OPTS} -verbose:module"
# CATALINA_OPTS="\${CATALINA_OPTS} -verbose:jni"
# export CATALINA_OPTS
EOF
elif [[ ${JAVA_VERSION} =~ ^11 ]]; then
cat <<EOF >> ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh
# CATALINA_OPTS="\${CATALINA_OPTS} -XX:+PrintFlagsFinal"
# CATALINA_OPTS="\${CATALINA_OPTS} -Xlog:class+load=info,class+unload=info:stdout:time,level,tags"
# CATALINA_OPTS="\${CATALINA_OPTS} -Xlog:module*=info:stdout:time,level,tags"
# CATALINA_OPTS="\${CATALINA_OPTS} -verbose:jni"
# export CATALINA_OPTS
EOF
fi

cat <<EOF >> ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh

# CATALINA_OPTS="\${CATALINA_OPTS} -Dcom.sun.management.jmxremote"
# CATALINA_OPTS="\${CATALINA_OPTS} -Dcom.sun.management.jmxremote.port=${TOMCAT_JMX_PORT}"
# CATALINA_OPTS="\${CATALINA_OPTS} -Dcom.sun.management.jmxremote.ssl=false"
# CATALINA_OPTS="\${CATALINA_OPTS} -Dcom.sun.management.jmxremote.authenticate=false"
# export CATALINA_OPTS

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

### change file permissions
chmod 750 ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh
chmod 750 ${CATALINA_BASE}/stop-${INSTANCE_NAME}.sh
chmod 750 ${CATALINA_BASE}/check-config.sh
chmod 750 ${CATALINA_BASE}/get-version.sh

### create symbolic link
ln -snf ${CATALINA_BASE}/start-${INSTANCE_NAME}.sh \
    ${CATALINA_HOME}/start-${INSTANCE_NAME}.sh
ln -snf ${CATALINA_BASE}/stop-${INSTANCE_NAME}.sh \
    ${CATALINA_HOME}/stop-${INSTANCE_NAME}.sh
