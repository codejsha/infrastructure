#!/bin/bash

function register_mysql_connector {
    curl \
        --include \
        --request POST \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --data @data-mysql.json \
        localhost:8083/connectors
}

function get_connector_list {
    curl \
        --header "Accept:application/json" \
        localhost:8083/connectors
}

function get_connector_task {
    CONNECTOR_NAME="${1}"

    curl \
        --include \
        --header "Accept:application/json" \
        --request GET \
        kafka-connect.example.com:8083/connectors/${CONNECTOR_NAME}
}

######################################################################

register_mysql_connector
get_connector_list
get_connector_task "inventory-connector"
