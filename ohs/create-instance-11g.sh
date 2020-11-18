#!/usr/bin/bash

source ./env-base-11g.sh

MW_HOME="${MW_HOME}"
ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_NAME="${INSTANCE_NAME}"

${ORACLE_HOME}/opmn/bin/opmnctl createinstance \
    -oracleInstance ${MW_HOME}/oracle_wt1/instances/${INSTANCE_NAME} \
    -adminRegistration OFF
