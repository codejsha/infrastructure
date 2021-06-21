#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base-11g.sh
source ./env-component-11g.sh

MW_HOME="${MW_HOME}"
ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_NAME="${INSTANCE_NAME}"
COMPONENT_NAME="${COMPONENT_NAME}"

${ORACLE_HOME}/opmn/bin/opmnctl createcomponent \
    -oracleInstance ${MW_HOME}/oracle_wt1/instances/${INSTANCE_NAME} \
    -componentType OHS \
    -componentName ${COMPONENT_NAME}
