#!/usr/bin/bash

IPLANET_HOME="/usr/local/iplanet"
MAJOR_VERSION="7"    # (available: 6, 7)

function check_version {
    if [ "${MAJOR_VERSION}" == "7" ]; then
        ${IPLANET_HOME}/admin-server/bin/startserv -version
    elif [ "${MAJOR_VERSION}" == "6" ]; then
        ${IPLANET_HOME}/https-admserv/start -version
    fi
}

check_version

### 6.x Result:
###
### Sun Microsystems, Inc.
### Sun ONE Web Server 6.1SP9 B01/11/2008 14:24

### 7.x Result:
###
### Oracle Corporation
### Oracle iPlanet Web Server 7.0.27 B09/27/2017 03:27
