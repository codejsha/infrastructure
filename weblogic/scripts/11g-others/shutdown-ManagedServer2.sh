#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -o xtrace

MW_HOME="/usr/local/weblogic"
export DOMAIN_HOME="${MW_HOME}/user_projects/domains/base_domain"
export ADMIN_SERVER_URL="t3://test.example.com:7001"
export MANAGED_SERVER_NAME="ManagedServer2"

${MW_HOME}/wlserver_10.3/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/shutdown_${MANAGED_SERVER_NAME}.py
