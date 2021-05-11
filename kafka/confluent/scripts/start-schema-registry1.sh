#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="schema-registry1"

# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/schema-registry/schema-registry.properties"
PROPERTIES_FILE="${CONFLUENT_HOME}/properties/schema-registry1.properties"

LOG_DIR="/mnt/schema-registry/logs"
export LOG_DIR

# JAVA_HOME="/usr/lib/jvm/java-11"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"
JAVA_HOME="/usr/lib/jvm/java-1.8.0"
export JAVA_HOME

######################################################################

### memory options
SCHEMA_REGISTRY_HEAP_OPTS="${SCHEMA_REGISTRY_HEAP_OPTS} -Xms512M -Xmx512M"
export SCHEMA_REGISTRY_HEAP_OPTS

### performance
SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS="${SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS} -server"
SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS="${SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS} -XX:+UseG1GC"
SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS="${SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS} -XX:MaxGCPauseMillis=20"
SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS="${SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS} -XX:InitiatingHeapOccupancyPercent=35"
SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS="${SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS} -XX:+ExplicitGCInvokesConcurrent"
SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS="${SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS} -XX:MaxInlineLevel=15"
SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS="${SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS} -Djava.awt.headless=true"
export SCHEMA_REGISTRY_JVM_PERFORMANCE_OPTS

### generic jvm settings
SCHEMA_REGISTRY_OPTS="${SCHEMA_REGISTRY_OPTS} -D${SERVER_NAME}"
export SCHEMA_REGISTRY_OPTS

### gc option
export GC_LOG_ENABLED="true"

### jmx
# export JMX_PORT=""
SCHEMA_REGISTRY_JMX_OPTS="${SCHEMA_REGISTRY_JMX_OPTS} -Dcom.sun.management.jmxremote"
SCHEMA_REGISTRY_JMX_OPTS="${SCHEMA_REGISTRY_JMX_OPTS} -Dcom.sun.management.jmxremote.authenticate=false"
SCHEMA_REGISTRY_JMX_OPTS="${SCHEMA_REGISTRY_JMX_OPTS} -Dcom.sun.management.jmxremote.ssl=false "
export SCHEMA_REGISTRY_JMX_OPTS

### log4j
# SCHEMA_REGISTRY_LOG4J_OPTS="${SCHEMA_REGISTRY_LOG4J_OPTS}"
# export SCHEMA_REGISTRY_LOG4J_OPTS

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
nohup ${CONFLUENT_HOME}/bin/schema-registry-start ${PROPERTIES_FILE} > ${LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
tail -f ${LOG_DIR}/nohup.${SERVER_NAME}.out
