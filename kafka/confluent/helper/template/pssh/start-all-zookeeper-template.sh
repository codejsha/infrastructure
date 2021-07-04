#!/bin/bash

CONFLUENT_HOME=""

pssh --hosts=${CONFLUENT_HOME}/pssh/hosts/zookeeper.hosts --askpass --inline "${SCRIPTS_DIR}/start.sh"
