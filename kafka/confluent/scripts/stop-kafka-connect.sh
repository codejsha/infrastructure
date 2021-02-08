#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"

PID="$(pgrep -xa java | grep ${CONFLUENT_HOME} | grep org.apache.kafka.connect.cli | awk '{print $1}')"
kill -9 ${PID}
