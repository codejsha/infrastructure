#!/bin/bash

CONFLUENT_HOME=""

pssh --hosts=${CONFLUENT_HOME}/pssh/hosts/zookeeper.hosts --askpass --inline "${CONFLUENT_HOME}/scripts/start.sh"
