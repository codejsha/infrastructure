#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

SERVER_NAME="${1}"

######################################################################

mkdir -p ${LOG_DIR}/${MANAGED_SERVER_NAME}

######################################################################

### replace pattern with string
TEMP="\${DOMAIN_HOME}"
VAR_LOG_DIR="${LOG_DIR/${DOMAIN_HOME}/${TEMP}}"

FILE_NAME_SUFFIX="${SERVER_NAME,,}"
FILE_NAME_SUFFIX="${FILE_NAME_SUFFIX/base/}"
FILE_NAME_SUFFIX="${FILE_NAME_SUFFIX/server/}"

######################################################################

### create start script

cat <<EOF > ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
#!/bin/bash
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

SERVER_NAME="${SERVER_NAME}"
DOMAIN_HOME="${DOMAIN_HOME}"
LOG_DIR="${VAR_LOG_DIR}"
DATETIME="\$(date +'%Y%m%d_%H%M%S')"

CURRENT_USER="\$(id -un)"
if [ "\${CURRENT_USER}" == "root" ]; then
    echo "[ERROR] The current user is root!"
    exit
fi

PID="\$(pgrep -xa java | grep \${DOMAIN_HOME} | grep \${SERVER_NAME} | awk '{print \$1}')"
if [ -n "\${PID}" ]; then
    echo "[ERROR] The \${SERVER_NAME} (pid \${PID}) is already running!"
    exit
fi

USER_MEM_ARGS="-D\${SERVER_NAME}"
USER_MEM_ARGS="\${USER_MEM_ARGS} -Xms1024m -Xmx1024m"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:NewSize=384m -XX:MaxNewSize=384m"
EOF

if [[ ${JAVA_VERSION} =~ ^11 ]]; then
cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m"
# USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+UseParallelGC"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+UseG1GC"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:MaxGCPauseMillis=200"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:InitiatingHeapOccupancyPercent=45"
USER_MEM_ARGS="\${USER_MEM_ARGS} -Xlog:gc*=info:file=\${LOG_DIR}/gc.\${SERVER_NAME}.log:time,pid,tid,level,tags"
# USER_MEM_ARGS="\${USER_MEM_ARGS} -Xlog:gc*=info:file=\${LOG_DIR}/gc.\${SERVER_NAME}.log:time,pid,tid,level,tags:filecount=30,filesize=1M"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+HeapDumpOnOutOfMemoryError"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:HeapDumpPath=\${LOG_DIR}/dump"
export USER_MEM_ARGS
EOF
elif [[ ${JAVA_VERSION} =~ ^1.8 ]]; then
cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+UseParallelGC"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:-UseAdaptiveSizePolicy"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+DisableExplicitGC"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintGCDetails"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintGCDateStamps"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintGCTimeStamps"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintHeapAtGC"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintTenuringDistribution"
USER_MEM_ARGS="\${USER_MEM_ARGS} -Xloggc:\${LOG_DIR}/gc.\${SERVER_NAME}.log"
# USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+UseGCLogFileRotation"
# USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+NumberOfGCLogFiles=30"
# USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+GCLogFileSize=1M"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+HeapDumpOnOutOfMemoryError"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:HeapDumpPath=\${LOG_DIR}/dump"
export USER_MEM_ARGS
EOF
elif [[ ${JAVA_VERSION} =~ ^1.7 ]]; then
cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:PermSize=256m -XX:MaxPermSize=256m"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+UseParallelGC"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:-UseAdaptiveSizePolicy"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+DisableExplicitGC"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintGCDetails"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintGCDateStamps"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintGCTimeStamps"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintHeapAtGC"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+PrintTenuringDistribution"
USER_MEM_ARGS="\${USER_MEM_ARGS} -Xloggc:\${LOG_DIR}/gc.\${SERVER_NAME}.log"
# USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+UseGCLogFileRotation"
# USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+NumberOfGCLogFiles=30"
# USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+GCLogFileSize=1M"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:+HeapDumpOnOutOfMemoryError"
USER_MEM_ARGS="\${USER_MEM_ARGS} -XX:HeapDumpPath=\${LOG_DIR}/dump"
export USER_MEM_ARGS
EOF
fi

cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh

JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.SocketReaders=4"
JAVA_OPTIONS="\${JAVA_OPTIONS} -D_Offline_FileDataArchive=true"
JAVA_OPTIONS="\${JAVA_OPTIONS} -Dcom.bea.wlw.netui.disableInstrumentation=true"
JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.connector.ConnectionPoolProfilingEnabled=false"
JAVA_OPTIONS="\${JAVA_OPTIONS} -Djava.net.preferIPv4Stack=true"
JAVA_OPTIONS="\${JAVA_OPTIONS} -Djava.net.preferIPv6Addresses=false"
JAVA_OPTIONS="\${JAVA_OPTIONS} -Dweblogic.system.BootIdentityFile=\${DOMAIN_HOME}/boot.properties"
JAVA_OPTIONS="\${JAVA_OPTIONS} -Djava.security.egd=file:///dev/urandom"
export JAVA_OPTIONS

EOF

if [[ ${JAVA_VERSION} =~ ^11 ]]; then
cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Xlog:class+load=info,class+unload=info:stdout:time,level,tags"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -Xlog:module*=info:stdout:time,level,tags"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -verbose:jni"
# export JAVA_OPTIONS
EOF
elif [[ ${JAVA_VERSION} =~ ^1.8|^1.7 ]]; then
cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
# JAVA_OPTIONS="\${JAVA_OPTIONS} -verbose:class"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -verbose:module"
# JAVA_OPTIONS="\${JAVA_OPTIONS} -verbose:jni"
# export JAVA_OPTIONS
EOF
fi

cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh

# export EXT_PRE_CLASSPATH
# export EXT_POST_CLASSPATH

if [ -f "\${LOG_DIR}/nohup.\${SERVER_NAME}.out" ]; then
    mv \${LOG_DIR}/nohup.\${SERVER_NAME}.out \${LOG_DIR}/\${SERVER_NAME}/nohup.\${SERVER_NAME}.\${DATETIME}.out
fi
if [ -f "\${LOG_DIR}/gc.\${SERVER_NAME}.log" ]; then
    mv \${LOG_DIR}/gc.\${SERVER_NAME}.log \${LOG_DIR}/\${SERVER_NAME}/gc.\${SERVER_NAME}.\${DATETIME}.log
fi

touch \${LOG_DIR}/nohup.\${SERVER_NAME}.out
nohup \${DOMAIN_HOME}/bin/startManagedWebLogic.sh \${SERVER_NAME} \${ADMIN_URL} > \${LOG_DIR}/nohup.\${SERVER_NAME}.out 2>&1 &
tail -f \${LOG_DIR}/nohup.\${SERVER_NAME}.out
EOF

######################################################################

### create stop script

cat <<EOF > ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
#!/bin/bash
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

SERVER_NAME="${SERVER_NAME}"
ADMIN_URL="t3://${ADMIN_SERVER_LISTEN_ADDRESS}:${ADMIN_SERVER_LISTEN_PORT}"
DOMAIN_HOME="${DOMAIN_HOME}"
USERNAME="${ADMIN_USERNAME}"
PASSWORD="${ADMIN_PASSWORD}"

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${DOMAIN_HOME}/bin/stopManagedWebLogic.sh \${SERVER_NAME} \${ADMIN_URL} \${USERNAME} \${PASSWORD}
EOF

######################################################################

### change file permissions
chmod 750 ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
chmod 750 ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
