#!/usr/bin/bash

source ./env-base.sh

MODULE_NAME="${1:-MODULE_NAME}"

######################################################################

function remove_module {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="module remove --name=${MODULE_NAME}"
}

######################################################################

remove_module
