#!/bin/bash

CONFLUENT_HOME=""

pssh --hosts=${CONFLUENT_HOME}/pssh/hosts/kafka-connect.hosts --askpass --inline "${SCRIPT_DIR}/start.sh"
