#!/bin/bash

NODE_EXPORTER_HOME="/usr/local/node-exporter"

nohup ${NODE_EXPORTER_HOME}/node_exporter \
    --collector.systemd \
    --collector.processes \
    > ${NODE_EXPORTER_HOME}/nohup.node-exporter.out 2>&1 &
