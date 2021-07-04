#!/bin/bash

CONFLUENT_HOME=""

pssh --hosts=${CONFLUENT_HOME}/pssh/hosts/schema-registry.hosts --askpass --inline "${SCRIPTS_DIR}/start.sh"
