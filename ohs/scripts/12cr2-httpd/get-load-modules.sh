#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="/usr/local/ohs"
DOMAIN_NAME="base_domain"
DOMAIN_HOME="${ORACLE_HOME}/user_projects/domains/${DOMAIN_NAME}"
COMPONENT_NAME="ohs1"

PRODUCT_HOME="${ORACLE_HOME}/ohs"
LD_LIBRARY_PATH="${ORACLE_HOME}/lib:${ORACLE_HOME}/ohs/lib:${ORACLE_HOME}/oracle_common/lib"
ORACLE_INSTANCE="${DOMAIN_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=${DOMAIN_HOME}/config/fmwconfig/components/${COMPONENT_TYPE}/instances/${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME PRODUCT_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

# ${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f ${CONFIG} -M
${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f ${CONFIG} -t -D DUMP_MODULES
