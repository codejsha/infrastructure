#!/usr/bin/bash

source ./env-base.sh

######################################################################

function update_interface_localhost {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --command="/interface=public:write-attribute(name=inet-address,value=\${jboss.bind.address:${BIND_ADDRESS}})"
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --command="/interface=management:write-attribute(name=inet-address,value=\${jboss.bind.address.management:${BIND_ADDRESS}})"
}

function update_interface {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller=${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT} \
        --command="/interface=public:write-attribute(name=inet-address,value=\${jboss.bind.address:${BIND_ADDRESS}})"
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller=${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT} \
        --command="/interface=management:write-attribute(name=inet-address,value=\${jboss.bind.address.management:${BIND_ADDRESS}})"
}

######################################################################

# update_interface_localhost
update_interface
