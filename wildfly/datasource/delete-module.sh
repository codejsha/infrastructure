#!/bin/bash

source ./env-base.sh
source ./env-jdbc-driver.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

MODULE_NAME="${MODULE_NAME}"

######################################################################

function remove_module {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --echo-command \
        --command="module remove --name=${MODULE_NAME}"
}

######################################################################

remove_module
