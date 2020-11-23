#!/usr/bin/bash

source ./env-base.sh

JBOSS_HOME="${JBOSS_HOME}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

UPDATE_BIND_ADDRESS="0.0.0.0"
UPDATE_BIND_ADDRESS_MGMT="127.0.0.1"

######################################################################

function update_interface_localhost {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --command="/interface=public:write-attribute(name=inet-address,value=\${jboss.bind.address:${UPDATE_BIND_ADDRESS}})"
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --command="/interface=management:write-attribute(name=inet-address,value=\${jboss.bind.address.management:${UPDATE_BIND_ADDRESS_MGMT}})"
}

function update_interface {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller=${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT} \
        --command="/interface=public:write-attribute(name=inet-address,value=\${jboss.bind.address:${UPDATE_BIND_ADDRESS}})"
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller=${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT} \
        --command="/interface=management:write-attribute(name=inet-address,value=\${jboss.bind.address.management:${UPDATE_BIND_ADDRESS_MGMT}})"
}

######################################################################

# update_interface_localhost
update_interface
