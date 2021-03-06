#!/bin/bash

KAFKA_CONNECT_URL="http://localhost:8083"
# KAFKA_CONNECT_URL="http://kafka-connect1:8083"
# KAFKA_CONNECT_URL="http://kafka-connect.example.com"

CONNECTOR_CONFIG_FILE="datagen-users.json"
# CONNECTOR_CONFIG_FILE="datagen-users-kubernetes.json"

CONNECTOR_NAME="datagen-users"

######################################################################

function register_connector {
    curl \
        --request POST \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --data @${CONNECTOR_CONFIG_FILE} \
        ${KAFKA_CONNECT_URL}/connectors

    echo
}

function delete_connector {
    curl \
        --request DELETE \
        --header "Accept:application/json" \
        ${KAFKA_CONNECT_URL}/connectors/${CONNECTOR_NAME}
}

######################################################################

delete_connector
register_connector
