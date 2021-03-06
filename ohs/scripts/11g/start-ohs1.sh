#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

INSTANCE_HOME="/usr/local/ohs/oracle_wt1/instances/instance1"
COMPONENT_NAME="ohs1"

${INSTANCE_HOME}/bin/opmnctl startproc ias-component=${COMPONENT_NAME} process-type=OHS
