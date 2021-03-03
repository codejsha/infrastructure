#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"

### source
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-datagen:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-oracle-cdc:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-s3-source:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-hdfs3-source:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt debezium/debezium-connector-postgresql:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt debezium/debezium-connector-mysql:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt debezium/debezium-connector-sqlserver:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt debezium/debezium-connector-mongodb:latest

### sink
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-elasticsearch:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-s3:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-http:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-hdfs3:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-cassandra:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt wepay/kafka-connect-bigquery:latest

### source and sink
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-replicator:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:latest
${CONFLUENT_HOME}/bin/confluent-hub install --no-prompt mongodb/kafka-connect-mongodb:latest
