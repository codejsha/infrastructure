#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="control-center1"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/confluent-control-center/control-center.properties"
PROPERTIES_FILE="${CONFLUENT_HOME}/properties/control-center1.properties"

LOG_DIR="/confluent/${SERVER_NAME}/logs"
export LOG_DIR

GET_DATE="$(date +'%Y%m%d_%H%M%S')"

CURRENT_USER="$(id -un)"
if [ "${CURRENT_USER}" == "root" ]; then
    echo "[ERROR] The current user is root!"
    exit
fi

if [ ! -d "${LOG_DIR}/${SERVER_NAME}" ]; then
    mkdir -p ${LOG_DIR}/${SERVER_NAME}
fi

if [ -f "${LOG_DIR}/nohup.${SERVER_NAME}.out" ]; then
    mv ${LOG_DIR}/nohup.${SERVER_NAME}.out ${LOG_DIR}/${SERVER_NAME}/nohup.${SERVER_NAME}.${GET_DATE}.out
fi

touch ${LOG_DIR}/nohup.${SERVER_NAME}.out
nohup ${CONFLUENT_HOME}/bin/control-center-start ${PROPERTIES_FILE} > ${LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
tail -f ${LOG_DIR}/nohup.${SERVER_NAME}.out