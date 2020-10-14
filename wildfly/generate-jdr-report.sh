#!/usr/bin/bash

source ./env-base.sh

${JBOSS_HOME}/bin/jdr.sh \
    --host ${BIND_ADDRESS_MGMT} \
    --port ${JBOSS_MGMT_HTTP_PORT} \
    --config ${SERVER_CONFIG_FILE}
