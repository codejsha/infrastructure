#!/usr/bin/bash

IPLANET_HOME="/usr/local/iplanet"
IPLANET_SERVER="server1"

if [ "${IPLANET_SERVER}" == "admin-server" ]; then
    ln -snf ${IPLANET_HOME}/admin-server/bin/startserv ${IPLANET_HOME}/start-admin.sh
    ln -snf ${IPLANET_HOME}/admin-server/bin/stopserv ${IPLANET_HOME}/stop-admin.sh
    chmod 750 ${IPLANET_HOME}/start-admin.sh
    chmod 750 ${IPLANET_HOME}/stop-admin.sh

else
    ln -snf ${IPLANET_HOME}/https-${IPLANET_SERVER}/bin/startserv ${IPLANET_HOME}/start-${IPLANET_SERVER}.sh
    ln -snf ${IPLANET_HOME}/https-${IPLANET_SERVER}/bin/stopserv ${IPLANET_HOME}/stop-${IPLANET_SERVER}.sh
    chmod 750 ${IPLANET_HOME}/start-${IPLANET_SERVER}.sh
    chmod 750 ${IPLANET_HOME}/stop-${IPLANET_SERVER}.sh
fi
