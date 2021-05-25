#!/bin/bash

CONFLUENT_HOME=""

PID="$(pgrep -xa java | grep ${CONFLUENT_HOME} | grep org.apache.kafka.connect.cli.ConnectDistributed | awk '{print $1}')"
# PID="$(pgrep -xa java | grep ${CONFLUENT_HOME} | grep org.apache.kafka.connect.cli.ConnectStandalone | awk '{print $1}')"
kill -9 ${PID}
