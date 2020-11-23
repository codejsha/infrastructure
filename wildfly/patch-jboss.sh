#!/usr/bin/bash

source ./env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

PATCH_FILE_DIR="/mnt/share/redhat-jboss-eap"

# PATCH_FILE="jboss-eap-7.2.8-patch.zip"
# PATCH_FILE="jboss-eap-7.3.1-patch.zip"
PATCH_FILE="jboss-eap-7.3.2-patch.zip"

######################################################################

function apply_patch {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="patch apply ${PATCH_FILE_DIR}/${PATCH_FILE} --override-all"
}

function rollback_patch {
    PATCH_ID="${1}"

    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="patch --patch-id=${PATCH_ID} --reset-configuration=false"
}

function restart_server {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="shutdown --restart=true"
}

######################################################################

apply_patch
# rollback_patch jboss-eap-7.2.8.CP
restart_server
