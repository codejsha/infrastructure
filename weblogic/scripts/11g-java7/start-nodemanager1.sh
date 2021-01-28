#!/bin/bash

WL_HOME="/usr/local/weblogic/wlserver_10.3"
DOMAIN_HOME="/usr/local/weblogic/user_projects/domains/base_domain"
LOG_DIR="${DOMAIN_HOME}/logs"

CURRENT_USER="$(id -un)"
if [ "${CURRENT_USER}" == "root" ]; then
  echo "[ERROR] The current user is root!"
  exit
fi

PID="$(pgrep -xa java | grep ${WL_HOME} | grep NodeManager | awk '{print $1}')"
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
  mv ${LOG_DIR}/nohup.NodeManager.out ${LOG_DIR}/nodemanager/nohup.NodeManager.${GET_DATE}.out
fi
# if [ -f "${LOG_DIR}/gc.NodeManager.log" ]; then
#   mv ${LOG_DIR}/gc.NodeManager.log ${LOG_DIR}/nodemanager/gc.NodeManager.${GET_DATE}.log
# fi

touch ${LOG_DIR}/nohup.NodeManager.out
${WL_HOME}/server/bin/startNodeManager.sh >> ${LOG_DIR}/nohup.NodeManager.out 2>&1 &
tail -f ${LOG_DIR}/nohup.NodeManager.out
