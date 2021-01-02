#!/bin/bash

source ./env-base.sh
source ./env-credential-store.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

CREDENTIAL_STORE_NAME="${CREDENTIAL_STORE_NAME}"

######################################################################

function get_credential_list {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --echo-command \
        --command="/subsystem=elytron/credential-store=${CREDENTIAL_STORE_NAME}:read-aliases()"
}

######################################################################

get_credential_list
