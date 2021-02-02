#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

ORACLE_HOME="/usr/local/weblogic"
DOMAIN_NAME="base_domain"
export DOMAIN_HOME="${ORACLE_HOME}/user_projects/domains/${DOMAIN_NAME}"
export ADMIN_SERVER_URL="t3://test.example.com:7001"
export ADMIN_USERNAME="${1:-"weblogic"}"
export ADMIN_PASSWORD="${2:-"welcome1"}"

${ORACLE_HOME}/oracle_common/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/change_store_user_config.py
