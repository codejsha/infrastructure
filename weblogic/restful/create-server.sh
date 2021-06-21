#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

export MANAGED_SERVER_NAME="${1}"

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

function create_server {
    curl \
        --user weblogic:welcome1 \
        --request POST \
        --header "Accept:application/json" \
        --header "Content-Type:application/json" \
        --header "X-Requested-By:MyClient" \
        --data '{"name":'"${MANAGED_SERVER_NAME}"'}' \
        ${ADMIN_SERVER_URL}/management/weblogic/latest/edit/servers

    # envsubst < ./server.json > ./server-temp.json
    # curl \
    #     --user weblogic:welcome1 \
    #     --request POST \
    #     --header "Accept:application/json" \
    #     --header "Content-Type:application/json" \
    #     --header "X-Requested-By:MyClient" \
    #     --data @server-temp.json \
    #     ${ADMIN_SERVER_URL}/management/weblogic/latest/edit/servers
}

######################################################################

start_edit
# cancel_edit

create_server

activate
