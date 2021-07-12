#!/bin/bash

LAG_EXPORTER_HOME="/usr/local/kafka-lag-exporter"
LAG_EXPORTER_CONFIG_FILE="${LAG_EXPORTER_HOME}/application.conf"
LAG_EXPORTER_LOGBACK_CONFIG_FILE="${LAG_EXPORTER_HOME}/logback.xml"
LOG_DIR="${LAG_EXPORTER_HOME}"

JAVA_HOME="/usr/lib/jvm/java-1.8.0"
export JAVA_HOME

### create log directory
if [ ! -d "${LOG_DIR}/backup" ]; then
    mkdir -p ${LOG_DIR}/backup
fi

### backup stdout log
DATETIME="$(date +'%Y%m%d_%H%M%S')"
if [ -f "${LOG_DIR}/nohup.kafka-lag-exporter.out" ]; then
    mv ${LOG_DIR}/nohup.kafka-lag-exporter.out ${LOG_DIR}/backup/nohup.kafka-lag-exporter.${DATETIME}.out
fi

### start
nohup ${LAG_EXPORTER_HOME}/bin/kafka-lag-exporter \
    -Dconfig.file=${LAG_EXPORTER_CONFIG_FILE} \
    -Dlogback.configurationFile=${LAG_EXPORTER_LOGBACK_CONFIG_FILE} \
    > ${LOG_DIR}/nohup.kafka-lag-exporter.out 2>&1 &
