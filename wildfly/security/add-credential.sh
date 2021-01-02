#!/bin/bash

source ./env-base.sh
source ./env-credential-store.sh
source ./env-credential.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

CREDENTIAL_STORE_NAME="${CREDENTIAL_STORE_NAME}"

CREDENTIAL_ALIAS="${CREDENTIAL_ALIAS}"
CREDENTIAL_SECRET_VALUE="${CREDENTIAL_SECRET_VALUE}"

######################################################################

function add_credential {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=elytron/credential-store==${CREDENTIAL_STORE_NAME}\
    :add-alias(alias=${CREDENTIAL_ALIAS},\
        secret-value=${CREDENTIAL_SECRET_VALUE})
run-batch
quit
EOF
}

######################################################################

add_credential
