#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="replicator1"

# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka-connect-replicator/replicator.properties"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka-connect-replicator/replicator-connect-standalone.properties"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka-connect-replicator/replicator-connect-distributed.properties"
PROPERTIES_FILE="${CONFLUENT_HOME}/properties/replicator1.properties"

LOG_DIR="/mnt/replicator/logs"
export LOG_DIR

# JAVA_HOME="/usr/lib/jvm/java-11"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"
JAVA_HOME="/usr/lib/jvm/java-1.8.0"
export JAVA_HOME

######################################################################

### memory options
KAFKA_HEAP_OPTS="${KAFKA_HEAP_OPTS} -Xms2G -Xmx2G"
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
# PROMETHEUS_JAVA_AGENT_FILE="${CONFLUENT_HOME}/prometheus/jmx_prometheus_javaagent-0.15.0.jar"
# PROMETHEUS_EXPORTER_FILE="${CONFLUENT_HOME}/prometheus/kafka_connect.yml"
# PROMETHEUS_PORT="1234"
# KAFKA_OPTS="${KAFKA_OPTS} -javaagent:${PROMETHEUS_JAVA_AGENT_FILE}=${PROMETHEUS_PORT}:${PROMETHEUS_EXPORTER_FILE}"
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

### classpath
CLASSPATH="${CLASSPATH}:${CONFLUENT_HOME}/share/java/kafka-connect-replicator/*"
export CLASSPATH

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

### create log dir
if [ ! -d "${LOG_DIR}/backup" ]; then
    mkdir -p ${LOG_DIR}/backup
fi

### backup stdout log
DATETIME="$(date +'%Y%m%d_%H%M%S')"
if [ -f "${LOG_DIR}/nohup.${SERVER_NAME}.out" ]; then
    mv ${LOG_DIR}/nohup.${SERVER_NAME}.out ${LOG_DIR}/backup/nohup.${SERVER_NAME}.${DATETIME}.out
fi

touch ${LOG_DIR}/nohup.${SERVER_NAME}.out
nohup ${CONFLUENT_HOME}/bin/replicator ${PROPERTIES_FILE} > ${LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
tail -f ${LOG_DIR}/nohup.${SERVER_NAME}.out