#!/bin/bash

GRAFANA_HOME="/usr/local/grafana"

nohup ${GRAFANA_HOME}/bin/grafana-server \
    > ${GRAFANA_HOME}/nohup.grafana.out 2>&1 &
