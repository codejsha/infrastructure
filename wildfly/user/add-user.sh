#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
JBOSS_BASE_DIR="${JBOSS_BASE_DIR}"

PASSWORD="${PASSWORD}"

${JBOSS_HOME}/bin/add-user.sh \
    --user "admin" \
    --password "${PASSWORD}" \
    -sc ${JBOSS_BASE_DIR}/configuration
# ${JBOSS_HOME}/bin/add-user.sh \
#     --user "developer" \
#     --password "${PASSWORD}" \
#     -sc ${JBOSS_BASE_DIR}/configuration
