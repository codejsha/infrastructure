#!/bin/bash

NODE_EXPORTER_HOME="/usr/local/node-exporter"
LOG_DIR="${NODE_EXPORTER_HOME}"

### create log directory
if [ ! -d "${LOG_DIR}/backup" ]; then
    mkdir -p ${LOG_DIR}/backup
fi

### backup stdout log
DATETIME="$(date +'%Y%m%d_%H%M%S')"
if [ -f "${LOG_DIR}/nohup.node-exporter.out" ]; then
    mv ${LOG_DIR}/nohup.node-exporter.out ${LOG_DIR}/backup/nohup.node-exporter.${DATETIME}.out
fi

### start
nohup ${NODE_EXPORTER_HOME}/node_exporter \
    --collector.systemd \
    --collector.processes \
    > ${LOG_DIR}/nohup.node-exporter.out 2>&1 &
