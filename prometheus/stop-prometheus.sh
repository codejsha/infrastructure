#!/bin/bash

# PROMETHEUS_HOME="/usr/local/prometheus"
# PROMETHEUS_CONFIG_FILE="${PROMETHEUS_HOME}/prometheus.yml"

pkill -9 -ecx prometheus
# pkill -15 -ecx prometheus

# pkill -9 -ecf ${PROMETHEUS_CONFIG_FILE}
# pkill -15 -ecf ${PROMETHEUS_CONFIG_FILE}
