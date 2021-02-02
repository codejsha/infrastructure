#!/bin/bash

export NODE_MANAGER_NAME="${1}"

ADMIN_SERVER_URL="http://test.example.com:7001"

######################################################################

function start_edit {
    curl \
        --user weblogic:welcome1 \
        --request POST \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --header "X-Requested-By:MyClient" \
        ${ADMIN_SERVER_URL}/management/weblogic/latest/edit/changeManager/startEdit
}

function cancel_edit {
    curl \
        --user weblogic:welcome1 \
        --request POST \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --header "X-Requested-By:MyClient" \
        ${ADMIN_SERVER_URL}/management/weblogic/latest/edit/changeManager/cancelEdit
}

function activate {
    curl \
        --user weblogic:welcome1 \
        --request POST \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --header "X-Requested-By:MyClient" \
        ${ADMIN_SERVER_URL}/management/weblogic/latest/edit/changeManager/activate
}

function create_node_manager {
    curl \
        --user weblogic:welcome1 \
        --request POST \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --header "X-Requested-By:MyClient" \
        --data '{"name":'"${NODE_MANAGER_NAME}"'}' \
        ${ADMIN_SERVER_URL}/management/weblogic/latest/edit/machines

    # envsubst < ./nodemgr.json > ./nodemgr-temp.json
    # curl \
    #     --user weblogic:welcome1 \
    #     --request POST \
    #     --header "Accept:application/json" \
    #     --header "Content-Type:application/json" \
    #     --header "X-Requested-By:MyClient" \
    #     --data @nodemgr-temp.json \
    #     ${ADMIN_SERVER_URL}/management/weblogic/latest/edit/machines
}

######################################################################

start_edit
# cancel_edit

create_node_manager

activate