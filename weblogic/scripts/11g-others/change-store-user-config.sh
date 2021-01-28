#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

MW_HOME="/usr/local/weblogic"
export DOMAIN_HOME="${MW_HOME}/user_projects/domains/base_domain"
export ADMIN_SERVER_URL="t3://test.example.com:7001"
export ADMIN_USERNAME="${1:-"weblogic"}"
export ADMIN_PASSWORD="${2:-"welcome1"}"

${MW_HOME}/wlserver_10.3/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/change_store_user_config.py
