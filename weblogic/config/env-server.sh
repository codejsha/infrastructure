#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
# Server Start Configuration (If you use Node Manager)

MANAGED_SERVER_NAME="${1}"
SERVER_NAME="${MANAGED_SERVER_NAME}"

export SERVER_START_JAVA_VENDOR="Oracle"
export SERVER_START_ROOT_DIR="${DOMAIN_HOME}"

USER_MEM_ARGS="-D${SERVER_NAME}"
USER_MEM_ARGS="${USER_MEM_ARGS} -Xms1024m -Xmx1024m"
USER_MEM_ARGS="${USER_MEM_ARGS} -XX:NewSize=384m -XX:MaxNewSize=384m"

if [[ ${JAVA_VERSION} =~ ^1.7 ]]; then
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
    # USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+GCLogFileSize=8K"
    USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+HeapDumpOnOutOfMemoryError"
    USER_MEM_ARGS="${USER_MEM_ARGS} -XX:HeapDumpPath=${LOG_DIR}/dump"
elif [[ ${JAVA_VERSION} =~ ^1.8 ]]; then
    USER_MEM_ARGS="${USER_MEM_ARGS} -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m"
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
    # USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+GCLogFileSize=8K"
    USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+HeapDumpOnOutOfMemoryError"
    USER_MEM_ARGS="${USER_MEM_ARGS} -XX:HeapDumpPath=${LOG_DIR}/dump"
elif [[ ${JAVA_VERSION} =~ ^11 ]]; then
    USER_MEM_ARGS="${USER_MEM_ARGS} -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m"
    # USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+UseParallelGC"
    USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+UseG1GC"
    USER_MEM_ARGS="${USER_MEM_ARGS} -XX:MaxGCPauseMillis=200"
    USER_MEM_ARGS="${USER_MEM_ARGS} -XX:InitiatingHeapOccupancyPercent=45"
    USER_MEM_ARGS="${USER_MEM_ARGS} -Xlog:gc*=info:file=${LOG_DIR}/gc.${SERVER_NAME}.log:time,pid,tid,level,tags"
    # USER_MEM_ARGS="${USER_MEM_ARGS} -Xlog:gc*=info:file=${LOG_DIR}/gc.${SERVER_NAME}.log:time,pid,tid,level,tags:filecount=30,filesize=8K"
    USER_MEM_ARGS="${USER_MEM_ARGS} -XX:+HeapDumpOnOutOfMemoryError"
    USER_MEM_ARGS="${USER_MEM_ARGS} -XX:HeapDumpPath=${LOG_DIR}/dump"
fi

JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.SocketReaders=4"
JAVA_OPTIONS="${JAVA_OPTIONS} -D_Offline_FileDataArchive=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dcom.bea.wlw.netui.disableInstrumentation=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.connector.ConnectionPoolProfilingEnabled=false"
JAVA_OPTIONS="${JAVA_OPTIONS} -Djava.net.preferIPv4Stack=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Djava.net.preferIPv6Addresses=false"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.system.BootIdentityFile=${DOMAIN_HOME}/boot.properties"
JAVA_OPTIONS="${JAVA_OPTIONS} -Djava.security.egd=file:///dev/urandom"

if [[ ${JAVA_VERSION} =~ ^1.7|^1.8 ]]; then
    echo ""
    # JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:class"
    # JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:module"
    # JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:jni"
elif [[ ${JAVA_VERSION} =~ ^11 ]]; then
    echo ""
    # JAVA_OPTIONS="${JAVA_OPTIONS} -Xlog:class+load=info,class+unload=info:stdout:time,level,tags"
    # JAVA_OPTIONS="${JAVA_OPTIONS} -Xlog:module*=info:stdout:time,level,tags"
    # JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:jni"
fi

SERVER_START_ARGUMENTS="${USER_MEM_ARGS} ${JAVA_OPTIONS}"
export SERVER_START_ARGUMENTS

SERVER_START_CLASSPATH="${SERVER_START_CLASSPATH};${EXT_PRE_CLASSPATH}"
SERVER_START_CLASSPATH="${SERVER_START_CLASSPATH};${CLASSPATH}"
SERVER_START_CLASSPATH="${SERVER_START_CLASSPATH};${WL_HOME}/server/lib/weblogic_sp.jar"
SERVER_START_CLASSPATH="${SERVER_START_CLASSPATH};${WL_HOME}/server/lib/weblogic.jar"
SERVER_START_CLASSPATH="${SERVER_START_CLASSPATH};${EXT_POST_CLASSPATH}"
export SERVER_START_CLASSPATH
