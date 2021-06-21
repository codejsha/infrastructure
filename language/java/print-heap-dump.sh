#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

### Usage:
### bash ./print-heap-dump.sh <PID>

PID="${1}"
JAVA_HOME="/usr/lib/jvm/java-11"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"

if [ -z "${PID}" ]; then
    echo "Usage: bash ./print-heap-dump.sh <PID>"
    exit
fi

if [ -z "${JAVA_HOME}" ]; then
    echo "[ERROR] The JAVA_HOME (${JAVA_HOME}) does not exist!"
    exit
fi

${JAVA_HOME}/bin/jmap -dump:live,format=b,file=${PID}-heapdump.hprof ${PID}
# ${JAVA_HOME}/bin/jmap -dump:format=b,file=${PID}-heapdump.hprof ${PID}
# ${JAVA_HOME}/bin/jcmd GC.heap_dump ${PID}-heapdump.hprof ${PID}
