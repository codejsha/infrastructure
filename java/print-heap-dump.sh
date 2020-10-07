#!/usr/bin/bash

# usage:
# bash print-heap-dump.sh <PID>

PID="${1}"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"
JAVA_HOME="/usr/lib/jvm/java-11"

if [ -z "${PID}" ]; then
    echo "usage:  bash print-heap-dump.sh PID"
    exit
fi

if [ -z "${JAVA_HOME}" ]; then
    echo "ERROR: The JAVA_HOME (${JAVA_HOME}) does not exist!"
    exit
fi

${JAVA_HOME}/bin/jmap -dump:live,format=b,file=${PID}-heapdump.hprof ${PID}
# ${JAVA_HOME}/bin/jmap -dump:format=b,file=${PID}-heapdump.hprof ${PID}
# ${JAVA_HOME}/bin/jcmd ${PID} GC.heap_dump ${PID}-heapdump.hprof ${PID}
