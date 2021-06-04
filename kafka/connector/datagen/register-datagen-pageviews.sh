#!/bin/bash

KAFKA_CONNECT_URL="http://localhost:8083"
# KAFKA_CONNECT_URL="http://kafka-connect1:8083"
# KAFKA_CONNECT_URL="http://kafka-connect.example.com"

######################################################################

function register_connector {
    curl \
        --include \
        --request POST \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --data @datagen-pageviews.json \
        ${KAFKA_CONNECT_URL}/connectors
    # curl \
    #     --include \
    #     --request POST \
    #     --header "Accept:application/json" \
    #     --header "Content-Type:application/json" \
    #     --data @datagen-pageviews-kubernetes.json \
    #     ${KAFKA_CONNECT_URL}/connectors

    echo
}

function delete_connector {
    curl \
        --include \
        --request DELETE \
        --header "Accept:application/json" \
        ${KAFKA_CONNECT_URL}/connectors/datagen-pageviews
}

######################################################################

delete_connector
register_connector
