#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../../env-base.sh
source ./env-credential-store.sh

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
