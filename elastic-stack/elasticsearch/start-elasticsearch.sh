#!/bin/bash

ELASTICSEARCH_HOME="/usr/local/elasticsearch"
LOG_DIR="${ELASTICSEARCH_HOME}"

### create log directory
if [ ! -d "${LOG_DIR}/backup" ]; then
    mkdir -p ${LOG_DIR}/backup
fi

### backup stdout log
DATETIME="$(date +'%Y%m%d_%H%M%S')"
if [ -f "${LOG_DIR}/nohup.elasticsearch.out" ]; then
    mv ${LOG_DIR}/nohup.elasticsearch.out ${LOG_DIR}/backup/nohup.elasticsearch.${DATETIME}.out
fi

### start
nohup ${ELASTICSEARCH_HOME}/bin/elasticsearch \
    > ${ELASTICSEARCH_HOME}/nohup.elasticsearch.out 2>&1 &
