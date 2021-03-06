#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

CONFLUENT_HOME="/usr/local/confluent"

### source
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-datagen:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-s3-source:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-azure-blob-storage-source:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-gcs-source:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-hdfs3-source:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-jms:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-oracle-cdc:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt debezium/debezium-connector-postgresql:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt debezium/debezium-connector-mysql:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt debezium/debezium-connector-sqlserver:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt debezium/debezium-connector-mongodb:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt jcustenborder/kafka-connect-spooldir:latest

### sink
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-s3:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-azure-blob-storage:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-gcs:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-hdfs3:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-elasticsearch:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-http:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-cassandra:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-jms-sink:1.3.2
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt wepay/kafka-connect-bigquery:latest

### source and sink
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-replicator:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-mqtt:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-influxdb:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt mongodb/kafka-connect-mongodb:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-sftp:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-ftps:latest
