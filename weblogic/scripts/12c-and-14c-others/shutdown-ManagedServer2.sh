#!/bin/bash

ORACLE_HOME="/usr/local/weblogic"
DOMAIN_NAME="base_domain"
export DOMAIN_HOME="${ORACLE_HOME}/user_projects/domains/${DOMAIN_NAME}"
export ADMIN_SERVER_URL="t3://test.example.com:7001"
export MANAGED_SERVER_NAME="ManagedServer2"

${ORACLE_HOME}/oracle_common/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/shutdown_${MANAGED_SERVER_NAME}.py