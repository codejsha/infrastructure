#!/bin/bash

CONFLUENT_HOME=""
TOPIC_NAME="${1}"
PARTITION_COUNT="3"
REPLICATION_FACTOR="3"

${CONFLUENT_HOME}/bin/kafka-topics \
    --bootstrap-server "${VAR_BOOTSTRAP_SERVER}" \
    --create \
    --topic "${TOPIC_NAME}" \
    --partitions "${PARTITION_COUNT}" \
    --replication-factor "${REPLICATION_FACTOR}"
