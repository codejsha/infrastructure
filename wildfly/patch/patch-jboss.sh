#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"
USERNAME="${USERNAME}"
PASSWORD="${PASSWORD}"

PATCH_FILE_DIR="/mnt/share/redhat-jboss-eap"

# PATCH_FILE="jboss-eap-7.2.8-patch.zip"
# PATCH_FILE="jboss-eap-7.3.1-patch.zip"
PATCH_FILE="jboss-eap-7.3.2-patch.zip"

######################################################################

function apply_patch {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
        --echo-command \
        --command="patch apply ${PATCH_FILE_DIR}/${PATCH_FILE} --override-all"
}

function rollback_patch {
    local PATCH_ID="${1}"

    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
        --echo-command \
        --command="patch --patch-id=${PATCH_ID} --reset-configuration=false"
}

function restart_server {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --user="${USERNAME}" \
        --password="${PASSWORD}" \
        --echo-command \
        --command="shutdown --restart=true"
}

######################################################################

apply_patch
# rollback_patch jboss-eap-7.2.8.CP
restart_server
