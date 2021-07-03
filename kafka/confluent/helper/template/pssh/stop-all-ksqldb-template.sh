#!/bin/bash

CONFLUENT_HOME=""

pssh --hosts=${CONFLUENT_HOME}/pssh/hosts/ksqldb.hosts --askpass --inline "${CONFLUENT_HOME}/scripts/stop.sh"
