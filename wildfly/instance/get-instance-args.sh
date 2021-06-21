#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

######################################################################

function get_server_args {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
        --echo-command \
        --command="/core-service=platform-mbean/type=runtime:read-attribute(name=input-arguments)"
}

######################################################################

get_server_args
