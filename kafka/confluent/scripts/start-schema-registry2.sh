#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="schema-registry2"

# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/schema-registry/schema-registry.properties"
PROPERTIES_FILE="${CONFLUENT_HOME}/properties/schema-registry2.properties"

LOG_DIR="/mnt/schema-registry/logs"
export LOG_DIR

### java home
export JAVA_HOME="/usr/lib/jvm/java-1.8.0"
# export JAVA_HOME="/usr/lib/jvm/java-11"

######################################################################

### memory options
KAFKA_HEAP_OPTS="${KAFKA_HEAP_OPTS} -Xms512M -Xmx512M"
export KAFKA_HEAP_OPTS

### performance
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -server"
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -XX:+UseG1GC"
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -XX:MaxGCPauseMillis=20"
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -XX:InitiatingHeapOccupancyPercent=35"
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -XX:+ExplicitGCInvokesConcurrent"
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -XX:MaxInlineLevel=15"
KAFKA_JVM_PERFORMANCE_OPTS="${KAFKA_JVM_PERFORMANCE_OPTS} -Djava.awt.headless=true"
export KAFKA_JVM_PERFORMANCE_OPTS

### generic jvm settings
KAFKA_OPTS="${KAFKA_OPTS} -D${SERVER_NAME}"
export KAFKA_OPTS

### gc option
export GC_LOG_ENABLED="true"

### jmx
# export JMX_PORT=""
KAFKA_JMX_OPTS="${KAFKA_JMX_OPTS} -Dcom.sun.management.jmxremote"
KAFKA_JMX_OPTS="${KAFKA_JMX_OPTS} -Dcom.sun.management.jmxremote.authenticate=false"
KAFKA_JMX_OPTS="${KAFKA_JMX_OPTS} -Dcom.sun.management.jmxremote.ssl=false "
export KAFKA_JMX_OPTS

### log4j
# KAFKA_LOG4J_OPTS="${KAFKA_LOG4J_OPTS}"
# export KAFKA_LOG4J_OPTS

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

### create log dir
if [ ! -d "${LOG_DIR}/backup" ]; then
    mkdir -p ${LOG_DIR}/backup
fi

### backup stdout log
GET_DATE="$(date +'%Y%m%d_%H%M%S')"
if [ -f "${LOG_DIR}/nohup.${SERVER_NAME}.out" ]; then
    mv ${LOG_DIR}/nohup.${SERVER_NAME}.out ${LOG_DIR}/backup/nohup.${SERVER_NAME}.${GET_DATE}.out
fi

touch ${LOG_DIR}/nohup.${SERVER_NAME}.out
nohup ${CONFLUENT_HOME}/bin/schema-registry-start ${PROPERTIES_FILE} > ${LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
tail -f ${LOG_DIR}/nohup.${SERVER_NAME}.out
