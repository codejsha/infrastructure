#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

ORACLE_HOME="/usr/local/ohs/oracle_wt1"
INSTANCE_NAME="instance1"
INSTANCE_HOME="/usr/local/ohs/oracle_wt1/instances/${INSTANCE_NAME}"
COMPONENT_NAME="ohs1"

LD_LIBRARY_PATH="${ORACLE_HOME}/lib:${ORACLE_HOME}/ohs/lib"
ORACLE_INSTANCE="${INSTANCE_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=${INSTANCE_HOME}/config/${COMPONENT_TYPE}/${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f ${CONFIG} -t -D DUMP_INCLUDES
