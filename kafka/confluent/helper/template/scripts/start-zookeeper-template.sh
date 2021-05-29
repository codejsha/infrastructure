#!/bin/bash

CONFLUENT_HOME=""
SERVER_NAME=""
MYID=""

# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka/zookeeper.properties"
PROPERTIES_FILE=""

DATA_DIR=""
LOG_DIR=""
export LOG_DIR

### java home
# JAVA_HOME="/usr/lib/jvm/java-11"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"
# JAVA_HOME="/usr/lib/jvm/zulu11"
# JAVA_HOME="/usr/lib/jvm/zulu8"
JAVA_HOME=""
export JAVA_HOME

######################################################################

### memory options
KAFKA_HEAP_OPTS="${KAFKA_HEAP_OPTS} -Xms512m -Xmx512m"
export KAFKA_HEAP_OPTS

### performance
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -server"
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -XX:+UseG1GC"
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -XX:MaxGCPauseMillis=20"
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -XX:InitiatingHeapOccupancyPercent=35"
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -XX:+ExplicitGCInvokesConcurrent"
# KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -XX:ParallelGCThreads="
# KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -XX:ConcGCThreads="
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -XX:MaxInlineLevel=15"
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -Djava.awt.headless=true"
export KAFKA_JVM_PERFORMANCE_OPTS

### generic jvm settings
KAFKA_OPTS="${KAFKA_OPTS} -D${SERVER_NAME}"
# JMX_EXPORTER_JAVA_AGENT_FILE="${CONFLUENT_HOME}/prometheus/jmx_prometheus_javaagent-0.15.0.jar"
# JMX_EXPORTER_CONFIG_FILE="${CONFLUENT_HOME}/prometheus/zookeeper.yml"
# JMX_EXPORTER_HOST_PORT="1234"
# KAFKA_OPTS="${KAFKA_OPTS} -javaagent:${JMX_EXPORTER_JAVA_AGENT_FILE}=${JMX_EXPORTER_HOST_PORT}:${JMX_EXPORTER_CONFIG_FILE}"
export KAFKA_OPTS

### gc option
export GC_LOG_ENABLED="true"

### jmx
# export JMX_PORT=""
KAFKA_JMX_OPTS="${KAFKA_JMX_OPTS} -Dcom.sun.management.jmxremote"
KAFKA_JMX_OPTS="${KAFKA_JMX_OPTS} -Dcom.sun.management.jmxremote.authenticate=false"
KAFKA_JMX_OPTS="${KAFKA_JMX_OPTS} -Dcom.sun.management.jmxremote.ssl=false"
export KAFKA_JMX_OPTS

### log4j
KAFKA_LOG4J_OPTS="${KAFKA_LOG4J_OPTS} -Dlog4j.configuration=file:${CONFLUENT_HOME}/log4j/zookeeper-log4j.properties"
export KAFKA_LOG4J_OPTS

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

### create myid file
if [ ! -f "${DATA_DIR}/myid" ]; then
    echo ${MYID} > ${DATA_DIR}/myid
fi

### backup stdout log
DATETIME="$(date +'%Y%m%d_%H%M%S')"
if [ -f "${LOG_DIR}/nohup.${SERVER_NAME}.out" ]; then
    mv ${LOG_DIR}/nohup.${SERVER_NAME}.out ${LOG_DIR}/backup/nohup.${SERVER_NAME}.${DATETIME}.out
fi

touch ${LOG_DIR}/nohup.${SERVER_NAME}.out
nohup ${CONFLUENT_HOME}/bin/zookeeper-server-start ${PROPERTIES_FILE} > ${LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
tail -f ${LOG_DIR}/nohup.${SERVER_NAME}.out
