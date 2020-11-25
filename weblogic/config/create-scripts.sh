#!/bin/bash

source ./env-base.sh

SERVER_NAME="${1}"

######################################################################

FILE_NAME_SUFFIX=""
if [ "${SERVER_NAME}" == "${ADMIN_SERVER_NAME}" ]; then
    FILE_NAME_SUFFIX="admin"
else
    FILE_NAME_SUFFIX=${SERVER_NAME,,}
    FILE_NAME_SUFFIX=${FILE_NAME_SUFFIX/base/}
    FILE_NAME_SUFFIX=${FILE_NAME_SUFFIX/server/}
fi

######################################################################

### start script

cat <<EOF > ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
#!/bin/bash

SERVER_NAME="${SERVER_NAME}"
EOF

if [ "${SERVER_NAME}" == "${ADMIN_SERVER_NAME}" ]; then
cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
ADMIN_URL="t3://${ADMIN_SERVER_LISTEN_ADDRESS}:${ADMIN_SERVER_LISTEN_PORT}"
EOF
fi

cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
DOMAIN_HOME="${DOMAIN_HOME}"
LOG_DIR="${LOG_DIR}"
GET_DATE="\$(date +'%Y%m%d_%H%M%S')"

PID="\$(pgrep -xa java | grep \${DOMAIN_HOME} | grep \${SERVER_NAME} | awk '{print \$1}')"
if [ -n "\${PID}" ]; then
  echo "[ERROR] \${SERVER_NAME} (pid \${PID})" is already running!
  exit
fi

USER_MEM_ARGS="-D\${SERVER_NAME}"
USER_MEM_ARGS="\${USER_MEM_ARGS} -Xms1024m"
USER_MEM_ARGS="\${USER_MEM_ARGS} -Xmx1024m"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:NewSize=384m"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:MaxNewSize=384m"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:PermSize=256m"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:MaxPermSize=256m"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:-UseAdaptiveSizePolicy"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+DisableExplicitGC"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintGCDetails"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintGCTimeStamps"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintHeapAtGC"
USER_MEM_ARGS="\${USER_MEM_ARGS} -Xloggc:\${LOG_DIR}/gc.\${SERVER_NAME}.log"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+HeapDumpOnOutOfMemoryError"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:HeapDumpPath=\${LOG_DIR}/dump"
# USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintFlagsFinal"
export USER_MEM_ARGS

JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.SocketReaders=4"
JAVA_OPTIONS="\${JAVA_OPTIONS} -Dcom.bea.wlw.netui.disableInstrumentation=true"
JAVA_OPTIONS="\${JAVA_OPTIONS} -D_Offline_FileDataArchive=true"
JAVA_OPTIONS="\${JAVA_OPTIONS} -Djava.net.preferIPv4Stack=true"
JAVA_OPTIONS="\${JAVA_OPTIONS} -Djava.net.preferIPv6Addresses=false"
JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.system.BootIdentityFile=\${DOMAIN_HOME}/boot.properties"
JAVA_OPTIONS="\${JAVA_OPTIONS} -Djava.security.egd=file:///dev/urandom"
export JAVA_OPTIONS

### verbose
# JAVA_OPTIONS="\${JAVA_OPTIONS} -verbose:class"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -verbose:gc"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -verbose:jni"
### debug
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.log.StdoutSeverity=Debug"
### debug all
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.log.StdoutSeverity=Debug"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.log.LogSeverity=Debug"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.log.LoggerSeverity=Debug"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
### ssl debug
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Djavax.net.debug=all"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dssl.debug=true"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
### jta xa debug
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.log.StdoutSeverity=Debug"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.debug.DebugJTA2PC=true"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.debug.DebugJTAXA=true"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.debug.DebugJTAJDBC=true"
### jta non-xa debug
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.log.StdoutSeverity=Debug"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.debug.DebugJTANonXA=true"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.debug.DebugJTAJDBC=true"
export JAVA_OPTIONS

# export EXT_PRE_CLASSPATH
# export EXT_POST_CLASSPATH

if [ -f \${LOG_DIR}/nohup.\${SERVER_NAME}.out ]; then
  mv \${LOG_DIR}/nohup.\${SERVER_NAME}.out \${LOG_DIR}/\${SERVER_NAME}/nohup.\${SERVER_NAME}.\${GET_DATE}.out
fi
if [ -f \${LOG_DIR}/gc.\${SERVER_NAME}.log ]; then
  mv \${LOG_DIR}/gc.\${SERVER_NAME}.log \${LOG_DIR}/\${SERVER_NAME}/gc.\${SERVER_NAME}.\${GET_DATE}.log
fi
touch \${LOG_DIR}/nohup.\${SERVER_NAME}.out
EOF

if [ "${SERVER_NAME}" == "${ADMIN_SERVER_NAME}" ]; then
cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
nohup \${DOMAIN_HOME}/bin/startWebLogic.sh > \${LOG_DIR}/nohup.\${SERVER_NAME}.out 2>&1 &
EOF
else
cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
nohup \${DOMAIN_HOME}/bin/startManagedWebLogic.sh \${SERVER_NAME} \${ADMIN_URL} > \${LOG_DIR}/nohup.\${SERVER_NAME}.out 2>&1 &
EOF
fi

cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
tail -f \${LOG_DIR}/nohup.\${SERVER_NAME}.out
EOF

######################################################################

### stop script

cat <<EOF > ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
#!/bin/bash

EOF

if [ "${SERVER_NAME}" != "${ADMIN_SERVER_NAME}" ]; then
cat <<EOF >> ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
SERVER_NAME="${SERVER_NAME}"
EOF
fi

cat <<EOF >> ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
ADMIN_URL="t3://${ADMIN_SERVER_LISTEN_ADDRESS}:${ADMIN_SERVER_LISTEN_PORT}"
DOMAIN_HOME="${DOMAIN_HOME}"
USERNAME="${ADMIN_USERNAME}"
PASSWORD="${ADMIN_PASSWORD}"
EOF

if [ "${SERVER_NAME}" == "${ADMIN_SERVER_NAME}" ]; then
cat <<EOF >> ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
\${DOMAIN_HOME}/bin/stopWebLogic.sh \${USERNAME} \${PASSWORD} \${ADMIN_URL}
EOF
else
cat <<EOF >> ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
\${DOMAIN_HOME}/bin/stopManagedWebLogic.sh \${SERVER_NAME} \${ADMIN_URL} \${USERNAME} \${PASSWORD}
EOF
fi

######################################################################

chmod 750 ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
chmod 750 ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
