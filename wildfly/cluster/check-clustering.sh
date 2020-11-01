#!/usr/bin/bash

source ../env-base.sh

######################################################################

function check_clustering {
    ${JBOSS_HOME}/bin/jboss-cli.sh \
        --connect \
        --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
<<EOF
batch
/subsystem=jgroups/channel=ee:read-attribute(name=view)
run-batch
quit
EOF
}

######################################################################

check_clustering
