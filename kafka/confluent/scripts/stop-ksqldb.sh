#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"

# ${CONFLUENT_HOME}/bin/ksql-server-stop

pkill -9 -ecf "io\.confluent\.ksql\.rest\.server\.KsqlServerMain"
# pkill -9 -ecf "io.confluent.ksql.rest.server.KsqlServerMain"
