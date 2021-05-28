#!/bin/bash

CONFLUENT_HOME=""
SERVER_NAME=""

# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/confluent-control-center/control-center.properties"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/confluent-control-center/control-center-dev.properties"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/confluent-control-center/control-center-minimal.properties"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/confluent-control-center/control-center-production.properties"
PROPERTIES_FILE=""

DATA_DIR=""
LOG_DIR=""
export LOG_DIR

# JAVA_HOME="/usr/lib/jvm/java-11"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"
# JAVA_HOME="/usr/lib/jvm/zulu11"
# JAVA_HOME="/usr/lib/jvm/zulu8"
JAVA_HOME=""
export JAVA_HOME

######################################################################

### memory options
CONTROL_CENTER_HEAP_OPTS="${CONTROL_CENTER_HEAP_OPTS} -Xms6g -Xmx6g"
export CONTROL_CENTER_HEAP_OPTS

### performance
CONTROL_CENTER_JVM_PERFORMANCE_OPTS="${CONTROL_CENTER_JVM_PERFORMANCE_OPTS} -server"
# CONTROL_CENTER_JVM_PERFORMANCE_OPTS="${CONTROL_CENTER_JVM_PERFORMANCE_OPTS} -XX:+UseG1GC"
# CONTROL_CENTER_JVM_PERFORMANCE_OPTS="${CONTROL_CENTER_JVM_PERFORMANCE_OPTS} -XX:MaxGCPauseMillis=20"
# CONTROL_CENTER_JVM_PERFORMANCE_OPTS="${CONTROL_CENTER_JVM_PERFORMANCE_OPTS} -XX:InitiatingHeapOccupancyPercent=35"
# CONTROL_CENTER_JVM_PERFORMANCE_OPTS="${CONTROL_CENTER_JVM_PERFORMANCE_OPTS} -XX:+ExplicitGCInvokesConcurrent"
CONTROL_CENTER_JVM_PERFORMANCE_OPTS="${CONTROL_CENTER_JVM_PERFORMANCE_OPTS} -XX:+UseConcMarkSweepGC"
CONTROL_CENTER_JVM_PERFORMANCE_OPTS="${CONTROL_CENTER_JVM_PERFORMANCE_OPTS} -XX:+CMSClassUnloadingEnabled"
CONTROL_CENTER_JVM_PERFORMANCE_OPTS="${CONTROL_CENTER_JVM_PERFORMANCE_OPTS} -XX:+CMSScavengeBeforeRemark"
CONTROL_CENTER_JVM_PERFORMANCE_OPTS="${CONTROL_CENTER_JVM_PERFORMANCE_OPTS} -XX:+DisableExplicitGC"
# CONTROL_CENTER_JVM_PERFORMANCE_OPTS="${CONTROL_CENTER_JVM_PERFORMANCE_OPTS} -XX:ParallelGCThreads="
# CONTROL_CENTER_JVM_PERFORMANCE_OPTS="${CONTROL_CENTER_JVM_PERFORMANCE_OPTS} -XX:ConcGCThreads="
CONTROL_CENTER_JVM_PERFORMANCE_OPTS="${CONTROL_CENTER_JVM_PERFORMANCE_OPTS} -XX:MaxInlineLevel=15"
CONTROL_CENTER_JVM_PERFORMANCE_OPTS="${CONTROL_CENTER_JVM_PERFORMANCE_OPTS} -Djava.awt.headless=true"
export CONTROL_CENTER_JVM_PERFORMANCE_OPTS

### generic jvm settings
CONTROL_CENTER_OPTS="${CONTROL_CENTER_OPTS} -D${SERVER_NAME}"
export CONTROL_CENTER_OPTS

### gc option
export GC_LOG_ENABLED="true"

### jmx
# export JMX_PORT=""
CONTROL_CENTER_JMX_OPTS="${CONTROL_CENTER_JMX_OPTS} -Dcom.sun.management.jmxremote"
CONTROL_CENTER_JMX_OPTS="${CONTROL_CENTER_JMX_OPTS} -Dcom.sun.management.jmxremote.authenticate=false"
CONTROL_CENTER_JMX_OPTS="${CONTROL_CENTER_JMX_OPTS} -Dcom.sun.management.jmxremote.ssl=false "
export CONTROL_CENTER_JMX_OPTS

### log4j
# CONTROL_CENTER_LOG4J_OPTS="${CONTROL_CENTER_LOG4J_OPTS}"
# export CONTROL_CENTER_LOG4J_OPTS

######################################################################

######################################################################

### check current user
CURRENT_USER="$(id -un)"
if [ "${CURRENT_USER}" == "root" ]; then
    echo "[ERROR] The current user is root!"
    exit
fi

### check running process
PID="$(pgrep -xa java | grep ${PROPERTIES_FILE} | grep ${SERVER_NAME} | awk '{print $1}')"
if [ -n "${PID}" ]; then
    echo "[ERROR] The ${SERVER_NAME} (pid ${PID}) is already running!"
    exit
fi

### create data and log directories
if [ ! -d "${DATA_DIR}" ]; then
    mkdir -p ${DATA_DIR}
fi
if [ ! -d "${LOG_DIR}/backup" ]; then
    mkdir -p ${LOG_DIR}/backup
fi

### backup stdout log
DATETIME="$(date +'%Y%m%d_%H%M%S')"
if [ -f "${LOG_DIR}/nohup.${SERVER_NAME}.out" ]; then
    mv ${LOG_DIR}/nohup.${SERVER_NAME}.out ${LOG_DIR}/backup/nohup.${SERVER_NAME}.${DATETIME}.out
fi

touch ${LOG_DIR}/nohup.${SERVER_NAME}.out
nohup ${CONFLUENT_HOME}/bin/control-center-start ${PROPERTIES_FILE} > ${LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
tail -f ${LOG_DIR}/nohup.${SERVER_NAME}.out
