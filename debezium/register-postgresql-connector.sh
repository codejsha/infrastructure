#!/bin/bash

KAFKA_CONNECT_URL="kafka-connect.example.com:8083"
# KAFKA_CONNECT_URL="kafka-connect1.example.com:8083"
# KAFKA_CONNECT_URL="kafka-connect2.example.com:8083"

######################################################################

function register_postgresql_connector {
    curl \
        --include \
        --request POST \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --data @data-postgresql.json \
        ${KAFKA_CONNECT_URL}/connectors
}

function get_connector_list {
    curl \
        --header "Accept:application/json" \
        ${KAFKA_CONNECT_URL}/connectors
}

function get_connector_task {
    CONNECTOR_NAME="${1}"

    curl \
        --include \
        --header "Accept:application/json" \
        --request GET \
        ${KAFKA_CONNECT_URL}/connectors/${CONNECTOR_NAME}
}

######################################################################

register_postgresql_connector

get_connector_list
# get_connector_task "postgres-connector"
