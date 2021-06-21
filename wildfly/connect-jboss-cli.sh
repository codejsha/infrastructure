#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ./env-base.sh

${JBOSS_HOME}/bin/jboss-cli.sh \
    --connect \
    --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
    --user="${USERNAME}" \
    --password="${PASSWORD}"
# ${JBOSS_HOME}/bin/jboss-cli.sh \
#     --connect \
#     --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
#     --user="${USERNAME}" \
#     --password="${PASSWORD}" \
#     ${@}
