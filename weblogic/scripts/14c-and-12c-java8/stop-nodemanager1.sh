#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

DOMAIN_HOME="/usr/local/weblogic/user_projects/domains/base_domain"

export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
${DOMAIN_HOME}/bin/stopNodeManager.sh
