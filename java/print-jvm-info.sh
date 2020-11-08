#!/usr/bin/bash

# usage:
# bash ./print-jvm-info.sh <PID>

PID="${1}"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"
JAVA_HOME="/usr/lib/jvm/java-11"

if [ -z "${PID}" ]; then
    echo "Usage: bash ./print-jvm-info.sh PID"
    exit
fi

if [ -z "${JAVA_HOME}" ]; then
    echo "[ERROR] The JAVA_HOME (${JAVA_HOME}) does not exist!"
    exit
fi

${JAVA_HOME}/bin/jinfo ${PID}
# ${JAVA_HOME}/bin/jhsdb jinfo --pid ${PID}
