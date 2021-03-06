#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

MW_HOME="/usr/local/weblogic"
export DOMAIN_HOME="${MW_HOME}/user_projects/domains/base_domain"
export ADMIN_SERVER_URL="t3://test.example.com:7001"
export ADMIN_SERVER_NAME="AdminServer"

${MW_HOME}/wlserver_10.3/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/shutdown_${ADMIN_SERVER_NAME}.py
