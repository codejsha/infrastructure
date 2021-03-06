#!/bin/bash

CONFLUENT_HOME=""
TOPIC_NAME="${1}"

${CONFLUENT_HOME}/bin/kafka-topics \
    --bootstrap-server "${VAR_BOOTSTRAP_SERVER}" \
    --describe \
    --topic "${TOPIC_NAME}"
