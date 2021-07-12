#!/bin/bash

PROMETHEUS_HOME="/usr/local/prometheus"
PROMETHEUS_CONFIG_FILE="${PROMETHEUS_HOME}/prometheus.yml"
LOG_DIR="${PROMETHEUS_HOME}"

### create log directory
if [ ! -d "${LOG_DIR}/backup" ]; then
    mkdir -p ${LOG_DIR}/backup
fi

### backup stdout log
DATETIME="$(date +'%Y%m%d_%H%M%S')"
if [ -f "${LOG_DIR}/nohup.prometheus.out" ]; then
    mv ${LOG_DIR}/nohup.prometheus.out ${LOG_DIR}/backup/nohup.prometheus.${DATETIME}.out
fi

### start
nohup ${PROMETHEUS_HOME}/prometheus \
    --config.file ${PROMETHEUS_HOME} \
    --web.enable-admin-api > ${LOG_DIR}/nohup.prometheus.out 2>&1 &
