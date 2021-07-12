#!/bin/bash

# GRAFANA_HOME="/usr/local/grafana"
# GRAFANA_CONFIG_FILE="${GRAFANA_HOME}/conf/defaults.ini"

pkill -9 -ecx grafana-server
# pkill -15 -ecx grafana-server

# pkill -9 -ecf ${GRAFANA_CONFIG_FILE}
# pkill -15 -ecf ${GRAFANA_CONFIG_FILE}

