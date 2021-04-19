#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

INSTANCE_HOME="/usr/local/ohs/oracle_wt1/instances/instance1"

${INSTANCE_HOME}/bin/opmnctl startall
