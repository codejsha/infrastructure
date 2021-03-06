#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

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
