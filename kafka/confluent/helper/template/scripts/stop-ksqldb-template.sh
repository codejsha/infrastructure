#!/bin/bash

CONFLUENT_HOME=""

# ${CONFLUENT_HOME}/bin/ksql-server-stop

pkill -9 -ecf "io\.confluent\.ksql\.rest\.server\.KsqlServerMain"
# pkill -15 -ecf "io\.confluent\.ksql\.rest\.server\.KsqlServerMain"
