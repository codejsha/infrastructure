#!/usr/bin/bash

source ./env-base.sh

######################################################################

function get_system_properties {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/core-service=platform-mbean/type=runtime:read-attribute(name=system-properties)"
}

######################################################################

get_system_properties
