#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

### Usage:
### bash ./print-thread-dump.sh <PID>

PID="${1}"
JAVA_HOME="/usr/lib/jvm/java-11"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"

LOOP_COUNT="1"
INTERVAL_SECONDS="5"

if [ -z "${PID}" ]; then
    echo "Usage: bash ./print-thread-dump.sh <PID>"
    exit
fi

if [ -z "${JAVA_HOME}" ]; then
    echo "[ERROR] The JAVA_HOME (${JAVA_HOME}) does not exist!"
    exit
fi

for IDX in $(seq 1 ${LOOP_COUNT})
do
    ${JAVA_HOME}/bin/jstack -l ${PID} > threaddump-${PID}-${IDX}.tdump
    # ${JAVA_HOME}/bin/jcmd ${PID} Thread.print > threaddump-${PID}-${IDX}.tdump
    # kill -3 ${PID}

    sleep ${INTERVAL_SECONDS}
done
