#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

ORACLE_HOME="/usr/local/weblogic"
DOMAIN_NAME="base_domain"
export DOMAIN_HOME="${ORACLE_HOME}/user_projects/domains/${DOMAIN_NAME}"
export ADMIN_SERVER_URL="t3://test.example.com:7001"
export MANAGED_SERVER_NAME="ManagedServer2"

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
${ORACLE_HOME}/oracle_common/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/shutdown_${MANAGED_SERVER_NAME}.py
