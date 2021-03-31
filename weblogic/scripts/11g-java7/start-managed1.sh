#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

SERVER_NAME="ManagedServer1"
DOMAIN_HOME="/usr/local/weblogic/user_projects/domains/base_domain"
LOG_DIR="${DOMAIN_HOME}/logs"
GET_DATE="$(date +'%Y%m%d_%H%M%S')"

CURRENT_USER="$(id -un)"
if [ "${CURRENT_USER}" == "root" ]; then
    echo "[ERROR] The current user is root!"
    exit
fi

PID="$(pgrep -xa java | grep ${DOMAIN_HOME} | grep ${SERVER_NAME} | awk '{print $1}')"
if [ -n "${PID}" ]; then
    echo "[ERROR] The ${SERVER_NAME} (pid ${PID}) is already running!"
    exit
fi

USER_MEM_ARGS="-D${SERVER_NAME}"
USER_MEM_ARGS="${USER_MEM_ARGS} -Xms1024m -Xmx1024m"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:NewSize=384m -XX:MaxNewSize=384m"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:PermSize=256m -XX:MaxPermSize=256m"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+UseParallelGC"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:-UseAdaptiveSizePolicy"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+DisableExplicitGC"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+PrintGCDetails"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+PrintGCDateStamps"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+PrintGCTimeStamps"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+PrintHeapAtGC"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+PrintTenuringDistribution"
USER_MEM_ARGS="${USER_MEM_ARGS} -Xloggc:${LOG_DIR}/gc.${SERVER_NAME}.log"
# USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+UseGCLogFileRotation"
# USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+NumberOfGCLogFiles=30"
# USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+GCLogFileSize=1M"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+HeapDumpOnOutOfMemoryError"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:HeapDumpPath=${LOG_DIR}/dump"
export USER_MEM_ARGS

JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.SocketReaders=4"
JAVA_OPTIONS="${JAVA_OPTIONS} -D_Offline_FileDataArchive=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dcom.bea.wlw.netui.disableInstrumentation=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.connector.ConnectionPoolProfilingEnabled=false"
JAVA_OPTIONS="${JAVA_OPTIONS} -Djava.net.preferIPv4Stack=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Djava.net.preferIPv6Addresses=false"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.system.BootIdentityFile=${DOMAIN_HOME}/boot.properties"
JAVA_OPTIONS="${JAVA_OPTIONS} -Djava.security.egd=file:///dev/urandom"
export JAVA_OPTIONS

# JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:class"
# JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:module"
# JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:jni"
# export JAVA_OPTIONS

# export EXT_PRE_CLASSPATH
# export EXT_POST_CLASSPATH

if [ -f "${LOG_DIR}/nohup.${SERVER_NAME}.out" ]; then
    mv ${LOG_DIR}/nohup.${SERVER_NAME}.out ${LOG_DIR}/${SERVER_NAME}/nohup.${SERVER_NAME}.${GET_DATE}.out
fi
if [ -f "${LOG_DIR}/gc.${SERVER_NAME}.log" ]; then
    mv ${LOG_DIR}/gc.${SERVER_NAME}.log ${LOG_DIR}/${SERVER_NAME}/gc.${SERVER_NAME}.${GET_DATE}.log
fi

touch ${LOG_DIR}/nohup.${SERVER_NAME}.out
nohup ${DOMAIN_HOME}/bin/startManagedWebLogic.sh ${SERVER_NAME} ${ADMIN_URL} > ${LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
tail -f ${LOG_DIR}/nohup.${SERVER_NAME}.out
