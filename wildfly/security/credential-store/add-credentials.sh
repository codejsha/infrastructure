#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../../env-base.sh
source ./env-credential-store.sh
source ./env-credentials.sh

######################################################################

function add_credentials {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/subsystem=elytron/credential-store=${CREDENTIAL_STORE_NAME}\
    :add-alias(alias=${CREDENTIALS_ALIAS},\
        secret-value=${CREDENTIALS_SECRET_VALUE})
run-batch
quit
EOF
}

######################################################################

add_credentials
