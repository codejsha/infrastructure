#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

function register_mysql_connector {
    curl \
        --include \
        --request POST \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --data @mysql-source.json \
        localhost:8083/connectors
}

function get_connector_list {
    curl \
        --header "Accept:application/json" \
        localhost:8083/connectors
}

function get_connector_task {
    curl \
        --include \
        --header "Accept:application/json" \
        --request GET \
        localhost:8083/connectors/inventory-connector
}

######################################################################

register_mysql_connector
get_connector_list
# get_connector_task
