#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh
source ./env-credential-store.sh
source ./env-credentials.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

CREDENTIAL_STORE_NAME="${CREDENTIAL_STORE_NAME}"

CREDENTIALS_ALIAS="${CREDENTIALS_ALIAS}"

######################################################################

function remove_credentials {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=elytron/credential-store=${CREDENTIAL_STORE_NAME}\
    :remove-alias(alias=${CREDENTIALS_ALIAS})
run-batch
quit
EOF
}

######################################################################

remove_credentials
