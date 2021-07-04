#!/bin/bash

CONFLUENT_HOME=""

# ${CONFLUENT_HOME}/bin/control-center-stop

pkill -9 -ecf "io\.confluent\.controlcenter\.ControlCenter"
# pkill -15 -ecf "io\.confluent\.controlcenter\.ControlCenter"
