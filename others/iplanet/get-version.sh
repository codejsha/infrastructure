#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

IPLANET_HOME="/usr/local/iplanet"

######################################################################

function get_version6 {
    ${IPLANET_HOME}/https-admserv/start -version
}

function get_version {
    ${IPLANET_HOME}/admin-server/bin/startserv -version
}

######################################################################

# get_version6
get_version
