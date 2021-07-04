#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"

# ${CONFLUENT_HOME}/bin/kafka-server-stop

pkill -9 -ecf "kafka\.Kafka"
# pkill -15 -ecf "kafka\.Kafka"
