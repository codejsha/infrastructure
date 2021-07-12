#!/bin/bash

KIBANA_HOME="/usr/local/kibana"
KIBANA_CONFIG_FILE="${KIBANA_HOME}/config/kibana.yml"

### create log directory
if [ ! -d "${LOG_DIR}/backup" ]; then
    mkdir -p ${LOG_DIR}/backup
fi

### backup stdout log
DATETIME="$(date +'%Y%m%d_%H%M%S')"
if [ -f "${LOG_DIR}/nohup.kibana.out" ]; then
    mv ${LOG_DIR}/nohup.kibana.out ${LOG_DIR}/backup/nohup.kibana.${DATETIME}.out
fi

### start
nohup ${KIBANA_HOME}/bin/kibana \
    --config ${KIBANA_CONFIG_FILE} \
    > ${KIBANA_HOME}/nohup.kibana.out 2>&1 &
