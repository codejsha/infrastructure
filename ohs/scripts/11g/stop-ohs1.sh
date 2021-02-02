#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

INSTANCE_HOME="/usr/local/ohs/oracle_wt1/instances/instance1"
COMPONENT_NAME="ohs1"

${INSTANCE_HOME}/bin/opmnctl stopproc ias-component=${COMPONENT_NAME} process-type=OHS
