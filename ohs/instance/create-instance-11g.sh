#!/bin/bash

source ./env-base-11g.sh

ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_HOME="${INSTANCE_HOME}"

${ORACLE_HOME}/opmn/bin/opmnctl createinstance \
    -oracleInstance "${INSTANCE_HOME}" \
    -adminRegistration OFF
