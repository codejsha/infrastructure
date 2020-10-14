#!/usr/bin/bash

source ./env-base.sh

PATCH_FILE_DIR="/mnt/share/redhat-jboss-eap"

# PATCH_FILE="jboss-eap-7.2.8-patch.zip"
# PATCH_FILE="jboss-eap-7.3.1-patch.zip"
PATCH_FILE="jboss-eap-7.3.2-patch.zip"

######################################################################

function jboss_patch_apply {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="patch apply ${PATCH_FILE_DIR}/${PATCH_FILE}"
}

function jboss_restart {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
        --command="shutdown --restart=true"
}

######################################################################

jboss_patch_apply
jboss_restart
