#!/bin/bash

KIBANA_HOME="/usr/local/kibana"
KIBANA_CONFIG_FILE="${KIBANA_HOME}/config/kibana.yml"

pkill -9 -ecf "${KIBANA_CONFIG_FILE}"
# pkill -15 -ecf "${KIBANA_CONFIG_FILE}"
