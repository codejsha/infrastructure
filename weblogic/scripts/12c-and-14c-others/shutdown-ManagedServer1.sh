#!/bin/bash

ORACLE_HOME="/usr/local/weblogic"
export DOMAIN_HOME="${ORACLE_HOME}/user_projects/domains/base_domain"
export ADMIN_SERVER_URL="t3://test.example.com:7001"
export MANAGED_SERVER_NAME="ManagedServer1"

${ORACLE_HOME}/oracle_common/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/shutdown_${MANAGED_SERVER_NAME}.py
