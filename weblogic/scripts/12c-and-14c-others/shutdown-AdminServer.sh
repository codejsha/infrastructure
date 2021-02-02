#!/bin/bash

ORACLE_HOME="/usr/local/weblogic"
DOMAIN_NAME="base_domain"
export DOMAIN_HOME="${ORACLE_HOME}/user_projects/domains/${DOMAIN_NAME}"
export ADMIN_SERVER_URL="t3://test.example.com:7001"
export ADMIN_SERVER_NAME="AdminServer"

${ORACLE_HOME}/oracle_common/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/shutdown_${ADMIN_SERVER_NAME}.py