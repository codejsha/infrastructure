#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

ADMIN_URL="t3://test.example.com:7001"
DOMAIN_HOME="/usr/local/weblogic/user_projects/domains/base_domain"
USERNAME="weblogic"
PASSWORD="welcome1"

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
${DOMAIN_HOME}/bin/stopWebLogic.sh ${USERNAME} ${PASSWORD} ${ADMIN_URL}
