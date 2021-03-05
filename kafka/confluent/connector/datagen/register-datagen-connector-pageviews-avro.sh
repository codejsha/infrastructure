#!/bin/bash

# KAFKA_CONNECT_URL="kafka-connect1:8083"
KAFKA_CONNECT_URL="kafka-connect.example.com"

######################################################################

function register_connector {
    curl \
        --include \
        --request POST \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --data @datagen-connector-pageviews-avro.json \
        ${KAFKA_CONNECT_URL}/connectors
    # curl \
    #     --silent \
    #     --request POST \
    #     --header "Accept:application/json" \
    #     --header "Content-Type:application/json" \
    #     --data @datagen-connector-pageviews-avro.json \
    #     ${KAFKA_CONNECT_URL}/connectors

    echo
}

function get_connector_list {
    curl \
        --silent \
        --request GET \
        --header "Accept:application/json" \
        ${KAFKA_CONNECT_URL}/connectors | jq .[]
}

function describe_connector {
    curl \
        --silent \
        --request GET \
        --header "Accept:application/json" \
        ${KAFKA_CONNECT_URL}/connectors/datagen-pageviews-avro | jq
}

function get_connector_status {
    curl \
        --silent \
        --request GET \
        --header "Accept:application/json" \
        ${KAFKA_CONNECT_URL}/connectors/datagen-pageviews-avro/status | jq
}

function get_connector_topic {
    curl \
        --silent \
        --request GET \
        --header "Accept:application/json" \
        ${KAFKA_CONNECT_URL}/connectors/datagen-pageviews-avro/topics | jq
}

function get_connector_task {
    curl \
        --silent \
        --request GET \
        --header "Accept:application/json" \
        ${KAFKA_CONNECT_URL}/connectors/datagen-pageviews-avro/tasks | jq
}

function validate_connector_config {
    jq .config datagen-connector-pageviews-avro.json > datagen-connector-pageviews-avro-config.json

    curl \
        --silent \
        --request PUT \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --data @datagen-connector-pageviews-avro-config.json \
        ${KAFKA_CONNECT_URL}/connector-plugins/DatagenConnector/config/validate | jq
}

function delete_connector {
    curl \
        --include \
        --request DELETE \
        --header "Accept:application/json" \
        ${KAFKA_CONNECT_URL}/connectors/datagen-pageviews-avro
    # curl \
    #     --silent \
    #     --request DELETE \
    #     --header "Accept:application/json" \
    #     ${KAFKA_CONNECT_URL}/connectors/datagen-pageviews-avro
}

######################################################################

register_connector
get_connector_list
# describe_connector
# get_connector_status
# get_connector_topic
# get_connector_task
# validate_connector_config
# delete_connector
