#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="kafka2"

# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka/server.properties"
PROPERTIES_FILE="${CONFLUENT_HOME}/properties/kafka2.properties"

DATA_DIR="/mnt/kafka/data"
LOG_DIR="/mnt/kafka/logs"
export LOG_DIR

### java home
# export JAVA_HOME="/usr/lib/jvm/java-11"
export JAVA_HOME="/usr/lib/jvm/java-1.8.0"

######################################################################

### memory options
KAFKA_HEAP_OPTS="${KAFKA_HEAP_OPTS} -Xms1G -Xmx1G"
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

### aws credentials
# export AWS_ACCESS_KEY_ID=""
# export AWS_SECRET_ACCESS_KEY=""

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

### create data and log dirs
if [ ! -d "${DATA_DIR}" ]; then
    mkdir -p ${DATA_DIR}
fi
if [ ! -d "${LOG_DIR}/backup" ]; then
    mkdir -p ${LOG_DIR}/backup
fi

### backup stdout log
GET_DATE="$(date +'%Y%m%d_%H%M%S')"
if [ -f "${LOG_DIR}/nohup.${SERVER_NAME}.out" ]; then
    mv ${LOG_DIR}/nohup.${SERVER_NAME}.out ${LOG_DIR}/backup/nohup.${SERVER_NAME}.${GET_DATE}.out
fi

touch ${LOG_DIR}/nohup.${SERVER_NAME}.out
nohup ${CONFLUENT_HOME}/bin/kafka-server-start ${PROPERTIES_FILE} > ${LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
tail -f ${LOG_DIR}/nohup.${SERVER_NAME}.out
