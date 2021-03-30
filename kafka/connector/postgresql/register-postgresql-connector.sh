#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

# KAFKA_CONNECT_URL="http://localhost:8083"
# KAFKA_CONNECT_URL="http://kafka-connect1:8083"
KAFKA_CONNECT_URL="http://kafka-connect.example.com"

######################################################################

function register_connector {
    curl \
        --include \
        --request POST \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --data @postgresql-connector.json \
        ${KAFKA_CONNECT_URL}/connectors
    # curl \
    #     --silent \
    #     --request POST \
    #     --header "Accept:application/json" \
    #     --header "Content-Type:application/json" \
    #     --data @postgresql-connector.json \
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
        ${KAFKA_CONNECT_URL}/connectors/postgresql-connector | jq
}

function get_connector_status {
    curl \
        --silent \
        --request GET \
        --header "Accept:application/json" \
        ${KAFKA_CONNECT_URL}/connectors/postgresql-connector/status | jq
}

function get_connector_topic {
    curl \
        --silent \
        --request GET \
        --header "Accept:application/json" \
        ${KAFKA_CONNECT_URL}/connectors/postgresql-connector/topics | jq
}

function get_connector_task {
    curl \
        --silent \
        --request GET \
        --header "Accept:application/json" \
        ${KAFKA_CONNECT_URL}/connectors/postgresql-connector/tasks | jq
}

function validate_connector_config {
    # curl \
    #     --silent \
    #     --request PUT \
    #     --header "Accept:application/json" \
    #     --header "Content-Type:application/json" \
    #     --data '{}' \
    #     ${KAFKA_CONNECT_URL}/connector-plugins/PostgresConnector/config/validate | jq

    jq .config postgresql-connector.json > postgresql-connector-config.json
    curl \
        --silent \
        --request PUT \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --data @postgresql-connector-config.json \
        ${KAFKA_CONNECT_URL}/connector-plugins/PostgresConnector/config/validate | jq
}

function delete_connector {
    curl \
        --include \
        --request DELETE \
        --header "Accept:application/json" \
        ${KAFKA_CONNECT_URL}/connectors/postgresql-connector
    # curl \
    #     --silent \
    #     --request DELETE \
    #     --header "Accept:application/json" \
    #     ${KAFKA_CONNECT_URL}/connectors/postgresql-connector
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
