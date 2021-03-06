#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh

DOMAIN_HOME="${DOMAIN_HOME}"
LOG_DIR="${LOG_DIR}"

######################################################################

### replace pattern with string
TEMP="\${DOMAIN_HOME}"
VAR_LOG_DIR="${LOG_DIR/${DOMAIN_HOME}/${TEMP}}"

######################################################################

cat <<EOF > ${DOMAIN_HOME}/start-nodemanager.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: func \${FUNCNAME[0]}: status \${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

DOMAIN_HOME="${DOMAIN_HOME}"
LOG_DIR="${VAR_LOG_DIR}"
GET_DATE="\$(date +'%Y%m%d_%H%M%S')"

CURRENT_USER="\$(id -un)"
if [ "\${CURRENT_USER}" == "root" ]; then
    echo "[ERROR] The current user is root!"
    exit
fi

PID="\$(pgrep -xa java | grep \${DOMAIN_HOME} | grep NodeManager | awk '{print \$1}')"
if [ -n "\${PID}" ]; then
    echo "[ERROR] The NodeManager (pid ${PID}) is already running!"
    exit
fi

if [ -f "\${LOG_DIR}/nohup.NodeManager.out" ]; then
    mv \${LOG_DIR}/nohup.NodeManager.out \${LOG_DIR}/nodemanager/nohup.NodeManager.\${GET_DATE}.out
fi

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"

touch \${LOG_DIR}/nohup.NodeManager.out
nohup \${DOMAIN_HOME}/bin/startNodeManager.sh > \${LOG_DIR}/nohup.NodeManager.out 2>&1 &
tail -f \${LOG_DIR}/nohup.NodeManager.out
EOF

cat <<EOF > ${DOMAIN_HOME}/stop-nodemanager.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: func \${FUNCNAME[0]}: status \${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

DOMAIN_HOME="${DOMAIN_HOME}"

PID="\$(pgrep -xa java | grep \${DOMAIN_HOME} | grep NodeManager | awk '{print \$1}')"
kill -9 \${PID}
EOF

######################################################################

mkdir -p ${LOG_DIR}/nodemanager

chmod 750 ${DOMAIN_HOME}/start-nodemanager.sh
chmod 750 ${DOMAIN_HOME}/stop-nodemanager.sh
