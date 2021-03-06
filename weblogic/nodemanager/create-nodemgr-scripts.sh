#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

NODEMGR_NAME="${1}"
NODEMGR_LISTEN_ADDRESS="${2}"
NODEMGR_LISTEN_PORT="${3}"

######################################################################

mkdir -p ${LOG_DIR}/nodemanager

######################################################################

### replace pattern with string
TEMP="\${DOMAIN_HOME}"
VAR_LOG_DIR="${LOG_DIR/${DOMAIN_HOME}/${TEMP}}"

FILE_NAME_SUFFIX="${NODEMGR_NAME,,}"
FILE_NAME_SUFFIX="${FILE_NAME_SUFFIX/base/}"
FILE_NAME_SUFFIX="${FILE_NAME_SUFFIX/machine/nodemanager}"

######################################################################

### create start script

if [[ ${WEBLOGIC_VERSION} =~ ^14.1|^12. ]]; then
cat <<EOF > ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
#!/bin/bash
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

DOMAIN_HOME="${DOMAIN_HOME}"
LOG_DIR="${VAR_LOG_DIR}"

PID="\$(pgrep -xa java | grep \${DOMAIN_HOME} | grep NodeManager | awk '{print \$1}')"
if [ -n "\${PID}" ]; then
    echo "[ERROR] The NodeManager (pid \${PID}) is already running!"
    exit
fi
EOF
elif [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
cat <<EOF > ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
#!/bin/bash
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

WL_HOME="${WL_HOME}"
DOMAIN_HOME="${DOMAIN_HOME}"
LOG_DIR="${VAR_LOG_DIR}"

CURRENT_USER="\$(id -un)"
if [ "\${CURRENT_USER}" == "root" ]; then
    echo "[ERROR] The current user is root!"
    exit
fi

PID="\$(pgrep -xa java | grep \${WL_HOME} | grep NodeManager | awk '{print \$1}')"
if [ -n "\${PID}" ]; then
    echo "[ERROR] The NodeManager (pid \${PID}) is already running!"
    exit
fi
EOF
fi

cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh

JAVA_OPTIONS="\${JAVA_OPTIONS} -DListenAddress=${NODEMGR_LISTEN_ADDRESS}"
JAVA_OPTIONS="\${JAVA_OPTIONS} -DListenPort=${NODEMGR_LISTEN_PORT}"
JAVA_OPTIONS="\${JAVA_OPTIONS} -DSecureListener=false"
JAVA_OPTIONS="\${JAVA_OPTIONS} -DCrashRecoveryEnabled=false"
JAVA_OPTIONS="\${JAVA_OPTIONS} -DLogFile=\${LOG_DIR}/nodemanager/machine.NodeManager.out"
JAVA_OPTIONS="\${JAVA_OPTIONS} -DLogLevel=INFO"
JAVA_OPTIONS="\${JAVA_OPTIONS} -DLogLimit=0"
JAVA_OPTIONS="\${JAVA_OPTIONS} -DLogCount=1"
export JAVA_OPTIONS

if [ -f "\${LOG_DIR}/nohup.NodeManager.out" ]; then
    mv \${LOG_DIR}/nohup.NodeManager.out \${LOG_DIR}/nodemanager/nohup.NodeManager.\${DATETIME}.out
fi
# if [ -f "\${LOG_DIR}/gc.NodeManager.log" ]; then
#     mv \${LOG_DIR}/gc.NodeManager.log \${LOG_DIR}/nodemanager/gc.NodeManager.\${DATETIME}.log
# fi

touch \${LOG_DIR}/nohup.NodeManager.out
EOF

if [[ ${WEBLOGIC_VERSION} =~ ^14.1|^12. ]]; then
cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
\${DOMAIN_HOME}/bin/startNodeManager.sh > \${LOG_DIR}/nohup.NodeManager.out 2>&1 &
EOF
elif [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
\${WL_HOME}/server/bin/startNodeManager.sh > \${LOG_DIR}/nohup.NodeManager.out 2>&1 &
EOF
fi

cat <<EOF >> ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
tail -f \${LOG_DIR}/nohup.NodeManager.out
EOF

######################################################################

### create stop script

if [[ ${WEBLOGIC_VERSION} =~ ^14.1|^12. ]]; then
cat <<EOF > ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
#!/bin/bash
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

DOMAIN_HOME="${DOMAIN_HOME}"

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${DOMAIN_HOME}/bin/stopNodeManager.sh
EOF
elif [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
cat <<EOF > ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
#!/bin/bash
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

WL_HOME="${WL_HOME}"

PID="\$(pgrep -xa java | grep \${WL_HOME} | grep NodeManager | awk '{print \$1}')"
if [ -n "\${PID}" ]; then
    kill -9 \${PID}
fi
EOF
fi

######################################################################

### change file permissions
chmod 750 ${DOMAIN_HOME}/start-${FILE_NAME_SUFFIX}.sh
chmod 750 ${DOMAIN_HOME}/stop-${FILE_NAME_SUFFIX}.sh
