#!/bin/bash

CONFLUENT_HOME=""

${CONFLUENT_HOME}/bin/kafka-topics \
    --bootstrap-server "${VAR_BOOTSTRAP_SERVER}" \
    --list
