#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"

# ${CONFLUENT_HOME}/bin/control-center-stop

pkill -9 -ecf "io\.confluent\.controlcenter\.ControlCenter"
# pkill -9 -ecf "io.confluent.controlcenter.ControlCenter"
