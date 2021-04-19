#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

DOMAIN_HOME="/usr/local/weblogic/user_projects/domains/base_domain"
LOG_DIR="${DOMAIN_HOME}/logs"

PID="$(pgrep -xa java | grep ${DOMAIN_HOME} | grep NodeManager | awk '{print $1}')"
if [ -n "${PID}" ]; then
    echo "[ERROR] The NodeManager (pid ${PID}) is already running!"
    exit
fi

JAVA_OPTIONS="${JAVA_OPTIONS} -DListenAddress=test.example.com"
JAVA_OPTIONS="${JAVA_OPTIONS} -DListenPort=5556"
JAVA_OPTIONS="${JAVA_OPTIONS} -DSecureListener=false"
JAVA_OPTIONS="${JAVA_OPTIONS} -DCrashRecoveryEnabled=false"
JAVA_OPTIONS="${JAVA_OPTIONS} -DLogFile=${LOG_DIR}/nodemanager/machine.NodeManager.out"
JAVA_OPTIONS="${JAVA_OPTIONS} -DLogLevel=INFO"
JAVA_OPTIONS="${JAVA_OPTIONS} -DLogLimit=0"
JAVA_OPTIONS="${JAVA_OPTIONS} -DLogCount=1"
export JAVA_OPTIONS

if [ -f "${LOG_DIR}/nohup.NodeManager.out" ]; then
    mv ${LOG_DIR}/nohup.NodeManager.out ${LOG_DIR}/nodemanager/nohup.NodeManager.${DATETIME}.out
fi
# if [ -f "${LOG_DIR}/gc.NodeManager.log" ]; then
#     mv ${LOG_DIR}/gc.NodeManager.log ${LOG_DIR}/nodemanager/gc.NodeManager.${DATETIME}.log
# fi

touch ${LOG_DIR}/nohup.NodeManager.out
${DOMAIN_HOME}/bin/startNodeManager.sh > ${LOG_DIR}/nohup.NodeManager.out 2>&1 &
tail -f ${LOG_DIR}/nohup.NodeManager.out
