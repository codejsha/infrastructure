#!/bin/bash

CONFLUENT_HOME=""

pssh --hosts=${CONFLUENT_HOME}/pssh/hosts/kafka-rest.hosts --askpass --inline "${SCRIPTS_DIR}/stop.sh"
