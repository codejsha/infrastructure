#!/bin/bash

export MANAGED_SERVER_NAME="${1}"

ADMIN_SERVER_URL="http://test.example.com:7001"

envsubst < ./server.json > ./server-temp.json

######################################################################

function start_edit {
    curl \
        --user weblogic:welcome1 \
        -X POST \
        -H "Accept:application/json" \
        -H "Content-Type:application/json" \
        -H "X-Requested-By:MyClient" \
        ${ADMIN_SERVER_URL}/management/weblogic/latest/edit/changeManager/startEdit \
        | jq
}

function cancel_edit {
    curl \
        --user weblogic:welcome1 \
        -X POST \
        -H "Accept:application/json" \
        -H "Content-Type:application/json" \
        -H "X-Requested-By:MyClient" \
        ${ADMIN_SERVER_URL}/management/weblogic/latest/edit/changeManager/cancelEdit \
        | jq
}

function activate {
    curl \
        --user weblogic:welcome1 \
        -X POST \
        -H "Accept:application/json" \
        -H "Content-Type:application/json" \
        -H "X-Requested-By:MyClient" \
        ${ADMIN_SERVER_URL}/management/weblogic/latest/edit/changeManager/activate \
        | jq
}

function create_server {
    curl \
        --user weblogic:welcome1 \
        -X POST \
        -H "Accept:application/json" \
        -H "Content-Type:application/json" \
        -H "X-Requested-By:MyClient" \
        -d @server-temp.json \
        ${ADMIN_SERVER_URL}/management/weblogic/latest/edit/servers \
        | jq
}

######################################################################

start_edit
# cancel_edit
create_server
activate
