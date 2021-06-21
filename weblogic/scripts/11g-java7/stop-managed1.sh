#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

SERVER_NAME="ManagedServer1"
ADMIN_URL="t3://test.example.com:7001"
DOMAIN_HOME="/usr/local/weblogic/user_projects/domains/base_domain"
USERNAME="weblogic"
PASSWORD="welcome1"

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
${DOMAIN_HOME}/bin/stopManagedWebLogic.sh ${SERVER_NAME} ${ADMIN_URL} ${USERNAME} ${PASSWORD}
