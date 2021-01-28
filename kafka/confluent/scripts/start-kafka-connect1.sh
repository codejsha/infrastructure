#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"
SERVER_NAME="kafka-connect1"
# PROPERTIES_FILE="${CONFLUENT_HOME}/etc/schema-registry/connect-avro-distributed.properties"
PROPERTIES_FILE="${CONFLUENT_HOME}/properties/connect-avro-distributed.properties"

STDOUT_LOG_DIR="${CONFLUENT_HOME}/logs"
GET_DATE="$(date +'%Y%m%d_%H%M%S')"

CLASSPATH="${CLASSPATH}:${CONFLUENT_HOME}/share/java/kafka-connect-replicator/replicator-rest-extension-*.jar"
export CLASSPATH

CURRENT_USER="$(id -un)"
if [ "${CURRENT_USER}" == "root" ]; then
  echo "[ERROR] The current user is root!"
  exit
fi

if [ -f "${STDOUT_LOG_DIR}/nohup.${SERVER_NAME}.out" ]; then
  mv ${STDOUT_LOG_DIR}/nohup.${SERVER_NAME}.out ${STDOUT_LOG_DIR}/${SERVER_NAME}/nohup.${SERVER_NAME}.${GET_DATE}.out
fi

touch ${STDOUT_LOG_DIR}/nohup.${SERVER_NAME}.out
nohup ${CONFLUENT_HOME}/bin/connect-distributed ${PROPERTIES_FILE} > ${STDOUT_LOG_DIR}/nohup.${SERVER_NAME}.out 2>&1 &
tail -f ${STDOUT_LOG_DIR}/nohup.${SERVER_NAME}.out
