#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

WL_HOME="/usr/local/weblogic/wlserver_10.3"

PID="$(pgrep -xa java | grep ${WL_HOME} | grep NodeManager | awk '{print $1}')"
if [ -n "${PID}" ]; then
    kill -9 ${PID}
fi
