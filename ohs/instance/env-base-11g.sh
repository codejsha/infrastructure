#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

export MW_HOME="/usr/local/ohs"
export ORACLE_HOME="${MW_HOME}/oracle_wt1"
export INSTANCE_NAME="instance1"
export INSTANCE_HOME="${ORACLE_HOME}/instances/${INSTANCE_NAME}"
export LOG_DIR="${INSTANCE_HOME}/logs"
