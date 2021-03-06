#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

DOMAIN_HOME="/usr/local/weblogic/user_projects/domains/base_domain"

${DOMAIN_HOME}/bin/stopNodeManager.sh
