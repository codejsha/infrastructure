#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh
source ./env-credential-store.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"
USERNAME="${USERNAME}"
PASSWORD="${PASSWORD}"

CREDENTIAL_STORE_NAME="${CREDENTIAL_STORE_NAME}"
CREDENTIAL_STORE_LOCATION="${CREDENTIAL_STORE_LOCATION}"
CREDENTIAL_STORE_CLEAR_TEXT="${CREDENTIAL_STORE_CLEAR_TEXT}"

######################################################################

function create_credential_store {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
<<EOF
batch
/subsystem=elytron/credential-store=${CREDENTIAL_STORE_NAME}\
    :add(location=${CREDENTIAL_STORE_LOCATION},\
        credential-reference={clear-text=${CREDENTIAL_STORE_CLEAR_TEXT}},\
        create=true)
run-batch
quit
EOF
}

######################################################################

create_credential_store
