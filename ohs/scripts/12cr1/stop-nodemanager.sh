#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o errexit
set -o errtrace
set -o xtrace

DOMAIN_HOME="/usr/local/ohs/user_projects/domains/base_domain"

PID="$(pgrep -xa java | grep ${DOMAIN_HOME} | grep NodeManager | awk '{print $1}')"
kill -9 ${PID}
