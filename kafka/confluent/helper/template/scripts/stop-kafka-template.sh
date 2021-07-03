#!/bin/bash

CONFLUENT_HOME=""

# ${CONFLUENT_HOME}/bin/kafka-server-stop

pkill -9 -ecf "kafka\.Kafka"
