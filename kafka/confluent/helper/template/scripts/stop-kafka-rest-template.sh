#!/bin/bash

CONFLUENT_HOME=""

# ${CONFLUENT_HOME}/bin/kafka-rest-stop

pkill -9 -ecf "io\.confluent\.kafkarest\.KafkaRestMain"
# pkill -15 -ecf "io\.confluent\.kafkarest\.KafkaRestMain"
