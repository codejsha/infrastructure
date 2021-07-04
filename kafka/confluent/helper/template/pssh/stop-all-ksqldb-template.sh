#!/bin/bash

CONFLUENT_HOME=""

pssh --hosts=${CONFLUENT_HOME}/pssh/hosts/ksqldb.hosts --askpass --inline "${SCRIPTS_DIR}/stop.sh"
