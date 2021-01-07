#!/bin/bash

source ./env-base.sh

NODEMGR_NAME="${1}"
NODEMGR_LISTEN_ADDRESS="${2}"
NODEMGR_LISTEN_PORT="${3}"

######################################################################

### replace pattern with string
FILE_NAME_SUFFIX="${NODEMGR_NAME,,}"
FILE_NAME_SUFFIX="${FILE_NAME_SUFFIX/base/}"
FILE_NAME_SUFFIX="${FILE_NAME_SUFFIX/machine/nodemanager}"

######################################################################

### start script

if [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
cat << EOF > ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
#!/bin/bash

WL_HOME="${WL_HOME}"
DOMAIN_HOME="${DOMAIN_HOME}"
LOG_DIR="${LOG_DIR}"

CURRENT_USER="\$(id -un)"
if [ "\${CURRENT_USER}" == "root" ]; then
  echo "[ERROR] The current user is root!"
  exit
fi

PID="\$(pgrep -xa java | grep \${WL_HOME} | grep NodeManager | awk '{print \$1}')"
if [ -n "\${PID}" ]; then
  echo "[ERROR] NodeManager (pid \${PID})" is already running!
  exit
fi
EOF
elif [[ ${WEBLOGIC_VERSION} =~ ^12.|^14.1 ]]; then
cat << EOF > ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
#!/bin/bash

DOMAIN_HOME="${DOMAIN_HOME}"
LOG_DIR="${LOG_DIR}"

PID="\$(pgrep -xa java | grep \${DOMAIN_HOME} | grep NodeManager | awk '{print \$1}')"
if [ -n "\${PID}" ]; then
  echo "[ERROR] NodeManager (pid \${PID})" is already running!
  exit
fi
EOF
fi

cat << EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
JAVA_OPTIONS="\${JAVA_OPTIONS} -DListenAddress=${NODEMGR_LISTEN_ADDRESS}"
JAVA_OPTIONS="\${JAVA_OPTIONS} -DListenPort=${NODEMGR_LISTEN_PORT}"
JAVA_OPTIONS="\${JAVA_OPTIONS} -DSecureListener=false"
JAVA_OPTIONS="\${JAVA_OPTIONS} -DLogFile=\${LOG_DIR}/nodemanager/machine.NodeManager.out"
export JAVA_OPTIONS

if [ -f "\${LOG_DIR}/nohup.NodeManager.out" ]; then
  mv \${LOG_DIR}/nohup.NodeManager.out \${LOG_DIR}/nodemanager/nohup.NodeManager.\${GET_DATE}.out
fi
if [ -f "\${LOG_DIR}/gc.NodeManager.log" ]; then
  mv \${LOG_DIR}/gc.NodeManager.log \${LOG_DIR}/nodemanager/gc.NodeManager.\${GET_DATE}.log
fi
touch \${LOG_DIR}/nohup.NodeManager.out
EOF

if [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
cat << EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
\${WL_HOME}/server/bin/startNodeManager.sh >> \${LOG_DIR}/nohup.NodeManager.out 2>&1 &
EOF
elif [[ ${WEBLOGIC_VERSION} =~ ^12.|^14.1 ]]; then
cat << EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
\${DOMAIN_HOME}/bin/startNodeManager.sh >> \${LOG_DIR}/nohup.NodeManager.out 2>&1 &
EOF
fi

cat << EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
tail -f \${LOG_DIR}/nohup.NodeManager.out
EOF

######################################################################

### stop script

if [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
cat << EOF > ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
#!/bin/bash

WL_HOME="${WL_HOME}"

PID="\$(pgrep -xa java | grep \${WL_HOME} | grep NodeManager | awk '{print \$1}')"
if [ -n "\${PID}" ]; then
  kill -9 \${PID}
fi
EOF
elif [[ ${WEBLOGIC_VERSION} =~ ^12.|^14.1 ]]; then
cat << EOF > ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
#!/bin/bash

DOMAIN_HOME="${DOMAIN_HOME}"

\${DOMAIN_HOME}/bin/stopNodeManager.sh
EOF
fi

######################################################################

chmod 750 ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
chmod 750 ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
