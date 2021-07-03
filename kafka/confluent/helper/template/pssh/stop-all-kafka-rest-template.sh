#!/bin/bash

CONFLUENT_HOME=""

pssh --hosts=${CONFLUENT_HOME}/pssh/hosts/kafka-rest.hosts --askpass --inline "${CONFLUENT_HOME}/scripts/stop.sh"
