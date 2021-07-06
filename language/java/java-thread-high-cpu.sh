#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

### Usage:
### bash ./java-thread-high-cpu.sh <PID>

PID="${1}"
JAVA_HOME="/usr/lib/jvm/java-11"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"

LOOP_COUNT="1"
TOP_THREAD_COUNT="5"
INTERVAL_SECONDS="5"

if [ -z "${PID}" ]; then
    echo "Usage: bash ./java-thread-high-cpu.sh <PID>"
    exit
fi

if [ -z "${JAVA_HOME}" ]; then
    echo "[ERROR] The JAVA_HOME (${JAVA_HOME}) does not exist!"
    exit
fi

for IDX1 in $(seq 1 ${LOOP_COUNT})
do
    echo "[INFO] Print ${IDX1} times..."
    ps -eLo pid,ppid,tid,pcpu,comm | grep ${PID} > ps-${PID}-${IDX1}.out
    ${JAVA_HOME}/bin/jstack -l ${PID} > threaddump-${PID}-${IDX1}.tdump
    top -b -n 1 -p ${PID} > top-${PID}-${IDX1}.out

    HIGH_CPU_THREADS=($(cat ps-${PID}-${IDX1}.out | awk '{ print $4" "$3 }' \
        | sort --reverse --numeric-sort | head --lines=${TOP_THREAD_COUNT} | awk '{ print $2 }'))
    for IDX2 in $(seq 0 $((${TOP_THREAD_COUNT} - 1)))
    do
        printf '0x%x\n' ${HIGH_CPU_THREADS[$IDX2]}
    done

    sleep ${INTERVAL_SECONDS}
done
