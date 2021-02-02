#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="kafka2"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka/server.properties"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka/server2.properties"
PROPERTIES_FILE="${CONFLUENT_HOME}/properties/server2.properties"

STDOUT_LOG_DIR="${CONFLUENT_HOME}/logs"
GET_DATE="$(date +'%Y%m%d_%H%M%S')"

CURRENT_USER="$(id -un)"
if [ "${CURRENT_USER}" == "root" ]; then
  echo "[ERROR] The current user is root!"
  exit
fi

if [ -f "${STDOUT_LOG_DIR}/nohup.${SERVER_NAME}.out" ]; then
  mv ${STDOUT_LOG_DIR}/nohup.${SERVER_NAME}.out ${STDOUT_LOG_DIR}/${SERVER_NAME}/nohup.${SERVER_NAME}.${GET_DATE}.out
fi

touch ${STDOUT_LOG_DIR}/nohup.${SERVER_NAME}.out
nohup ${CONFLUENT_HOME}/bin/kafka-server-start ${PROPERTIES_FILE} > ${STDOUT_LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
tail -f ${STDOUT_LOG_DIR}/nohup.${SERVER_NAME}.out