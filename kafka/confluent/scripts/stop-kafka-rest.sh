#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"

# ${CONFLUENT_HOME}/bin/kafka-rest-stop

pkill -9 -ecf "io\.confluent\.kafkarest\.KafkaRestMain"
# pkill -9 -ecf "io.confluent.kafkarest.KafkaRestMain"
