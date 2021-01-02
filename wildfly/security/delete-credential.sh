#!/bin/bash

source ./env-base.sh
source ./env-credential-store.sh
source ./env-credential.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

CREDENTIAL_STORE_NAME="${CREDENTIAL_STORE_NAME}"

CREDENTIAL_ALIAS="${CREDENTIAL_ALIAS}"

######################################################################

function remove_credential {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=elytron/credential-store=${CREDENTIAL_STORE_NAME}:remove-alias(alias=${CREDENTIAL_ALIAS})
run-batch
quit
EOF
}

######################################################################

remove_credential
