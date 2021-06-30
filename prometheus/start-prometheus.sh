#!/bin/bash

PROMETHEUS_HOME="/usr/local/prometheus"

nohup ${PROMETHEUS_HOME}/prometheus \
    --config.file ${PROMETHEUS_HOME}/prometheus.yml \
    --web.enable-admin-api > ${PROMETHEUS_HOME}/nohup.prometheus.out 2>&1 &
