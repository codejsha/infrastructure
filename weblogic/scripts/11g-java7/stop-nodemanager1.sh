#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

WL_HOME="/usr/local/weblogic/wlserver_10.3"

PID="$(pgrep -xa java | grep ${WL_HOME} | grep NodeManager | awk '{print $1}')"
if [ -n "${PID}" ]; then
    kill -9 ${PID}
fi
