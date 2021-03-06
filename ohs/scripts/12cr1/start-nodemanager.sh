#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

DOMAIN_HOME="/usr/local/ohs/user_projects/domains/base_domain"
LOG_DIR="${DOMAIN_HOME}/logs"
GET_DATE="$(date +'%Y%m%d_%H%M%S')"

PID="$(pgrep -xa java | grep ${DOMAIN_HOME} | grep NodeManager | awk '{print $1}')"
if [ -n "${PID}" ]; then
    echo "[ERROR] NodeManager (pid ${PID}) is already running!"
    exit
fi

if [ -f /usr/local/ohs/user_projects/domains/base_domain/logs/nohup.NodeManager.out ]; then
    mv /usr/local/ohs/user_projects/domains/base_domain/logs/nohup.NodeManager.out /usr/local/ohs/user_projects/domains/base_domain/logs/NodeManager/nohup.NodeManager.${GET_DATE}.out
fi

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"

touch /usr/local/ohs/user_projects/domains/base_domain/logs/nohup.NodeManager.out
nohup ${DOMAIN_HOME}/bin/startNodeManager.sh > /usr/local/ohs/user_projects/domains/base_domain/logs/nohup.NodeManager.out 2>&1 &
tail -f /usr/local/ohs/user_projects/domains/base_domain/logs/nohup.NodeManager.out
