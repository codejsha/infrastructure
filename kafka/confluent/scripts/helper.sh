#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

######################################################################

function replace_variable {
    local START_SCRIPT_NAME="${1}"
    local STOP_SCRIPT_NAME="${2}"
    local CONFLUENT_HOME="${3}"
    local LOG_DIR="${4}"
    local DATA_DIR="${5}"

    ### escape forward slash
    local CONFLUENT_HOME="${CONFLUENT_HOME//\//\\/}"
    local DATA_DIR="${DATA_DIR//\//\\/}"
    local LOG_DIR="${LOG_DIR//\//\\/}"

    perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" ${START_SCRIPT_NAME}
    perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" ${STOP_SCRIPT_NAME}
    perl -pi -e "s/DATA_DIR=.*/DATA_DIR=\"${DATA_DIR}\"/g" ${START_SCRIPT_NAME}
    perl -pi -e "s/LOG_DIR=.*/LOG_DIR=\"${LOG_DIR}\"/g" ${START_SCRIPT_NAME}
}

######################################################################

CONFLUENT_HOME="/usr/local/confluent"

### zookeeper
DATA_DIR="/mnt/zookeeper/data"
LOG_DIR="/mnt/zookeeper/logs"
replace_variable "start-zookeeper*.sh" "stop-zookeeper*.sh" ${CONFLUENT_HOME} ${LOG_DIR} ${DATA_DIR}

### kafka
DATA_DIR="/mnt/kafka/data"
LOG_DIR="/mnt/kafka/logs"
replace_variable "start-kafka*.sh" "stop-kafka*.sh" ${CONFLUENT_HOME} ${LOG_DIR} ${DATA_DIR}

### schema-registry
LOG_DIR="/mnt/schema-registry/logs"
replace_variable "start-schema-registry*.sh" "stop-schema-registry*.sh" ${CONFLUENT_HOME} ${LOG_DIR}

### kafka-connect
LOG_DIR="/mnt/kafka-connect/logs"
replace_variable "start-kafka-connect*.sh" "stop-kafka-connect*.sh" ${CONFLUENT_HOME} ${LOG_DIR}

### kafka-rest
LOG_DIR="/mnt/kafka-rest/logs"
replace_variable "start-kafka-rest*.sh" "stop-kafka-rest*.sh" ${CONFLUENT_HOME} ${LOG_DIR}

### ksqldb
DATA_DIR="/mnt/ksqldb/data"
LOG_DIR="/mnt/ksqldb/logs"
replace_variable "start-ksqldb*.sh" "stop-ksqldb*.sh" ${CONFLUENT_HOME} ${LOG_DIR} ${DATA_DIR}

### control-center
DATA_DIR="/mnt/control-center/data"
LOG_DIR="/mnt/control-center/logs"
replace_variable "start-control-center*.sh" "stop-control-center*.sh" ${CONFLUENT_HOME} ${LOG_DIR} ${DATA_DIR}
