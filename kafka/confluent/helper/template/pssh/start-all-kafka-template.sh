#!/bin/bash

CONFLUENT_HOME=""

pssh --hosts=${CONFLUENT_HOME}/pssh/hosts/kafka.hosts --askpass --inline "${CONFLUENT_HOME}/scripts/start.sh"
