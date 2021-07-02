#!/bin/bash

KIBANA_HOME="/usr/local/kibana"

nohup ${KIBANA_HOME}/bin/kibana \
    > ${KIBANA_HOME}/nohup.kibana.out 2>&1 &
