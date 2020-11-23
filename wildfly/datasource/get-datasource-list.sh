#!/bin/bash

source ../env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

######################################################################

function get_datasource_resource {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=datasources:read-resource
run-batch
quit
EOF
}

function get_datasource_resource_json {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --output-json \
<<EOF
batch
/subsystem=datasources:read-resource
run-batch
quit
EOF
}

function get_datasource_list {
    DATASOURCES="$(get_datasource_resource_json | jq '.result."data-source"' | jq 'keys')"
    echo ${DATASOURCES}
}

######################################################################

# get_datasource_resource
# get_datasource_resource_json
get_datasource_list
