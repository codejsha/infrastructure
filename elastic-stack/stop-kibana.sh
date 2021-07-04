#!/bin/bash

KIBANA_HOME="/usr/local/kibana"

pkill -9 -ecf "$(readlink -f ${KIBANA_HOME}/node/bin/node)"
# pkill -15 -ecf "$(readlink -f ${KIBANA_HOME}/node/bin/node)"
