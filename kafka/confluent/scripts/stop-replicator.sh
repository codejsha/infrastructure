#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"

# PID="$(pgrep -xa java | grep ${CONFLUENT_HOME} | grep io.confluent.connect.replicator.ReplicatorApp | awk '{print $1}')"
PID="$(pgrep -xa java | grep ${CONFLUENT_HOME} | grep org.apache.kafka.connect.cli.ConnectDistributed | awk '{print $1}')"
# PID="$(pgrep -xa java | grep ${CONFLUENT_HOME} | grep org.apache.kafka.connect.cli.ConnectStandalone | awk '{print $1}')"
kill -9 ${PID}
