#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

export MW_HOME="/usr/local/ohs"
export ORACLE_HOME="${MW_HOME}/oracle_wt1"
export INSTANCE_NAME="instance1"
export INSTANCE_HOME="${ORACLE_HOME}/instances/${INSTANCE_NAME}"
export LOG_DIR="${INSTANCE_HOME}/logs"
