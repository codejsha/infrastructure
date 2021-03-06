#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base-11g.sh

ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_HOME="${INSTANCE_HOME}"

${ORACLE_HOME}/opmn/bin/opmnctl createinstance \
    -oracleInstance "${INSTANCE_HOME}" \
    -adminRegistration OFF
