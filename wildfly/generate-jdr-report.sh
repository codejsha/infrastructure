#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

SERVER_CONFIG_FILE="${SERVER_CONFIG_FILE}"

${JBOSS_HOME}/bin/jdr.sh \
    --host ${BIND_ADDRESS_MGMT} \
    --port ${JBOSS_MGMT_HTTP_PORT} \
    --config ${SERVER_CONFIG_FILE}
