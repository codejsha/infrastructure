#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="zookeeper3"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka/zookeeper.properties"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/kafka/zookeeper3.properties"
PROPERTIES_FILE="${CONFLUENT_HOME}/properties/zookeeper3.properties"

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
nohup ${CONFLUENT_HOME}/bin/zookeeper-server-start ${PROPERTIES_FILE} > ${STDOUT_LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
tail -f ${STDOUT_LOG_DIR}/nohup.${SERVER_NAME}.out
