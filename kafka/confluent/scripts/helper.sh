#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

CONFLUENT_HOME="/usr/local/confluent"
BASE_DATA_DIR="/mnt"
BASE_LOG_DIR="/mnt"

######################################################################

### escape forward slash
BASE_DATA_DIR="${BASE_DATA_DIR//\//\/}"
BASE_LOG_DIR="${BASE_LOG_DIR//\//\/}"

######################################################################

### zookeeper
DATA_DIR="${BASE_DATA_DIR}/zookeeper/data"
LOG_DIR="${BASE_LOG_DIR}/zookeeper/logs"
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" start-zookeeper*.sh
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" stop-zookeeper*.sh
perl -pi -e "s/DATA_DIR=.*/DATA_DIR=\"${DATA_DIR}\"/g" start-zookeeper*.sh
perl -pi -e "s/LOG_DIR=.*/LOG_DIR=\"${LOG_DIR}\"/g" start-zookeeper*.sh

### kafka
DATA_DIR="${BASE_DATA_DIR}/kafka/data"
LOG_DIR="${BASE_LOG_DIR}/kafka/logs"
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" start-kafka*.sh
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" stop-kafka*.sh
perl -pi -e "s/DATA_DIR=.*/DATA_DIR=\"${DATA_DIR}\"/g" start-kafka*.sh
perl -pi -e "s/LOG_DIR=.*/LOG_DIR=\"${LOG_DIR}\"/g" start-kafka*.sh

### schema-registry
LOG_DIR="${BASE_LOG_DIR}/schema-registry/logs"
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" start-schema-registry*.sh
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" stop-schema-registry*.sh
perl -pi -e "s/LOG_DIR=.*/LOG_DIR=\"${LOG_DIR}\"/g" start-schema-registry*.sh

### kafka-connect
LOG_DIR="${BASE_LOG_DIR}/kafka-connect/logs"
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" start-kafka-connect*.sh
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" stop-kafka-connect*.sh
perl -pi -e "s/LOG_DIR=.*/LOG_DIR=\"${LOG_DIR}\"/g" start-kafka-connect*.sh

### kafka-rest
LOG_DIR="${BASE_LOG_DIR}/kafka-rest/logs"
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" start-kafka-rest*.sh
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" stop-kafka-rest*.sh
perl -pi -e "s/LOG_DIR=.*/LOG_DIR=\"${LOG_DIR}\"/g" start-kafka-rest*.sh

### ksqldb
DATA_DIR="${BASE_DATA_DIR}/ksqldb/data"
LOG_DIR="${BASE_LOG_DIR}/ksqldb/logs"
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" start-ksqldb*.sh
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" stop-ksqldb*.sh
perl -pi -e "s/DATA_DIR=.*/DATA_DIR=\"${DATA_DIR}\"/g" start-ksqldb*.sh
perl -pi -e "s/LOG_DIR=.*/LOG_DIR=\"${LOG_DIR}\"/g" start-ksqldb*.sh

### control-center
DATA_DIR="${BASE_DATA_DIR}/control-center/data"
LOG_DIR="${BASE_LOG_DIR}/control-center/logs"
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" start-control-center*.sh
perl -pi -e "s/CONFLUENT_HOME=.*/CONFLUENT_HOME=\"${CONFLUENT_HOME}\"/g" stop-control-center*.sh
perl -pi -e "s/DATA_DIR=.*/DATA_DIR=\"${DATA_DIR}\"/g" start-control-center*.sh
perl -pi -e "s/LOG_DIR=.*/LOG_DIR=\"${LOG_DIR}\"/g" start-control-center*.sh
