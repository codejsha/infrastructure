#!/usr/bin/bash

source ./env-base.sh
ARGS="${@}"

######################################################################

function connect_jboss_cli {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        ${ARGS}
}

######################################################################

connect_jboss_cli
