#!/usr/bin/bash

IPLANET_HOME="/usr/local/iplanet"
MAJOR_VERSION="7"    # (available: 6, 7)

######################################################################

function get_version {
    if [ "${MAJOR_VERSION}" == "7" ]; then
        ${IPLANET_HOME}/admin-server/bin/startserv -version
    elif [ "${MAJOR_VERSION}" == "6" ]; then
        ${IPLANET_HOME}/https-admserv/start -version
    fi
}

######################################################################

get_version
