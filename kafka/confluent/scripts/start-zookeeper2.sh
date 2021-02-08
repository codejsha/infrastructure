#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="zookeeper2"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka/zookeeper.properties"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka/zookeeper2.properties"
PROPERTIES_FILE="${CONFLUENT_HOME}/properties/zookeeper2.properties"

LOG_DIR="/confluent/${SERVER_NAME}/logs"
export LOG_DIR

GET_DATE="$(date +'%Y%m%d_%H%M%S')"

CURRENT_USER="$(id -un)"
if [ "${CURRENT_USER}" == "root" ]; then
  echo "[ERROR] The current user is root!"
  exit
fi

if [ -f "${LOG_DIR}/nohup.${SERVER_NAME}.out" ]; then
  mv ${LOG_DIR}/nohup.${SERVER_NAME}.out ${LOG_DIR}/${SERVER_NAME}/nohup.${SERVER_NAME}.${GET_DATE}.out
fi

touch ${LOG_DIR}/nohup.${SERVER_NAME}.out
nohup ${CONFLUENT_HOME}/bin/zookeeper-server-start ${PROPERTIES_FILE} > ${LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
tail -f ${LOG_DIR}/nohup.${SERVER_NAME}.out
