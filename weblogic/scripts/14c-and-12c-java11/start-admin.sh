#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

SERVER_NAME="AdminServer"
DOMAIN_HOME="/usr/local/weblogic/user_projects/domains/base_domain"
LOG_DIR="${DOMAIN_HOME}/logs"
DATETIME="$(date +'%Y%m%d_%H%M%S')"

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
USER_MEM_ARGS="${USER_MEM_ARGS} -Xms512m -Xmx512m"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:NewSize=192m -XX:MaxNewSize=192m"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m"
# USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+UseParallelGC"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+UseG1GC"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:MaxGCPauseMillis=200"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:InitiatingHeapOccupancyPercent=45"
USER_MEM_ARGS="${USER_MEM_ARGS} -Xlog:gc*=info:file=${LOG_DIR}/gc.${SERVER_NAME}.log:time,pid,tid,level,tags"
# USER_MEM_ARGS="${USER_MEM_ARGS} -Xlog:gc*=info:file=${LOG_DIR}/gc.${SERVER_NAME}.log:time,pid,tid,level,tags:filecount=30,filesize=1M"
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

# JAVA_OPTIONS="${JAVA_OPTIONS} -Xlog:class+load=info,class+unload=info:stdout:time,level,tags"
# JAVA_OPTIONS="${JAVA_OPTIONS} -Xlog:module*=info:stdout:time,level,tags"
# JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:jni"
# export JAVA_OPTIONS

# export EXT_PRE_CLASSPATH
# export EXT_POST_CLASSPATH

if [ -f "${LOG_DIR}/nohup.${SERVER_NAME}.out" ]; then
    mv ${LOG_DIR}/nohup.${SERVER_NAME}.out ${LOG_DIR}/${SERVER_NAME}/nohup.${SERVER_NAME}.${DATETIME}.out
fi
if [ -f "${LOG_DIR}/gc.${SERVER_NAME}.log" ]; then
    mv ${LOG_DIR}/gc.${SERVER_NAME}.log ${LOG_DIR}/${SERVER_NAME}/gc.${SERVER_NAME}.${DATETIME}.log
fi

touch ${LOG_DIR}/nohup.${SERVER_NAME}.out
nohup ${DOMAIN_HOME}/bin/startWebLogic.sh > ${LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
tail -f ${LOG_DIR}/nohup.${SERVER_NAME}.out
