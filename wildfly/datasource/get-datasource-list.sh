#!/usr/bin/bash

source ../env-base.sh

######################################################################

function get_datasource_resource {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/subsystem=datasources:read-resource"
}

function get_datasource_resource_json {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="/subsystem=datasources:read-resource" \
        --output-json
}

function get_datasource_list {
    DATASOURCES="$(get_datasource_resource_json | jq '.result."data-source"' | jq 'keys')"
    echo ${DATASOURCES}
}

######################################################################

# get_datasource_resource
# get_datasource_resource_json
get_datasource_list
