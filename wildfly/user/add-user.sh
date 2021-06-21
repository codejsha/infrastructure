#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

${JBOSS_HOME}/bin/add-user.sh \
    --user "${USERNAME}" \
    --password "${PASSWORD}" \
    -sc ${JBOSS_BASE_DIR}/configuration
# ${JBOSS_HOME}/bin/add-user.sh \
#     --user "developer" \
#     --password "developer" \
#     -sc ${JBOSS_BASE_DIR}/configuration
