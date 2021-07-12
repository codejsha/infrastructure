#!/bin/bash

GRAFANA_HOME="/usr/local/grafana"
GRAFANA_CONFIG_FILE="${GRAFANA_HOME}/conf/defaults.ini"

nohup ${GRAFANA_HOME}/bin/grafana-server \
    --config ${GRAFANA_CONFIG_FILE} \
    > ${GRAFANA_HOME}/nohup.grafana.out 2>&1 &
