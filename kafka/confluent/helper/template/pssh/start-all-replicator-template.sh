#!/bin/bash

CONFLUENT_HOME=""

pssh --hosts=${CONFLUENT_HOME}/pssh/hosts/replicator.hosts --askpass --inline "${SCRIPTS_DIR}/start.sh"
