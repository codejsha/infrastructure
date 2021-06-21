#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o errexit
set -o errtrace
set -o xtrace

ORACLE_HOME="/usr/local/ohs"
DOMAIN_NAME="base_domain"
DOMAIN_HOME="${ORACLE_HOME}/user_projects/domains/${DOMAIN_NAME}"
COMPONENT_NAME="ohs1"

PRODUCT_HOME="${ORACLE_HOME}/ohs"
LD_LIBRARY_PATH="${ORACLE_HOME}/lib:${ORACLE_HOME}/ohs/lib:${ORACLE_HOME}/oracle_common/lib"
ORACLE_INSTANCE="${DOMAIN_HOME}"
COMPONENT_TYPE="OHS"
COMPONENT_CONFIG_PATH="${ORACLE_INSTANCE}/config/OHS/ohs1"
COMPONENT_LOG_PATH="${ORACLE_INSTANCE}/diagnostics/logs/OHS/ohs1"
CONFIG=${DOMAIN_HOME}/config/fmwconfig/components/${COMPONENT_TYPE}/instances/${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME PRODUCT_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_CONFIG_PATH COMPONENT_LOG_PATH COMPONENT_NAME CONFIG

${ORACLE_HOME}/ohs/bin/httpd.worker -f ${CONFIG} -v
